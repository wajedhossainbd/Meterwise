import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../readings/data/reading_repository.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../../settlements/data/settlement_repository.dart';
import '../../tariff/data/tariff_version_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/billing_period_repository.dart';
import '../domain/billing_engine.dart';
import '../domain/models/billing_input.dart';
import '../domain/models/billing_result.dart';
import '../domain/models/tariff.dart';

part 'billing_providers.g.dart';

/// Synthetic tenant id used for the single owner account in single-meter mode.
const int kOwnerAccountId = -1;

/// Per-month billing configuration resolved from the active tariff version and
/// current settings (used for draft months).
typedef MonthConfig = ({
  Tariff tariff,
  FixedChargeDistribution distribution,
  BillingCalcMode calcMode,
});

/// A month's computed/finalized view, including its accounting status.
class PeriodView {
  const PeriodView({
    required this.month,
    required this.status,
    this.periodId,
    this.finalizedAt,
    this.tariffVersionId,
    this.bill,
    this.availableBalance = 0,
    this.carryForward = 0,
  });

  final DateTime month;
  final PeriodStatus status;
  final int? periodId;
  final DateTime? finalizedAt;
  final int? tariffVersionId;
  final MonthlyBill? bill;
  final double availableBalance;
  final double carryForward;

  bool get isFinalized => status == PeriodStatus.finalized;
}

/// Compatibility record consumed by the dashboard.
typedef BillingMonthData = ({
  MonthlyBill? bill,
  double availableBalance,
  double carryForward,
});

/// One month's headline figures, for the dashboard charts.
class MonthlySummary {
  const MonthlySummary({
    required this.month,
    required this.units,
    required this.recharge,
    required this.billed,
    required this.rate,
  });

  final DateTime month;
  final double units;
  final double recharge;
  final double billed;

  /// Canonical average selling rate from the engine (bill / main-meter units).
  /// The dashboard chart must use this, never recompute its own definition.
  final double rate;
}

/// The billing month the user is currently viewing (normalized to the 1st).
@riverpod
class BillingMonth extends _$BillingMonth {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month);
  }

  void setMonth(DateTime month) => state = DateTime(month.year, month.month);
  void previousMonth() => state = DateTime(state.year, state.month - 1);
  void nextMonth() => state = DateTime(state.year, state.month + 1);
}

/// Loads all billing inputs once. Null when there's no main meter / readings.
@riverpod
Future<BillingContext?> billingContext(Ref ref) async {
  final settings = await ref.watch(appSettingsProvider.future);
  final mainMeter = await ref.watch(currentMainMeterProvider.future);
  if (mainMeter == null) return null;

  final property = await ref.watch(currentPropertyProvider.future);
  final tenants = await ref.watch(tenantListProvider.future);
  final readings = await ref.watch(readingListProvider.future);
  final recharges = await ref.watch(rechargeListProvider.future);
  final settlements = await ref.watch(settlementListProvider.future);
  if (readings.isEmpty) return null;

  return BillingContext(
    multiTenant: settings?.multiTenant ?? true,
    ownerName: property?.name ?? 'Me',
    mainMeterId: mainMeter.id,
    tenants: tenants,
    readings: readings,
    recharges: recharges,
    settlements: settlements,
  );
}

