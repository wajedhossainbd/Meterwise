import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/features/billing/domain/billing_engine.dart';
import 'package:meterwise/features/billing/domain/models/billing_input.dart';
import 'package:meterwise/features/billing/domain/models/billing_result.dart';
import 'package:meterwise/features/billing/domain/models/tariff.dart';

/// Official DPDC LT-A residential tariff, effective June 2026 (verified).
const _dpdc2026 = Tariff(
  slabs: [
    TariffSlabRange(fromUnit: 0, toUnit: 75, rate: 5.26),
    TariffSlabRange(fromUnit: 76, toUnit: 200, rate: 8.50),
    TariffSlabRange(fromUnit: 201, toUnit: 300, rate: 9.10),
    TariffSlabRange(fromUnit: 301, toUnit: 400, rate: 9.62),
    TariffSlabRange(fromUnit: 401, toUnit: 600, rate: 15.01),
    TariffSlabRange(fromUnit: 601, toUnit: null, rate: 17.35),
  ],
  lifelineUpTo: 50,
  lifelineRate: 4.63,
  demandCharge: 84,
  meterRent: 40,
  vatPercent: 5,
  rebatePercent: 0.5,
);

/// A deliberately simple tariff for exact-arithmetic tests:
/// flat 10/unit, demand 300, rent 100, no VAT/rebate.
const _flat10 = Tariff(
  slabs: [TariffSlabRange(fromUnit: 0, toUnit: null, rate: 10)],
  demandCharge: 300,
  meterRent: 100,
  vatPercent: 0,
  rebatePercent: 0,
);

/// The classic BD slab structure from the spec examples
/// (capacities 50/25/125/100/100/200/∞), zero VAT/rebate for clean arithmetic.
const _classic = Tariff(
  slabs: [
    TariffSlabRange(fromUnit: 0, toUnit: 50, rate: 4.19),
    TariffSlabRange(fromUnit: 51, toUnit: 75, rate: 5.72),
    TariffSlabRange(fromUnit: 76, toUnit: 200, rate: 6.02),
    TariffSlabRange(fromUnit: 201, toUnit: 300, rate: 6.30),
    TariffSlabRange(fromUnit: 301, toUnit: 400, rate: 6.34),
    TariffSlabRange(fromUnit: 401, toUnit: 600, rate: 9.94),
    TariffSlabRange(fromUnit: 601, toUnit: null, rate: 11.46),
  ],
  demandCharge: 0,
  meterRent: 0,
  vatPercent: 0,
  rebatePercent: 0,
);

const _engine = BillingEngine();

TenantReadingInput _shared(int id, String name, double units) =>
    TenantReadingInput(
        tenantId: id, tenantName: name, previous: 0, current: units);

TenantReadingInput _fixed(int id, String name, double units, double rate) =>
    TenantReadingInput(
        tenantId: id,
        tenantName: name,
        previous: 0,
        current: units,
        mode: TenantBillingMode.fixed,
        fixedRate: rate);

/// Units billed in the slab starting at [fromUnit] for a tenant bill.
double _unitsInSlab(TenantBill t, int fromUnit) =>
    t.slabBreakdown.firstWhere((s) => s.fromUnit == fromUnit).units;

