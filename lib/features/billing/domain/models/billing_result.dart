import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing_result.freezed.dart';
part 'billing_result.g.dart';

/// How many units of a tenant's bill fell into a given tariff slab, and the
/// resulting charge. Produced by proportional slab allocation.
@freezed
abstract class SlabAllocation with _$SlabAllocation {
  const factory SlabAllocation({
    required int fromUnit,
    required double rate,
    required double units,
    required double amount,
    int? toUnit,
  }) = _SlabAllocation;

  factory SlabAllocation.fromJson(Map<String, dynamic> json) =>
      _$SlabAllocationFromJson(json);
}

/// The fully computed bill for a single tenant for one period.
@freezed
abstract class TenantBill with _$TenantBill {
  const TenantBill._();

  const factory TenantBill({
    required int tenantId,
    required String tenantName,
    required double previousReading,
    required double currentReading,

    /// Units measured directly on the tenant's sub-meter.
    required double ownUnits,

    /// Common-area units allocated to this tenant (proportional share).
    required double commonUnits,

    /// [ownUnits] + [commonUnits] — the units this tenant is billed for.
    required double billedUnits,
    required List<SlabAllocation> slabBreakdown,
    required double energyCost,
    required double demandCharge,
    required double meterRent,
    required double vat,
    required double rebate,

    /// Net amount owed by the tenant before recharge reconciliation.
    required double totalBill,

    /// Total recharges attributed to this tenant (matched by payer name).
    required double rechargePaid,

    /// Prepaid balance carried in from previous periods (can be negative for a
    /// past-due tenant).
    @Default(0) double previousBalance,

    /// Settlements this tenant PAID to other tenants this period (improves
    /// their balance — reduces their due).
    @Default(0) double settlementsPaid,

    /// Settlements this tenant RECEIVED from other tenants this period (reduces
    /// their credit).
    @Default(0) double settlementsReceived,

    // ---- v2 hybrid-engine fields (defaulted so v1 snapshots still decode) ----

    /// 'shared' or 'fixed' — the contract used for this bill.
    @Default('shared') String billingMode,

    /// The negotiated per-unit price (fixed-rate tenants only).
    double? fixedRate,

    /// This tenant's share of the month's recharge fees / other expenses.
    @Default(0) double expenseShare,

    /// Reconciliation between the notional per-tenant slab bill and the
    /// building's actual bill: positive means this tenant pays a bit more than
    /// their own ladder walk (slab-sharing loss), negative a bit less.
    @Default(0) double sharedAdjustment,

    /// Portion of [rechargePaid] that was fees rather than energy credit.
    @Default(0) double rechargeFeesPaid,
  }) = _TenantBill;

  factory TenantBill.fromJson(Map<String, dynamic> json) =>
      _$TenantBillFromJson(json);

  /// Prepaid funds available this period: carry-in + recharges + net settlement.
  double get availableBalance =>
      previousBalance + rechargePaid - settlementsPaid + settlementsReceived;

  /// Effective average cost per billed unit — what this tenant actually pays.
  double get effectiveRate => billedUnits > 0 ? totalBill / billedUnits : 0;

  /// Energy credit portion of [rechargePaid] (excluding fees).
  double get rechargeEnergyCredit => rechargePaid - rechargeFeesPaid;

  /// Carry-out balance: what remains (or is owed) after this period's bill.
  /// Positive ⇒ credit carried forward, negative ⇒ amount due.
  double get balance => availableBalance - totalBill;

  bool get isCredit => balance >= 0;
}

/// The aggregate result of computing a month's bills for one main meter.
@freezed
abstract class MonthlyBill with _$MonthlyBill {
  const MonthlyBill._();

  const factory MonthlyBill({
    required double mainMeterUnits,
    required double totalTenantUnits,
    required double commonAreaUnits,
    required List<TenantBill> tenantBills,
    required double totalRecharge,

    // ---- v2 fields (defaulted so v1 snapshots still decode) ----

    /// The building's actual utility bill (energy + fixed charges + VAT −
    /// rebate + expenses).
    @Default(0) double buildingBill,

    /// Recharge fees + other expenses recorded this month.
    @Default(0) double totalExpenses,

    // ---- v3 calc-mode fields (defaulted so older snapshots still decode) ----

    /// Calculation mode this bill was computed with ('sharedSlab' |
    /// 'reconciled' | 'fixedRate'). Snapshotted on finalize so historical
    /// months render under their original rules.
    @Default('sharedSlab') String calcMode,

    /// Shared-Slab (Landlord) mode only: Σ tenant bills − actual main-meter
    /// bill. Positive = Owner Benefit, negative = Owner Loss. Always 0 in the
    /// reconciled modes. Owner-facing ONLY — never shown on tenant invoices.
    @Default(0) double ownerBenefit,
  }) = _MonthlyBill;

  factory MonthlyBill.fromJson(Map<String, dynamic> json) =>
      _$MonthlyBillFromJson(json);

  /// Total collected from FIXED-rate tenants this month.
  double get fixedCollections => tenantBills.fold(
      0, (sum, b) => b.billingMode == 'fixed' ? sum + b.totalBill : sum);

  /// Total billed to SHARED tenants this month.
  double get sharedCollections => totalBilled - fixedCollections;

  /// Owner's average buy price per unit (what DPDC charges).
  double get averageUnitCost =>
      mainMeterUnits > 0 ? buildingBill / mainMeterUnits : 0;

  /// Owner's average sell price per unit (what tenants pay).
  double get averageSellingRate =>
      mainMeterUnits > 0 ? totalBilled / mainMeterUnits : 0;

  /// Tenant collections as a percentage of the actual main-meter bill.
  double get collectionPercent =>
      buildingBill > 0 ? totalBilled / buildingBill * 100 : 0;

  /// Sum of all tenants' [TenantBill.totalBill].
  double get totalBilled =>
      tenantBills.fold(0, (sum, b) => sum + b.totalBill);

  /// Prepaid funds available this month across all accounts
  /// (carry-in + this month's recharges).
  double get totalAvailable =>
      tenantBills.fold(0, (sum, b) => sum + b.availableBalance);

  /// Total balance carried forward to next month (credits minus dues).
  double get totalCarryForward =>
      tenantBills.fold(0, (sum, b) => sum + b.balance);

  /// Sum of outstanding dues across tenants (negative balances), as a positive
  /// number. Zero if everyone is in credit.
  double get totalOutstanding => tenantBills.fold(
        0,
        (sum, b) => b.balance < 0 ? sum + (-b.balance) : sum,
      );
}
