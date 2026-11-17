import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../readings/data/reading_repository.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../../tariff/data/tariff_version_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/billing_period_repository.dart';
import 'billing_providers.dart';

/// Finalize / unlock / validate actions for the selected billing month.
///
/// Finalization freezes the computed bill into an immutable snapshot; unlocking
/// reverts a period to draft for editing. Validation explains exactly why a
/// month cannot be finalized.
class PeriodActions {
  PeriodActions(this._ref);

  final Ref _ref;

  /// Returns a list of human-readable problems blocking finalization. Empty
  /// means the month is ready to finalize.
  Future<List<String>> validate(AppLocalizations l) async {
    final errors = <String>[];
    final month = _ref.read(billingMonthProvider);
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);

    final property = await _ref.read(currentPropertyProvider.future);
    if (property == null) return [l.validateNoProperty];
    final mainMeter = await _ref.read(currentMainMeterProvider.future);
    if (mainMeter == null) return [l.validateNoMeter];

    final readings = await _ref.read(readingListProvider.future);
    final recharges = await _ref.read(rechargeListProvider.future);
    final tenants = await _ref.read(tenantListProvider.future);
    final multiTenant = _ref.read(isMultiTenantProvider);

    bool inMonth(DateTime d) => !d.isBefore(start) && d.isBefore(end);

    final mainInMonth = readings
        .where((r) => r.mainMeterId == mainMeter.id && inMonth(r.readingDate))
        .toList()
      ..sort((a, b) => a.readingDate.compareTo(b.readingDate));

    if (mainInMonth.isEmpty) {
      errors.add(l.validateNoClosingReading);
    } else {
      // Duplicate readings (same date twice).
      final dates = mainInMonth.map((r) => r.readingDate).toList();
      if (dates.toSet().length != dates.length) {
        errors.add(l.validateDuplicateReading);
      }

      final closing = mainInMonth.last;
      final beforeClosing = readings
          .where((r) =>
              r.mainMeterId == mainMeter.id &&
              r.readingDate.isBefore(closing.readingDate))
          .toList()
        ..sort((a, b) => a.readingDate.compareTo(b.readingDate));

      if (beforeClosing.isEmpty) {
        errors.add(l.validateNoOpeningReading);
      } else if (closing.readingValue <= beforeClosing.last.readingValue) {
        errors.add(l.validateClosingNotGreater(
          Formatters.units(closing.readingValue),
          Formatters.units(beforeClosing.last.readingValue),
        ));
      }
    }

    if (multiTenant) {
      for (final t in tenants) {
        final tIn = readings
            .where((r) => r.tenantId == t.id && inMonth(r.readingDate))
            .toList()
          ..sort((a, b) => a.readingDate.compareTo(b.readingDate));
        if (tIn.isEmpty) continue;
        final closing = tIn.last;
        final before = readings
            .where((r) =>
                r.tenantId == t.id &&
                r.readingDate.isBefore(closing.readingDate))
            .toList()
          ..sort((a, b) => a.readingDate.compareTo(b.readingDate));
        if (before.isNotEmpty &&
            closing.readingValue < before.last.readingValue) {
          errors.add(l.validateTenantLowerReading(t.name));
        }
      }
    }

    final monthRecharges = recharges.where(
        (r) => r.mainMeterId == mainMeter.id && inMonth(r.rechargeDate));
    if (monthRecharges.any((r) => r.amount <= 0)) {
      errors.add(l.validateRechargeAmount);
    }

    // Fixed-rate tenants must actually have a rate.
    if (multiTenant) {
      for (final t in tenants) {
        if (t.billingMode == 'fixed' &&
            (t.fixedRate == null || t.fixedRate! <= 0)) {
          errors.add(l.validateFixedRateMissing(t.name));
        }
      }
    }

    // Calculation must succeed.
    final view = await _ref.read(periodViewProvider.future);
    if (view.bill == null && errors.isEmpty) {
      errors.add(l.validateBillCompute);
    }

    return errors;
  }

  /// Validates then finalizes. Returns blocking errors (empty ⇒ finalized).
  Future<List<String>> finalize(AppLocalizations l) async {
    final errors = await validate(l);
    if (errors.isNotEmpty) return errors;

    final month = _ref.read(billingMonthProvider);
    final property = (await _ref.read(currentPropertyProvider.future))!;
    final view = await _ref.read(periodViewProvider.future);
    if (view.bill == null) return [l.validateBillCompute];

    final periodRepo = _ref.read(billingPeriodRepositoryProvider);
    final period =
        await periodRepo.getOrCreate(property.id, month.year, month.month);
    final tariffVersion = await _ref
        .read(tariffVersionRepositoryProvider)
        .activeVersionForDate(DateTime(month.year, month.month, 1));
    final settings = await _ref.read(appSettingsProvider.future);
    final method = settings?.billingCalcMode ?? 'sharedSlab';
    final currency = _ref.read(currencyCodeProvider);

    await periodRepo.finalize(
      id: period.id,
      bill: view.bill!,
      tariffVersionId: tariffVersion?.id,
      billingMethod: method,
      currency: currency,
    );
    _invalidate();
    return [];
  }

  Future<void> unlock() async {
    final month = _ref.read(billingMonthProvider);
    final property = await _ref.read(currentPropertyProvider.future);
    if (property == null) return;
    final periodRepo = _ref.read(billingPeriodRepositoryProvider);
    final period =
        await periodRepo.find(property.id, month.year, month.month);
    if (period != null) {
      await periodRepo.unlock(period.id);
      _invalidate();
    }
  }

  /// Whether the period containing [date] is finalized (locked / read-only).
  Future<bool> isFinalizedOn(DateTime date) async {
    final property = await _ref.read(currentPropertyProvider.future);
    if (property == null) return false;
    return _ref
        .read(billingPeriodRepositoryProvider)
        .isFinalized(property.id, date.year, date.month);
  }

  void _invalidate() {
    _ref.invalidate(periodViewProvider);
    _ref.invalidate(monthlyHistoryProvider);
  }
}

final periodActionsProvider = Provider<PeriodActions>((ref) => PeriodActions(ref));
