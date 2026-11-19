import 'package:freezed_annotation/freezed_annotation.dart';

import 'tariff.dart';

part 'billing_input.freezed.dart';

/// How an individual tenant's charge is calculated (v2 hybrid engine).
enum TenantBillingMode {
  /// Default. The tenant's units walk the slab ladder individually (so every
  /// tenant enjoys the cheap lower slabs), then the building's *actual* bill
  /// remainder is allocated in proportion to these notional amounts.
  shared,

  /// The tenant pays a negotiated flat price per unit (all-inclusive).
  fixed,
}

/// How building-level fixed charges (demand charge, meter rent, recharge fees
/// and other expenses) are split among shared-slab tenants.
enum FixedChargeDistribution {
  /// Default: split equally per tenant (e.g. meter rent 40 → 20 / 20).
  equal,

  /// Split in proportion to billed units.
  byUsage,
}

/// Property-level billing CALCULATION mode (chosen in Settings, snapshotted
/// when a month is finalized).
enum BillingCalcMode {
  /// **Shared Slab (Landlord Mode)** — default. Each shared tenant is billed
  /// independently on the divided slab ladder (spreadsheet rule). The total
  /// collected may EXCEED the actual main-meter bill: the difference is the
  /// **Owner Benefit** (or Loss), shown to the owner only — never on tenant
  /// invoices.
  sharedSlab,

  /// **Reconciled (Weighted Average)** — the actual main-meter bill, minus
  /// fixed-rate collections, is distributed among shared tenants in
  /// proportion to usage. Guarantees Σ tenant bills == main-meter bill; every
  /// shared tenant pays the same effective average rate.
  reconciled,

  /// **Fixed Rate** — per-tenant fixed rates are collected first; the
  /// remaining actual bill is allocated to shared tenants by usage. Also
  /// reconciles exactly. (Same arithmetic as [reconciled]; differs in intent
  /// and dashboard presentation.)
  fixedRate,
}

/// String codes stored in settings and snapshots.
extension BillingCalcModeCode on BillingCalcMode {
  String get code => switch (this) {
        BillingCalcMode.sharedSlab => 'sharedSlab',
        BillingCalcMode.reconciled => 'reconciled',
        BillingCalcMode.fixedRate => 'fixedRate',
      };

  static BillingCalcMode fromCode(String? code) => switch (code) {
        'reconciled' => BillingCalcMode.reconciled,
        'fixedRate' => BillingCalcMode.fixedRate,
        _ => BillingCalcMode.sharedSlab,
      };
}

/// A previous/current cumulative reading pair for a single meter.
@freezed
abstract class MeterReadingPair with _$MeterReadingPair {
  const MeterReadingPair._();

  const factory MeterReadingPair({
    required double previous,
    required double current,
  }) = _MeterReadingPair;

  /// Consumption over the period. Never negative (a meter cannot run backwards;
  /// a lower current reading is treated as zero consumption rather than a
  /// negative bill).
  double get consumption => (current - previous).clamp(0, double.infinity);
}

/// One tenant's reading pair plus identity and billing contract.
@freezed
abstract class TenantReadingInput with _$TenantReadingInput {
  const TenantReadingInput._();

  const factory TenantReadingInput({
    required int tenantId,
    required String tenantName,
    required double previous,
    required double current,
    @Default(TenantBillingMode.shared) TenantBillingMode mode,

    /// Flat per-unit price; required when [mode] is [TenantBillingMode.fixed].
    double? fixedRate,
  }) = _TenantReadingInput;

  double get consumption => (current - previous).clamp(0, double.infinity);
}

/// A recharge as seen by the engine.
///
/// [amount] is the energy credit (what landed on the meter); [fees] are the
/// extra out-of-pocket charges (agent fee, other expenses). The payer's ledger
/// is credited `amount + fees` (their actual money out), while the month's
/// total fees are redistributed to all tenants as an expense.
@freezed
abstract class RechargeInput with _$RechargeInput {
  const RechargeInput._();

  const factory RechargeInput({
    required double amount,
    @Default(0) double fees,
    String? paidBy,
    int? paidByTenantId,
  }) = _RechargeInput;

  /// What actually left the payer's pocket.
  double get actualPaid => amount + fees;
}

/// A tenant-to-tenant settlement as seen by the engine: [fromTenantId] pays
/// [toTenantId] [amount] directly, adjusting each one's balance.
@freezed
abstract class SettlementInput with _$SettlementInput {
  const factory SettlementInput({
    required int fromTenantId,
    required int toTenantId,
    required double amount,
  }) = _SettlementInput;
}

/// The complete, self-contained input to [BillingEngine.calculate].
@freezed
abstract class BillingInput with _$BillingInput {
  const factory BillingInput({
    required Tariff tariff,
    required MeterReadingPair mainMeter,
    required List<TenantReadingInput> tenants,
    @Default(<RechargeInput>[]) List<RechargeInput> recharges,
    @Default(<SettlementInput>[]) List<SettlementInput> settlements,

    /// How fixed charges + expenses are split among shared tenants.
    @Default(FixedChargeDistribution.equal) FixedChargeDistribution distribution,

    /// The property-level calculation mode (see [BillingCalcMode]).
    @Default(BillingCalcMode.sharedSlab) BillingCalcMode calcMode,

    /// Carry-in prepaid balance per tenant (tenantId → amount) from prior
    /// periods. Computed by the application layer; the engine just folds it into
    /// each tenant's available balance.
    @Default(<int, double>{}) Map<int, double> openingBalances,

    /// When true (single-meter mode), every recharge is attributed to the one
    /// account regardless of the "paid by" name.
    @Default(false) bool poolAllRecharges,
  }) = _BillingInput;
}