/// Computes the view for the selected month: a finalized period returns its
/// immutable snapshot; a draft period is computed live, opening from the last
/// finalized period's closing balances.
@riverpod
Future<PeriodView> periodView(Ref ref) async {
  final month = ref.watch(billingMonthProvider);
  final property = await ref.watch(currentPropertyProvider.future);
  if (property == null) {
    return PeriodView(month: month, status: PeriodStatus.draft);
  }

  final periodRepo = ref.watch(billingPeriodRepositoryProvider);
  final period =
      await periodRepo.getOrCreate(property.id, month.year, month.month);

  // Finalized → return the immutable snapshot, never recompute.
  if (period.status == 'finalized') {
    final snap = periodRepo.snapshotOf(period);
    return PeriodView(
      month: month,
      status: PeriodStatus.finalized,
      periodId: period.id,
      finalizedAt: period.finalizedAt,
      tariffVersionId: period.tariffVersionId,
      bill: snap,
      availableBalance: snap?.totalAvailable ?? 0,
      carryForward: snap?.totalCarryForward ?? 0,
    );
  }

  // Draft → compute live.
  final ctx = await ref.watch(billingContextProvider.future);
  if (ctx == null) {
    return PeriodView(
        month: month, status: PeriodStatus.draft, periodId: period.id);
  }

  final settings = await ref.watch(appSettingsProvider.future);
  final distribution = (settings?.fixedChargeDistribution ?? 'equal') == 'usage'
      ? FixedChargeDistribution.byUsage
      : FixedChargeDistribution.equal;
  final calcMode =
      BillingCalcModeCode.fromCode(settings?.billingCalcMode);
  final tariffRepo = ref.watch(tariffVersionRepositoryProvider);

  Future<MonthConfig> configFor(DateTime m) async => (
        tariff: await tariffRepo.tariffForDate(DateTime(m.year, m.month, 1)),
        distribution: distribution,
        calcMode: calcMode,
      );

  // Opening balances: start from the last finalized period's closing balances,
  // then walk live through any draft months in between.
  final opening = <int, double>{};
  final lastFinal =
      await periodRepo.latestFinalizedBefore(property.id, month.year, month.month);
  DateTime cursor;
  if (lastFinal != null) {
    final snap = periodRepo.snapshotOf(lastFinal);
    if (snap != null) {
      for (final tb in snap.tenantBills) {
        opening[tb.tenantId] = tb.balance;
      }
    }
    cursor = DateTime(lastFinal.year, lastFinal.month + 1);
  } else {
    cursor = ctx.firstMonth;
  }

  while (cursor.isBefore(month)) {
    final cfg = await configFor(cursor);
    final bill = ctx.billForMonth(cursor, const {}, cfg);
    if (bill != null) {
      // tb.balance (with empty opening) is this month's net, already including
      // recharges and settlements.
      for (final tb in bill.tenantBills) {
        opening[tb.tenantId] = (opening[tb.tenantId] ?? 0) + tb.balance;
      }
    } else {
      ctx.attributeRecharges(cursor).forEach((id, amt) {
        opening[id] = (opening[id] ?? 0) + amt;
      });
      ctx.settlementNet(cursor).forEach((id, amt) {
        opening[id] = (opening[id] ?? 0) + amt;
      });
    }
    cursor = DateTime(cursor.year, cursor.month + 1);
  }

  final bill = ctx.billForMonth(month, opening, await configFor(month));
  if (bill != null) {
    return PeriodView(
      month: month,
      status: PeriodStatus.draft,
      periodId: period.id,
      bill: bill,
      availableBalance: bill.totalAvailable,
      carryForward: bill.totalCarryForward,
    );
  }

  final openSum = opening.values.fold<double>(0, (a, b) => a + b);
  final rechargeSum =
      ctx.attributeRecharges(month).values.fold<double>(0, (a, b) => a + b);
  // Settlements net to zero across tenants, so they don't change the total
  // available; included per-account elsewhere.
  final available = openSum + rechargeSum;
  return PeriodView(
    month: month,
    status: PeriodStatus.draft,
    periodId: period.id,
    availableBalance: available,
    carryForward: available,
  );
}

@riverpod
Future<BillingMonthData> billingMonthData(Ref ref) async {
  final v = await ref.watch(periodViewProvider.future);
  return (
    bill: v.bill,
    availableBalance: v.availableBalance,
    carryForward: v.carryForward,
  );
}

/// The selected month's bill (null when there isn't enough data to bill).
@riverpod
Future<MonthlyBill?> monthlyBill(Ref ref) async =>
    (await ref.watch(periodViewProvider.future)).bill;

/// Last [count] months of headline figures (oldest first) for the charts.
/// Finalized months use their snapshot; drafts compute live.
@riverpod
Future<List<MonthlySummary>> monthlyHistory(Ref ref, {int count = 6}) async {
  final selected = ref.watch(billingMonthProvider);
  final property = await ref.watch(currentPropertyProvider.future);
  final ctx = await ref.watch(billingContextProvider.future);
  if (property == null || ctx == null) return const [];

  final periodRepo = ref.watch(billingPeriodRepositoryProvider);
  final tariffRepo = ref.watch(tariffVersionRepositoryProvider);
  final settings = await ref.watch(appSettingsProvider.future);
  final distribution = (settings?.fixedChargeDistribution ?? 'equal') == 'usage'
      ? FixedChargeDistribution.byUsage
      : FixedChargeDistribution.equal;
  final calcMode =
      BillingCalcModeCode.fromCode(settings?.billingCalcMode);

  final summaries = <MonthlySummary>[];
  for (var i = count - 1; i >= 0; i--) {
    final month = DateTime(selected.year, selected.month - i);
    final existing = await periodRepo.find(property.id, month.year, month.month);
    MonthlyBill? bill;
    if (existing?.status == 'finalized') {
      bill = periodRepo.snapshotOf(existing!);
    } else {
      final tariff =
          await tariffRepo.tariffForDate(DateTime(month.year, month.month, 1));
      bill = ctx.billForMonth(
        month,
        const {},
        (tariff: tariff, distribution: distribution, calcMode: calcMode),
      );
    }
    summaries.add(
      MonthlySummary(
        month: month,
        units: bill?.mainMeterUnits ?? 0,
        recharge: ctx.rechargeTotal(month),
        billed: bill?.totalBilled ?? 0,
        rate: bill?.averageSellingRate ?? 0,
      ),
    );
  }
  return summaries;
}

/// Holds the loaded inputs and the per-month billing computation.
class BillingContext {
  BillingContext({
    required this.multiTenant,
    required this.ownerName,
    required this.mainMeterId,
    required this.tenants,
    required this.readings,
    required this.recharges,
    required this.settlements,
  });

  final bool multiTenant;
  final String ownerName;
  final int mainMeterId;
  final List<Tenant> tenants;
  final List<MeterReading> readings;
  final List<Recharge> recharges;
  final List<Settlement> settlements;

