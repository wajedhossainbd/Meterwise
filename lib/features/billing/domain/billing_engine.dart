import 'models/billing_input.dart';
import 'models/billing_result.dart';
import 'models/tariff.dart';

/// Pure-Dart hybrid billing engine (v2.1) — the heart of MeterWise.
///
/// It is intentionally free of Flutter and Drift: plain value objects in
/// ([BillingInput]), plain value objects out ([MonthlyBill]).
///
/// ### Algorithm
///
/// 1. **Consumption** — `billedUnits_i = mainUnits × usageShare_i` (a tenant's
///    own units plus their proportional share of common-area units).
/// 2. **Shared slab (default, spreadsheet rule)** — every shared tenant
///    receives an **equal share of every slab**: the per-tenant slab
///    boundaries are the original cumulative upper bounds ÷ sharedCount
///    (floored). Each shared tenant walks that per-tenant ladder
///    *independently* with only their own billed units, and the open-ended
///    top slab absorbs the remainder. With 2 shared tenants on
///    0–75/76–200/201–300/301–400/401–600/601+ each tenant's slab shares are
///    37/63/50/50/100/∞. There is **no** building-bill proration and **no**
///    post-hoc cost redistribution.
/// 3. **Fixed-rate tenants** pay `billedUnits × fixedRate`, all-inclusive.
///    They never consume slab capacity and are excluded from the divisor.
/// 4. **Fixed charges** (demand charge, meter rent) and the month's recharge
///    fees/expenses are split among shared tenants Equal (default) or ByUsage
///    per [BillingInput.distribution]; VAT − rebate apply on each tenant's
///    FULL subtotal (energy + fixed charges + expense share), per the
///    reference spreadsheet.
/// 5. **Recharges** credit the payer's ledger with `amount + fees` (their real
///    money out); fees are pooled into the month's expenses (step 4).
/// 6. **Settlements** move balance from payer to receiver, net zero.
///
/// [MonthlyBill.buildingBill] still reports what the utility actually charges
/// the building (informational; used by summaries).
class BillingEngine {
  const BillingEngine();