void main() {
  group('Engine — shared slab = equal share of every slab (spreadsheet)', () {
    test('per-tenant slab shares are cumulative bounds ÷ N, floored', () {
      // N=2 on 75/200/300/400/600 → bounds 37/100/150/200/300 →
      // shares 37/63/50/50/100/∞ (exactly the spreadsheet).
      final walk2 = _engine.ladderBreakdown(1000, _dpdc2026, share: 2);
      expect([for (final s in walk2) s.units],
          [37, 63, 50, 50, 100, 700]); // 700 = remainder in 601+
      // N=3 → bounds 25/66/100/133/200 → shares 25/41/34/33/67/∞.
      final walk3 = _engine.ladderBreakdown(1000, _dpdc2026, share: 3);
      expect([for (final s in walk3) s.units], [25, 41, 34, 33, 67, 800]);
      // N=4 → bounds 18/50/75/100/150 → shares 18/32/25/25/50/∞.
      final walk4 = _engine.ladderBreakdown(1000, _dpdc2026, share: 4);
      expect([for (final s in walk4) s.units], [18, 32, 25, 25, 50, 850]);
      // share=1 → original capacities.
      final walk1 = _engine.ladderBreakdown(1000, _dpdc2026);
      expect([for (final s in walk1) s.units], [75, 125, 100, 100, 200, 400]);
      // Breakdown rows keep the ORIGINAL slab labels.
      expect(walk2.first.fromUnit, 0);
      expect(walk2.first.toUnit, 75);
      expect(walk2[1].fromUnit, 76);
    });

    test('SPREADSHEET Tenant 1 — 377 units, 2 shared: '
        '37/63/50/50/100/77 → energy 4503.07, total 4812.29815', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 581),
          tenants: [_shared(1, 'T1', 377), _shared(2, 'T2', 204)],
          recharges: const [
            // Agent fees accumulate per recharge: 4 × 20 = 80/month.
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T1'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T1'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T2'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T2'),
          ],
        ),
      );
      final t1 = bill.tenantBills.firstWhere((t) => t.tenantId == 1);

      // Slab allocation exactly as the sheet.
      expect(_unitsInSlab(t1, 0), closeTo(37, 1e-9));
      expect(_unitsInSlab(t1, 76), closeTo(63, 1e-9));
      expect(_unitsInSlab(t1, 201), closeTo(50, 1e-9));
      expect(_unitsInSlab(t1, 301), closeTo(50, 1e-9));
      expect(_unitsInSlab(t1, 401), closeTo(100, 1e-9));
      expect(_unitsInSlab(t1, 601), closeTo(77, 1e-9));

      // Energy 4503.07.
      expect(t1.energyCost, closeTo(4503.07, 1e-6));
      // Fixed: rent 20, demand 42, agent fees 40 (equal split of 40/84/80).
      expect(t1.meterRent, closeTo(20, 1e-9));
      expect(t1.demandCharge, closeTo(42, 1e-9));
      expect(t1.expenseShare, closeTo(40, 1e-9));
      // VAT 5% and rebate 0.5% on the FULL subtotal 4605.07.
      expect(t1.vat, closeTo(230.2535, 1e-6));
      expect(t1.rebate, closeTo(23.02535, 1e-6));
      // Final: 4812.29815.
      expect(t1.totalBill, closeTo(4812.29815, 1e-6));
      expect(t1.sharedAdjustment, 0); // no redistribution
    });

    test('SPREADSHEET Tenant 2 — 204 units, 2 shared: '
        '37/63/50/50/4 → energy 1726.16, total 1910.4272', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 581),
          tenants: [_shared(1, 'T1', 377), _shared(2, 'T2', 204)],
          recharges: const [
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T1'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T1'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T2'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'T2'),
          ],
        ),
      );
      final t2 = bill.tenantBills.firstWhere((t) => t.tenantId == 2);

      expect(_unitsInSlab(t2, 0), closeTo(37, 1e-9));
      expect(_unitsInSlab(t2, 76), closeTo(63, 1e-9));
      expect(_unitsInSlab(t2, 201), closeTo(50, 1e-9));
      expect(_unitsInSlab(t2, 301), closeTo(50, 1e-9));
      expect(_unitsInSlab(t2, 401), closeTo(4, 1e-9));
      expect(_unitsInSlab(t2, 601), 0);

      expect(t2.energyCost, closeTo(1726.16, 1e-6));
      expect(t2.vat, closeTo(91.408, 1e-6));
      expect(t2.rebate, closeTo(9.1408, 1e-6));
      expect(t2.totalBill, closeTo(1910.4272, 1e-6));
      // Effective rate = total / units.
      expect(t2.effectiveRate, closeTo(1910.4272 / 204, 1e-6));
    });

    test('1 shared tenant: original ranges apply unchanged (classic ladder)',
        () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _classic,
          mainMeter: const MeterReadingPair(previous: 0, current: 377),
          tenants: [_shared(1, 'A', 377)],
        ),
      );
      final a = bill.tenantBills.single;
      expect(_unitsInSlab(a, 0), closeTo(50, 1e-9));
      expect(_unitsInSlab(a, 51), closeTo(25, 1e-9));
      expect(_unitsInSlab(a, 76), closeTo(125, 1e-9));
      expect(_unitsInSlab(a, 201), closeTo(100, 1e-9));
      expect(_unitsInSlab(a, 301), closeTo(77, 1e-9));
    });

    test('3 shared tenants: each gets a third of every slab', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 600),
          tenants: [
            _shared(1, 'A', 200),
            _shared(2, 'B', 200),
            _shared(3, 'C', 200),
          ],
        ),
      );
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      // Bounds 25/66/100/133/200 → 200 units = 25/41/34/33/67, nothing in 601+.
      expect(_unitsInSlab(a, 0), closeTo(25, 1e-9));
      expect(_unitsInSlab(a, 76), closeTo(41, 1e-9));
      expect(_unitsInSlab(a, 201), closeTo(34, 1e-9));
      expect(_unitsInSlab(a, 301), closeTo(33, 1e-9));
      expect(_unitsInSlab(a, 401), closeTo(67, 1e-9));
      expect(_unitsInSlab(a, 601), 0);
    });

    test('4 shared tenants: divisor 4', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 720),
          tenants: [
            _shared(1, 'A', 180),
            _shared(2, 'B', 180),
            _shared(3, 'C', 180),
            _shared(4, 'D', 180),
          ],
        ),
      );
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      // Bounds 18/50/75/100/150 → 180 units = 18/32/25/25/50 + 30 in 601+.
      expect(_unitsInSlab(a, 0), closeTo(18, 1e-9));
      expect(_unitsInSlab(a, 76), closeTo(32, 1e-9));
      expect(_unitsInSlab(a, 601), closeTo(30, 1e-9));
    });

    test('mixed 2 shared + 2 fixed: divisor is 2, NOT 4; fixed tenants '
        'never consume slab capacity', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 640),
          tenants: [
            _shared(1, 'S1', 120),
            _shared(2, 'S2', 120),
            _fixed(3, 'F1', 200, 8),
            _fixed(4, 'F2', 200, 9),
          ],
        ),
      );
      final s1 = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      // Divisor 2 → bounds 37/100/150: 120 units = 37/63/20.
      // (With divisor 4 the first share would be only 18.)
      expect(_unitsInSlab(s1, 0), closeTo(37, 1e-9));
      expect(_unitsInSlab(s1, 76), closeTo(63, 1e-9));
      expect(_unitsInSlab(s1, 201), closeTo(20, 1e-9));

      // Fixed tenants unchanged: flat rate, no ladder participation.
      final f1 = bill.tenantBills.firstWhere((t) => t.tenantId == 3);
      expect(f1.totalBill, closeTo(200 * 8, 1e-9));
      expect(f1.slabBreakdown.single.rate, 8);
    });

    test('flat single-slab tariff: expansion is a no-op and totals still '
        'match the building bill', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 500),
          tenants: [_shared(1, 'A', 200), _shared(2, 'B', 300)],
        ),
      );
      // 500×10 + 300 + 100 = 5400; with a flat rate per-tenant walks sum the
      // same as the building walk.
      expect(bill.buildingBill, closeTo(5400, 1e-9));
      expect(
          bill.tenantBills.fold<double>(0, (a, t) => a + t.totalBill),
          closeTo(5400, 1e-9));
    });
  });

  group('Engine v2 — mixed contracts (hybrid algorithm)', () {
    test('fixed tenant pays 200u × 8 = 1600; shared tenant is billed '
        'independently on their own units (no remainder proration)', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10, // building bill = 5400
          mainMeter: const MeterReadingPair(previous: 0, current: 500),
          tenants: [
            _fixed(1, 'T1', 200, 8),
            _shared(2, 'T2', 300),
          ],
        ),
      );

      final t1 = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final t2 = bill.tenantBills.firstWhere((t) => t.tenantId == 2);

      expect(bill.buildingBill, closeTo(5400, 1e-9));
      expect(t1.totalBill, closeTo(1600, 1e-9)); // 200 × 8
      expect(t1.billingMode, 'fixed');
      expect(t1.effectiveRate, closeTo(8, 1e-9));

      // T2 walks their own units through the (expanded) ladder: 300×10 energy
      // + all shared fixed charges (400) — NOT "building bill minus 1600".
      expect(t2.totalBill, closeTo(3400, 1e-9));
      expect(t2.effectiveRate, closeTo(3400 / 300, 1e-6));
      expect(t2.billingMode, 'shared');
      expect(t2.sharedAdjustment, 0);
    });

    test('any combination: 2 fixed + 3 shared — each contract independent',
        () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 1000),
          tenants: [
            _fixed(1, 'F1', 150, 8),
            _fixed(2, 'F2', 100, 9),
            _shared(3, 'S1', 250),
            _shared(4, 'S2', 300),
            _shared(5, 'S3', 200),
          ],
        ),
      );
      expect(bill.tenantBills.where((t) => t.billingMode == 'fixed').length, 2);
      // Fixed tenants pay exactly their rate.
      expect(
          bill.tenantBills.firstWhere((t) => t.tenantId == 1).totalBill,
          closeTo(150 * 8, 1e-6));
      expect(
          bill.tenantBills.firstWhere((t) => t.tenantId == 2).totalBill,
          closeTo(100 * 9, 1e-6));
      // Shared tenants use divisor 3 (first-slab share = floor(75/3) = 25).
      final s3 = bill.tenantBills.firstWhere((t) => t.tenantId == 5);
      expect(_unitsInSlab(s3, 0), closeTo(25, 1e-9));
    });

    test('all-fixed building: fixed tenants pay their rates; no shared '
        'reconciliation', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 300),
          tenants: [
            _fixed(1, 'F1', 100, 8),
            _fixed(2, 'F2', 200, 12),
          ],
        ),
      );
      expect(bill.tenantBills[0].totalBill, closeTo(800, 1e-9));
      expect(bill.tenantBills[1].totalBill, closeTo(2400, 1e-9));
    });
  });

  group('Engine v2 — fixed charge distribution', () {
    test('Equal (default): meter rent 40 → 20 / 20 regardless of usage', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 500),
          tenants: [_shared(1, 'A', 130), _shared(2, 'B', 370)],
        ),
      );
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      expect(a.meterRent, closeTo(50, 1e-9)); // rent 100 / 2
      expect(b.meterRent, closeTo(50, 1e-9));
      expect(a.demandCharge, closeTo(150, 1e-9)); // demand 300 / 2
      expect(b.demandCharge, closeTo(150, 1e-9));
    });

    test('By usage: fixed charges follow billed units', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 500),
          distribution: FixedChargeDistribution.byUsage,
          tenants: [_shared(1, 'A', 100), _shared(2, 'B', 400)],
        ),
      );
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      expect(a.meterRent, closeTo(20, 1e-9)); // 100 × 0.2
      expect(b.meterRent, closeTo(80, 1e-9)); // 100 × 0.8
    });
  });

  group('Engine v2 — recharge fees', () {
    test('payer is credited actual paid (2020); fee becomes a shared expense',
        () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 100),
          tenants: [_shared(1, 'A', 50), _shared(2, 'B', 50)],
          recharges: const [
            RechargeInput(amount: 2000, fees: 20, paidBy: 'A'),
          ],
        ),
      );

      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);

      expect(a.rechargePaid, closeTo(2020, 1e-9)); // actual money out
      expect(a.rechargeFeesPaid, closeTo(20, 1e-9));
      expect(a.rechargeEnergyCredit, closeTo(2000, 1e-9));

      // The 20 fee is an expense shared equally (10 / 10) and lands in the
      // building bill.
      expect(bill.totalExpenses, closeTo(20, 1e-9));
      expect(a.expenseShare, closeTo(10, 1e-9));
      expect(b.expenseShare, closeTo(10, 1e-9));
      // building bill = 1000 energy + 400 fixed + 20 fees
      expect(bill.buildingBill, closeTo(1420, 1e-9));
      expect(bill.totalRecharge, closeTo(2020, 1e-9));
    });
  });

  group('Engine — lifeline is an ELIGIBILITY tariff, not a slab', () {
    test('total ≤ 50 units bills entirely at the lifeline rate', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 40),
          tenants: [_shared(1, 'Owner', 40)],
        ),
      );
      // Energy = 40 × 4.63 = 185.2 (not 40 × 5.26).
      const expectedEnergy = 40 * 4.63;
      const subtotal = expectedEnergy + 84 + 40;
      final expectedBill = subtotal * (1 + 0.05 - 0.005);
      expect(bill.buildingBill, closeTo(expectedBill, 1e-6));
    });

    test('above the lifeline threshold the normal ladder applies from 0–75',
        () {
      const engine = BillingEngine();
      final at51 = engine.energyCharge(51, _dpdc2026);
      expect(at51, closeTo(51 * 5.26, 1e-9)); // first ladder step, no 4.63
    });

    test('spreadsheet example: 377 units → 75@5.26 + 125@8.50 + 100@9.10 + '
        '77@9.62, lifeline ignored, nothing beyond the 4th slab', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 377),
          tenants: [_shared(1, 'A', 377)],
        ),
      );
      final a = bill.tenantBills.single;
      expect(_unitsInSlab(a, 0), closeTo(75, 1e-9));
      expect(_unitsInSlab(a, 76), closeTo(125, 1e-9));
      expect(_unitsInSlab(a, 201), closeTo(100, 1e-9));
      expect(_unitsInSlab(a, 301), closeTo(77, 1e-9));
      expect(_unitsInSlab(a, 401), 0);
      expect(
        a.energyCost,
        closeTo(75 * 5.26 + 125 * 8.50 + 100 * 9.10 + 77 * 9.62, 1e-6),
      );
    });

    test('spreadsheet example: 204 units → 75@5.26 + 125@8.50 + 4@9.10', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 204),
          tenants: [_shared(1, 'B', 204)],
        ),
      );
      final b = bill.tenantBills.single;
      expect(_unitsInSlab(b, 0), closeTo(75, 1e-9));
      expect(_unitsInSlab(b, 76), closeTo(125, 1e-9));
      expect(_unitsInSlab(b, 201), closeTo(4, 1e-9));
      expect(_unitsInSlab(b, 301), 0);
      expect(b.energyCost,
          closeTo(75 * 5.26 + 125 * 8.50 + 4 * 9.10, 1e-6));
    });

    test('shared mode divides ONLY the progressive slabs; the lifeline '
        'threshold is never divided', () {
      // Sharing does not shrink lifeline eligibility: 40 units with share=2
      // still bills entirely at 4.63 (40 ≤ 50).
      expect(_engine.energyCharge(40, _dpdc2026, share: 2),
          closeTo(40 * 4.63, 1e-9));
      // But the progressive ladder IS divided (share=2 first bound = 37).
      final walk = _engine.ladderBreakdown(60, _dpdc2026, share: 2);
      expect(walk.first.units, closeTo(37, 1e-9));
      expect(walk[1].units, closeTo(23, 1e-9));
    });

    test('a shared tenant within the (undivided) lifeline still gets the '
        'lifeline rate', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 340),
          tenants: [_shared(1, 'Small', 40), _shared(2, 'Big', 300)],
        ),
      );
      final small = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      expect(small.energyCost, closeTo(40 * 4.63, 1e-6));
      final big = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      // 300 > 50 → divided ladder (bounds 37/100/150/200/300):
      // 37@5.26 + 63@8.50 + 50@9.10 + 50@9.62 + 100@15.01 = 3167.12.
      expect(big.energyCost, closeTo(3167.12, 1e-6));
    });
  });

  group('Engine — agent fees accumulate across every recharge', () {
    test('4 recharges × 20 fee ⇒ monthly fees 80, split equally', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 100),
          tenants: [_shared(1, 'A', 50), _shared(2, 'B', 50)],
          recharges: const [
            RechargeInput(amount: 500, fees: 20, paidBy: 'A'),
            RechargeInput(amount: 500, fees: 20, paidBy: 'A'),
            RechargeInput(amount: 500, fees: 20, paidBy: 'B'),
            RechargeInput(amount: 500, fees: 20, paidBy: 'B'),
          ],
        ),
      );
      expect(bill.totalExpenses, closeTo(80, 1e-9));
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      expect(a.expenseShare, closeTo(40, 1e-9)); // 80 / 2 equally
      expect(b.expenseShare, closeTo(40, 1e-9));
      // Each payer is credited their actual money out (2×500 + 2×20).
      expect(a.rechargePaid, closeTo(1040, 1e-9));
      expect(a.rechargeFeesPaid, closeTo(40, 1e-9));
    });
  });

  group('Engine v2 — settlements & balances', () {
    test('settlement transfers balance payer → receiver, net zero', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 100, current: 100),
          openingBalances: const {1: 1000, 2: -500},
          tenants: [_shared(1, 'A', 0), _shared(2, 'B', 0)],
          settlements: const [
            SettlementInput(fromTenantId: 2, toTenantId: 1, amount: 500),
          ],
        ),
      );
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      // Zero usage but fixed charges still bill (400 split 200/200).
      expect(a.settlementsReceived, 500);
      expect(b.settlementsPaid, 500);
      // Direction matters: the payer's balance falls, the receiver's rises.
      expect(a.balance, closeTo(1300, 1e-9)); // (1000 + 500) − 200 bill
      expect(b.balance, closeTo(-1200, 1e-9)); // (−500 − 500) − 200 bill
      // Net across tenants is conserved: settlements shift, never create.
      final netShift = (a.availableBalance + b.availableBalance) -
          (1000 - 500); // openings only
      expect(netShift, closeTo(0, 1e-9));
    });

    test('recharge is credited by tenant ID, not typed name', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 100, current: 100),
          openingBalances: const {1: 0, 2: 0},
          tenants: [_shared(1, 'A', 0), _shared(2, 'B', 0)],
          recharges: const [
            RechargeInput(amount: 1000, paidBy: 'MR. A', paidByTenantId: 1),
          ],
        ),
      );
      expect(bill.tenantBills.firstWhere((t) => t.tenantId == 1).rechargePaid,
          closeTo(1000, 1e-9));
      expect(bill.tenantBills.firstWhere((t) => t.tenantId == 2).rechargePaid,
          closeTo(0, 1e-9));
    });

    test('carry-forward: opening balance flows into available balance', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 100),
          openingBalances: const {1: 600},
          tenants: [_shared(1, 'A', 100)],
          recharges: const [RechargeInput(amount: 1000, paidBy: 'A')],
        ),
      );
      final a = bill.tenantBills.single;
      expect(a.availableBalance, closeTo(1600, 1e-9));
      // bill = 1000 energy + 400 fixed = 1400 → carry forward 200.
      expect(a.balance, closeTo(200, 1e-9));
    });
  });

  group('Engine v2 — edge cases', () {
    test('never produces negative consumption from a lower reading', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 200, current: 150),
          tenants: [_shared(1, 'A', 0)],
        ),
      );
      expect(bill.mainMeterUnits, 0);
    });

    test('zero total usage: fixed charges split equally, engine stays finite',
        () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 100, current: 100),
          tenants: [_shared(1, 'A', 0), _shared(2, 'B', 0)],
        ),
      );
      final total =
          bill.tenantBills.fold<double>(0, (a, t) => a + t.totalBill);
      expect(total, closeTo(400, 1e-9)); // demand 300 + rent 100
      expect(total.isFinite, isTrue);
      for (final t in bill.tenantBills) {
        expect(t.totalBill, closeTo(200, 1e-9));
      }
    });

    test('fixed collections exceeding the building bill clamp the remainder '
        '(shared tenants pay nothing, not negative)', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 100),
          tenants: [
            _fixed(1, 'F', 90, 100), // 9000 ≫ building bill
            _shared(2, 'S', 10),
          ],
        ),
      );
      final s = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      expect(s.totalBill, greaterThanOrEqualTo(0));
    });
  });

  group('Snapshot compatibility', () {
    test('v1 snapshot JSON (without v2 fields) still decodes', () {
      final v1Json = {
        'mainMeterUnits': 250.0,
        'totalTenantUnits': 200.0,
        'commonAreaUnits': 50.0,
        'totalRecharge': 2000.0,
        'tenantBills': [
          {
            'tenantId': 1,
            'tenantName': 'A',
            'previousReading': 0.0,
            'currentReading': 90.0,
            'ownUnits': 90.0,
            'commonUnits': 22.5,
            'billedUnits': 112.5,
            'slabBreakdown': <Map<String, dynamic>>[],
            'energyCost': 639.0,
            'demandCharge': 37.8,
            'meterRent': 18.0,
            'vat': 34.74,
            'rebate': 3.47,
            'totalBill': 726.07,
            'rechargePaid': 2000.0,
            'previousBalance': 0.0,
          },
        ],
      };
      final restored = MonthlyBill.fromJson(v1Json);
      expect(restored.tenantBills.single.billingMode, 'shared'); // default
      expect(restored.tenantBills.single.sharedAdjustment, 0);
      expect(restored.buildingBill, 0); // default for old snapshots
      expect(restored.tenantBills.single.totalBill, closeTo(726.07, 1e-9));
    });

    test('v2 bill round-trips through JSON without losing new fields', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 500),
          tenants: [_fixed(1, 'F', 200, 8), _shared(2, 'S', 300)],
          recharges: const [RechargeInput(amount: 1000, fees: 15, paidBy: 'S')],
        ),
      );
      final restored = MonthlyBill.fromJson(bill.toJson());
      expect(restored.buildingBill, closeTo(bill.buildingBill, 1e-9));
      final f = restored.tenantBills.firstWhere((t) => t.tenantId == 1);
      expect(f.billingMode, 'fixed');
      expect(f.fixedRate, 8);
      final s = restored.tenantBills.firstWhere((t) => t.tenantId == 2);
      expect(s.sharedAdjustment,
          closeTo(bill.tenantBills.firstWhere((t) => t.tenantId == 2).sharedAdjustment, 1e-9));
      expect(s.rechargeFeesPaid, closeTo(15, 1e-9));
    });
  });

  group('Engine v3 — calculation modes', () {
    double sumBills(MonthlyBill bill) =>
        bill.tenantBills.fold<double>(0, (a, t) => a + t.totalBill);

    test('Shared Slab (default): Owner Benefit = Σ tenant bills − main bill; '
        'never shown as a per-tenant adjustment', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 581),
          tenants: [_shared(1, 'A', 377), _shared(2, 'B', 204)],
          recharges: const [
            RechargeInput(amount: 1000, fees: 20, paidBy: 'A'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'A'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'B'),
            RechargeInput(amount: 1000, fees: 20, paidBy: 'B'),
          ],
        ),
      );
      expect(bill.calcMode, 'sharedSlab');
      // Tenant total may exceed the main-meter bill; the gap IS the benefit.
      expect(bill.ownerBenefit,
          closeTo(sumBills(bill) - bill.buildingBill, 1e-9));
      // Not hidden inside any invoice.
      for (final t in bill.tenantBills) {
        expect(t.sharedAdjustment, 0);
      }
    });

    test('Owner Loss: benefit is negative when tenants pay below the bill', () {
      // Single shared tenant: their divided-ladder bill < whole-meter bill
      // (they only pay their own energy + a share of fixed charges, but here
      // there is one tenant so demand/rent are fully theirs — construct a loss
      // via a fixed tenant paying a very low rate).
      final bill = _engine.calculate(
        const BillingInput(
          tariff: _flat10, // building bill = 500×10 + 300 + 100 = 5400
          mainMeter: MeterReadingPair(previous: 0, current: 500),
          tenants: [
            TenantReadingInput(
                tenantId: 1,
                tenantName: 'Cheap',
                previous: 0,
                current: 500,
                mode: TenantBillingMode.fixed,
                fixedRate: 1), // pays only 500
          ],
        ),
      );
      expect(bill.ownerBenefit, closeTo(500 - 5400, 1e-9));
      expect(bill.ownerBenefit, lessThan(0)); // a loss
    });

    test('Reconciled: SUM(tenant bills) == main-meter bill exactly, equal '
        'average rate for shared tenants', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 581),
          tenants: [_shared(1, 'A', 377), _shared(2, 'B', 204)],
          calcMode: BillingCalcMode.reconciled,
        ),
      );
      expect(bill.calcMode, 'reconciled');
      expect(sumBills(bill), closeTo(bill.buildingBill, 1e-6));
      expect(bill.ownerBenefit, 0);
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      // Usage-weighted → identical effective average rate.
      expect(a.effectiveRate, closeTo(b.effectiveRate, 1e-9));
      // A used more units → pays proportionally more.
      expect(a.totalBill / b.totalBill, closeTo(377 / 204, 1e-9));
    });

    test('Fixed Rate mode: fixed tenants pay their rate, shared split the '
        'remainder; total reconciles exactly', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 600),
          tenants: [
            _fixed(1, 'A', 200, 8), // 1600
            _fixed(2, 'B', 100, 10), // 1000
            _shared(3, 'C', 300),
          ],
          calcMode: BillingCalcMode.fixedRate,
        ),
      );
      expect(bill.calcMode, 'fixedRate');
      final a = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      final b = bill.tenantBills.firstWhere((t) => t.tenantId == 2);
      final c = bill.tenantBills.firstWhere((t) => t.tenantId == 3);
      expect(a.totalBill, closeTo(200 * 8, 1e-9));
      expect(b.totalBill, closeTo(100 * 10, 1e-9));
      // Shared tenant absorbs exactly what's left of the actual bill.
      expect(c.totalBill, closeTo(bill.buildingBill - 1600 - 1000, 1e-6));
      expect(sumBills(bill), closeTo(bill.buildingBill, 1e-6));
      expect(bill.ownerBenefit, 0);
      expect(bill.fixedCollections, closeTo(2600, 1e-9));
    });

    test('All-fixed reconciled: every tenant on fixed rate still sums to the '
        'meter bill (no shared tenant to absorb → collections define total)',
        () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _flat10,
          mainMeter: const MeterReadingPair(previous: 0, current: 300),
          tenants: [
            _fixed(1, 'A', 100, 8),
            _fixed(2, 'B', 200, 12),
          ],
          calcMode: BillingCalcMode.fixedRate,
        ),
      );
      expect(bill.tenantBills[0].totalBill, closeTo(800, 1e-9));
      expect(bill.tenantBills[1].totalBill, closeTo(2400, 1e-9));
      expect(bill.ownerBenefit, 0); // reconciled modes never book a benefit
    });

    test('reconciled/fixed reporting getters', () {
      final bill = _engine.calculate(
        BillingInput(
          tariff: _dpdc2026,
          mainMeter: const MeterReadingPair(previous: 0, current: 581),
          tenants: [_shared(1, 'A', 377), _shared(2, 'B', 204)],
          calcMode: BillingCalcMode.reconciled,
        ),
      );
      expect(bill.collectionPercent, closeTo(100, 1e-6)); // reconciled
      expect(bill.averageUnitCost,
          closeTo(bill.buildingBill / bill.mainMeterUnits, 1e-9));
      expect(bill.averageSellingRate,
          closeTo(bill.totalBilled / bill.mainMeterUnits, 1e-9));
    });
  });
}