  static const _engine = BillingEngine();

  DateTime get firstMonth {
    final first = readings
        .map((r) => r.readingDate)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    return DateTime(first.year, first.month);
  }

  double rechargeTotal(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    return _rechargesInMonth(start, end).fold<double>(0, (a, b) => a + b.amount);
  }

  /// Computes the bill for [month] using [config], or null if there is no
  /// closing reading.
  MonthlyBill? billForMonth(
    DateTime month,
    Map<int, double> openingBalances,
    MonthConfig config,
  ) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);

    final mainPair = _pairFor(
      readings.where((r) => r.mainMeterId == mainMeterId),
      start,
      end,
    );
    if (mainPair == null) return null;

    final List<TenantReadingInput> tenantInputs;
    if (multiTenant) {
      tenantInputs = [
        for (final t in tenants)
          () {
            final pair = _pairFor(
                  readings.where((r) => r.tenantId == t.id),
                  start,
                  end,
                ) ??
                const MeterReadingPair(previous: 0, current: 0);
            return TenantReadingInput(
              tenantId: t.id,
              tenantName: t.name,
              previous: pair.previous,
              current: pair.current,
              mode: t.billingMode == 'fixed'
                  ? TenantBillingMode.fixed
                  : TenantBillingMode.shared,
              fixedRate: t.fixedRate,
            );
          }(),
      ];
    } else {
      tenantInputs = [
        TenantReadingInput(
          tenantId: kOwnerAccountId,
          tenantName: ownerName,
          previous: mainPair.previous,
          current: mainPair.current,
        ),
      ];
    }

    final periodRecharges = [
      for (final r in _rechargesInMonth(start, end))
        RechargeInput(
          amount: r.amount,
          fees: r.agentFee + r.otherExpenses,
          paidBy: r.paidBy,
          paidByTenantId: r.paidByTenantId,
        ),
    ];
    final periodSettlements = [
      for (final s in _settlementsInMonth(start, end))
        SettlementInput(
          fromTenantId: s.fromTenantId,
          toTenantId: s.toTenantId,
          amount: s.amount,
        ),
    ];

    return _engine.calculate(
      BillingInput(
        tariff: config.tariff,
        mainMeter: mainPair,
        tenants: tenantInputs,
        recharges: periodRecharges,
        settlements: periodSettlements,
        distribution: config.distribution,
        calcMode: config.calcMode,
        openingBalances: openingBalances,
        poolAllRecharges: !multiTenant,
      ),
    );
  }

  /// Net settlement adjustment per tenant for [month] (paid − received), used
  /// to accumulate balances in months that have no bill.
  Map<int, double> settlementNet(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    final map = <int, double>{};
    for (final s in _settlementsInMonth(start, end)) {
      map[s.fromTenantId] = (map[s.fromTenantId] ?? 0) + s.amount;
      map[s.toTenantId] = (map[s.toTenantId] ?? 0) - s.amount;
    }
    return map;
  }

  Iterable<Settlement> _settlementsInMonth(DateTime start, DateTime end) =>
      settlements.where((s) =>
          s.mainMeterId == mainMeterId &&
          !s.settlementDate.isBefore(start) &&
          s.settlementDate.isBefore(end));

  /// Recharges in [month] attributed per account (for months with no bill).
  Map<int, double> attributeRecharges(DateTime month) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);
    final recs = _rechargesInMonth(start, end);
    final map = <int, double>{};
    if (!multiTenant) {
      map[kOwnerAccountId] = recs.fold<double>(
          0, (a, b) => a + b.amount + b.agentFee + b.otherExpenses);
      return map;
    }
    for (final r in recs) {
      final tenant = tenants.firstWhereOrNull(
        (t) =>
            r.paidBy != null &&
            t.name.trim().toLowerCase() == r.paidBy!.trim().toLowerCase(),
      );
      if (tenant != null) {
        map[tenant.id] =
            (map[tenant.id] ?? 0) + r.amount + r.agentFee + r.otherExpenses;
      }
    }
    return map;
  }

  Iterable<Recharge> _rechargesInMonth(DateTime start, DateTime end) =>
      recharges.where((r) =>
          r.mainMeterId == mainMeterId &&
          !r.rechargeDate.isBefore(start) &&
          r.rechargeDate.isBefore(end));
}

/// Selects the previous/current reading for a billing period:
/// `current` = latest reading within `[start, end)`; `previous` = latest reading
/// before that closing reading's date.
MeterReadingPair? _pairFor(
  Iterable<MeterReading> meterReadings,
  DateTime start,
  DateTime end,
) {
  final all = meterReadings.toList()
    ..sort((a, b) => a.readingDate.compareTo(b.readingDate));

  final within = all
      .where((r) => !r.readingDate.isBefore(start) && r.readingDate.isBefore(end))
      .toList();
  if (within.isEmpty) return null;
  final closing = within.last;

  final before =
      all.where((r) => r.readingDate.isBefore(closing.readingDate)).toList();
  final previous =
      before.isNotEmpty ? before.last.readingValue : closing.readingValue;

  return MeterReadingPair(previous: previous, current: closing.readingValue);
}