  MonthlyBill calculate(BillingInput input) {
    final tariff = input.tariff;
    final mainUnits = input.mainMeter.consumption;

    final tenantOwnUnits = <int, double>{
      for (final t in input.tenants) t.tenantId: t.consumption,
    };
    final totalTenantUnits =
        tenantOwnUnits.values.fold<double>(0, (a, b) => a + b);
    final commonUnits =
        (mainUnits - totalTenantUnits).clamp(0, double.infinity).toDouble();

    final tenantCount = input.tenants.length;
    double usageShare(int tenantId) {
      final own = tenantOwnUnits[tenantId] ?? 0;
      return totalTenantUnits > 0
          ? own / totalTenantUnits
          : (tenantCount > 0 ? 1 / tenantCount : 0.0);
    }

    // ---- 1. The building's actual bill -------------------------------------
    final totalFees =
        input.recharges.fold<double>(0, (a, b) => a + b.fees);
    final buildingEnergy = energyCharge(mainUnits, tariff);
    final buildingSubtotal =
        buildingEnergy + tariff.demandCharge + tariff.meterRent;
    final buildingVat = buildingSubtotal * tariff.vatPercent / 100;
    final buildingRebate = buildingSubtotal * tariff.rebatePercent / 100;
    final buildingBill =
        buildingSubtotal + buildingVat - buildingRebate + totalFees;

    // ---- 3. Fixed-rate tenants ---------------------------------------------
    final fixed = input.tenants
        .where((t) => t.mode == TenantBillingMode.fixed)
        .toList();
    final shared = input.tenants
        .where((t) => t.mode != TenantBillingMode.fixed)
        .toList();

    final billedUnitsOf = <int, double>{
      for (final t in input.tenants) t.tenantId: mainUnits * usageShare(t.tenantId),
    };

    final fixedCharges = <int, double>{
      for (final t in fixed)
        t.tenantId: billedUnitsOf[t.tenantId]! * (t.fixedRate ?? 0),
    };

    // ---- 4/5. Shared-slab tenants: EQUAL SLAB SHARES (spreadsheet rule) ------
    // Each shared tenant receives an equal share of every slab: the per-tenant
    // slab boundaries are the original cumulative upper bounds ÷ sharedCount
    // (floored to whole units, exactly as the reference spreadsheet does).
    // Every shared tenant walks that per-tenant ladder independently with only
    // their own billed units; the open-ended top slab absorbs the remainder.
    // Fixed-rate tenants never consume slab capacity and are excluded from the
    // divisor. The lifeline tariff is an eligibility tariff and is NOT divided.
    final sharedCount = shared.length;

    final sharedBilledTotal = shared.fold<double>(
        0, (a, t) => a + billedUnitsOf[t.tenantId]!);
    double fixedWeight(int tenantId) {
      if (shared.isEmpty) return 0;
      if (input.distribution == FixedChargeDistribution.byUsage &&
          sharedBilledTotal > 0) {
        return billedUnitsOf[tenantId]! / sharedBilledTotal;
      }
      return 1 / shared.length;
    }

    final sharedTotals = <int, double>{};
    final sharedBreakdowns = <int, List<SlabAllocation>>{};
    final components = <int, _SharedComponents>{};

    if (input.calcMode == BillingCalcMode.sharedSlab) {
      for (final t in shared) {
        final units = billedUnitsOf[t.tenantId]!;
        final w = fixedWeight(t.tenantId);
        final breakdown = ladderBreakdown(units, tariff, share: sharedCount);
        final energy = energyCharge(units, tariff, share: sharedCount);
        final fixedShare = (tariff.demandCharge + tariff.meterRent) * w;
        final expenseShare = totalFees * w;
        // Per the reference spreadsheet, VAT and rebate apply to the FULL
        // subtotal: energy + fixed charges + expense share.
        final vatBase = energy + fixedShare + expenseShare;
        final vat = vatBase * tariff.vatPercent / 100;
        final rebate = vatBase * tariff.rebatePercent / 100;
        sharedTotals[t.tenantId] =
            energy + fixedShare + expenseShare + vat - rebate;
        sharedBreakdowns[t.tenantId] = breakdown;
        components[t.tenantId] = _SharedComponents(
          energy: energy,
          demand: tariff.demandCharge * w,
          rent: tariff.meterRent * w,
          expense: expenseShare,
          vat: vat,
          rebate: rebate,
        );
      }
    } else {
      // RECONCILED / FIXED-RATE modes: fixed tenants collected first, then the
      // REMAINING actual main-meter bill is distributed among shared tenants
      // in proportion to usage. Guarantees Σ tenant bills == buildingBill and
      // gives every shared tenant the same effective average rate.
      final fixedTotal =
          fixedCharges.values.fold<double>(0, (a, b) => a + b);
      final remaining =
          (buildingBill - fixedTotal).clamp(0, double.infinity).toDouble();
      for (final t in shared) {
        final units = billedUnitsOf[t.tenantId]!;
        final weight = sharedBilledTotal > 0
            ? units / sharedBilledTotal
            : 1 / shared.length;
        final chargeShare = remaining * weight;
        sharedTotals[t.tenantId] = chargeShare;
        // One line at the effective average rate — component charges are
        // already inside the building bill, so they aren't itemised again.
        sharedBreakdowns[t.tenantId] = [
          SlabAllocation(
            fromUnit: 0,
            rate: units > 0 ? chargeShare / units : 0,
            units: units,
            amount: chargeShare,
          ),
        ];
        components[t.tenantId] = _SharedComponents.energyOnly(chargeShare);
      }
    }

    // ---- 6/7. Recharge credits & settlements --------------------------------
    double rechargePaidOf(String name) => input.recharges
        .where((r) => input.poolAllRecharges || _payerMatches(r.paidBy, name))
        .fold<double>(0, (a, b) => a + b.actualPaid);
    double rechargeFeesOf(String name) => input.recharges
        .where((r) => input.poolAllRecharges || _payerMatches(r.paidBy, name))
        .fold<double>(0, (a, b) => a + b.fees);
    double settlementsPaidOf(int id) => input.settlements
        .where((s) => s.fromTenantId == id)
        .fold<double>(0, (a, b) => a + b.amount);
    double settlementsReceivedOf(int id) => input.settlements
        .where((s) => s.toTenantId == id)
        .fold<double>(0, (a, b) => a + b.amount);

    // ---- Assemble per-tenant bills ------------------------------------------
    final tenantBills = <TenantBill>[];
    for (final t in input.tenants) {
      final units = billedUnitsOf[t.tenantId]!;
      final own = tenantOwnUnits[t.tenantId]!;
      final isFixed = t.mode == TenantBillingMode.fixed;

      final List<SlabAllocation> slabBreakdown;
      final _SharedComponents c;
      final double totalBill;

      if (isFixed) {
        final charge = fixedCharges[t.tenantId]!;
        slabBreakdown = [
          SlabAllocation(
            fromUnit: 0,
            rate: t.fixedRate ?? 0,
            units: units,
            amount: charge,
          ),
        ];
        c = const _SharedComponents.zero();
        totalBill = charge;
      } else {
        // Original slab labels with this tenant's share of units in each slab
        // (matching the reference spreadsheet's presentation).
        slabBreakdown = sharedBreakdowns[t.tenantId]!;
        c = components[t.tenantId]!;
        totalBill = sharedTotals[t.tenantId]!;
      }

      tenantBills.add(
        TenantBill(
          tenantId: t.tenantId,
          tenantName: t.tenantName,
          previousReading: t.previous,
          currentReading: t.current,
          ownUnits: own,
          commonUnits: (units - own).clamp(0, double.infinity).toDouble(),
          billedUnits: units,
          slabBreakdown: slabBreakdown,
          energyCost: isFixed ? totalBill : c.energy,
          demandCharge: c.demand,
          meterRent: c.rent,
          vat: c.vat,
          rebate: c.rebate,
          totalBill: totalBill,
          rechargePaid: rechargePaidOf(t.tenantName),
          rechargeFeesPaid: rechargeFeesOf(t.tenantName),
          previousBalance: input.openingBalances[t.tenantId] ?? 0,
          settlementsPaid: settlementsPaidOf(t.tenantId),
          settlementsReceived: settlementsReceivedOf(t.tenantId),
          billingMode: isFixed ? 'fixed' : 'shared',
          fixedRate: isFixed ? t.fixedRate : null,
          expenseShare: c.expense,
        ),
      );
    }

    final totalRecharge =
        input.recharges.fold<double>(0, (a, b) => a + b.actualPaid);

    // Owner Benefit exists only in Shared-Slab (Landlord) mode: what tenants
    // collectively pay above (or below) the actual main-meter bill.
    final totalBilled =
        tenantBills.fold<double>(0, (a, b) => a + b.totalBill);
    final ownerBenefit = input.calcMode == BillingCalcMode.sharedSlab
        ? totalBilled - buildingBill
        : 0.0;

    return MonthlyBill(
      mainMeterUnits: mainUnits,
      totalTenantUnits: totalTenantUnits,
      commonAreaUnits: commonUnits,
      tenantBills: tenantBills,
      totalRecharge: totalRecharge,
      buildingBill: buildingBill,
      totalExpenses: totalFees,
      calcMode: input.calcMode.code,
      ownerBenefit: ownerBenefit,
    );
  }

  /// Energy charge for [units] under [tariff], where the tenant holds a
  /// 1/[share] equal share of every slab (spreadsheet rule; `share == 1` for
  /// the whole meter / a single shared tenant).
  ///
  /// The lifeline tariff is an **eligibility** tariff, not the first ladder
  /// step: if `units ≤ lifelineUpTo`, ALL units are charged at the lifeline
  /// rate; otherwise the lifeline is ignored completely and billing walks the
  /// progressive ladder from its first slab (e.g. 0–75 @ 5.26). The lifeline
  /// threshold is never divided by [share].
  double energyCharge(double units, Tariff tariff, {int share = 1}) {
    if (tariff.lifelineUpTo != null &&
        tariff.lifelineRate != null &&
        units > 0 &&
        units <= tariff.lifelineUpTo!) {
      return units * tariff.lifelineRate!;
    }
    return ladderBreakdown(units, tariff, share: share)
        .fold<double>(0, (a, b) => a + b.amount);
  }

  /// Walks [units] through the (ascending) slab ladder, returning the per-slab
  /// breakdown labeled with the ORIGINAL slab ranges.
  ///
  /// With `share == 1`, capacity is derived from consecutive upper bounds
  /// (`0–75` holds 75 units, `76–200` holds 125, …). With `share == N`
  /// (N shared tenants), each tenant's boundaries are the original cumulative
  /// upper bounds ÷ N, floored to whole units — exactly the reference
  /// spreadsheet: for N = 2 on 75/200/300/400/600 the per-tenant boundaries
  /// are 37/100/150/200/300, i.e. slab shares 37/63/50/50/100 with the
  /// open-ended top slab absorbing the remainder.
  List<SlabAllocation> ladderBreakdown(double units, Tariff tariff,
      {int share = 1}) {
    final sorted = [...tariff.slabs]
      ..sort((a, b) => a.fromUnit.compareTo(b.fromUnit));
    final result = <SlabAllocation>[];
    var previousBound = 0.0;
    var remaining = units;

    for (final slab in sorted) {
      final double bound;
      if (slab.toUnit == null) {
        bound = double.infinity;
      } else if (share <= 1) {
        bound = slab.toUnit!.toDouble();
      } else {
        bound = (slab.toUnit! / share).floorToDouble();
      }
      final capacity = bound - previousBound;
      final inSlab =
          remaining <= 0 ? 0.0 : (remaining < capacity ? remaining : capacity);
      result.add(SlabAllocation(
        fromUnit: slab.fromUnit,
        toUnit: slab.toUnit,
        rate: slab.rate,
        units: inSlab,
        amount: inSlab * slab.rate,
      ));
      remaining -= inSlab;
      if (bound.isFinite) previousBound = bound;
    }
    return result;
  }

  /// Recharges are attributed to a tenant when the free-text "paid by" name
  /// matches the tenant's name (trimmed, case-insensitive). Unmatched recharges
  /// (e.g. paid by the landlord) simply don't count toward any tenant's credit.
  bool _payerMatches(String? paidBy, String tenantName) {
    if (paidBy == null) return false;
    return paidBy.trim().toLowerCase() == tenantName.trim().toLowerCase();
  }
}

/// Internal: notional charge components for a shared tenant.
class _SharedComponents {
  const _SharedComponents({
    required this.energy,
    required this.demand,
    required this.rent,
    required this.expense,
    required this.vat,
    required this.rebate,
  });

  const _SharedComponents.zero()
      : energy = 0,
        demand = 0,
        rent = 0,
        expense = 0,
        vat = 0,
        rebate = 0;

  /// Reconciled modes: the whole share is presented as one energy amount
  /// (components are already inside the building bill).
  const _SharedComponents.energyOnly(this.energy)
      : demand = 0,
        rent = 0,
        expense = 0,
        vat = 0,
        rebate = 0;

  final double energy;
  final double demand;
  final double rent;
  final double expense;
  final double vat;
  final double rebate;
}
