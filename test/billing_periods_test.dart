import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/core/database/app_database.dart';
import 'package:meterwise/features/billing/data/billing_period_repository.dart';
import 'package:meterwise/features/billing/data/period_guard.dart';
import 'package:meterwise/features/billing/domain/billing_engine.dart';
import 'package:meterwise/features/main_meter/data/main_meter_repository.dart';
import 'package:meterwise/features/properties/data/property_repository.dart';
import 'package:meterwise/features/readings/data/reading_repository.dart';
import 'package:meterwise/features/recharge/data/recharge_repository.dart';
import 'package:meterwise/features/billing/domain/models/billing_input.dart';
import 'package:meterwise/features/billing/domain/models/billing_result.dart';
import 'package:meterwise/features/billing/domain/models/tariff.dart';
import 'package:meterwise/features/tariff/data/tariff_version_repository.dart';
import 'package:meterwise/features/tenants/data/tenant_repository.dart';

const _tariff = Tariff(
  slabs: [
    TariffSlabRange(fromUnit: 0, toUnit: 50, rate: 4.19),
    TariffSlabRange(fromUnit: 51, toUnit: null, rate: 6.0),
  ],
  demandCharge: 84,
  meterRent: 40,
  vatPercent: 5,
  rebatePercent: 0.5,
);

MonthlyBill _sampleBill() {
  return const BillingEngine().calculate(
    const BillingInput(
      tariff: _tariff,
      mainMeter: MeterReadingPair(previous: 0, current: 200),
      tenants: [
        TenantReadingInput(
            tenantId: 1, tenantName: 'A', previous: 0, current: 80),
        TenantReadingInput(
            tenantId: 2, tenantName: 'B', previous: 0, current: 120),
      ],
      recharges: [RechargeInput(amount: 2000, paidBy: 'A')],
      openingBalances: {1: 300},
    ),
  );
}

void main() {
  group('MonthlyBill JSON snapshot', () {
    test('round-trips without losing figures (immutability mechanism)', () {
      final bill = _sampleBill();
      final restored = MonthlyBill.fromJson(bill.toJson());

      expect(restored.mainMeterUnits, bill.mainMeterUnits);
      expect(restored.totalBilled, closeTo(bill.totalBilled, 1e-9));
      expect(restored.tenantBills.length, bill.tenantBills.length);

      final a = restored.tenantBills.firstWhere((t) => t.tenantId == 1);
      final origA = bill.tenantBills.firstWhere((t) => t.tenantId == 1);
      expect(a.previousBalance, 300);
      expect(a.balance, closeTo(origA.balance, 1e-9));
      expect(a.slabBreakdown.length, origA.slabBreakdown.length);
    });
  });

  group('TariffVersionRepository', () {
    late AppDatabase db;
    setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
    tearDown(() => db.close());

    test('resolves the version effective on a given date', () async {
      final repo = TariffVersionRepository(db);
      const v2Tariff = Tariff(
        slabs: [TariffSlabRange(fromUnit: 0, toUnit: null, rate: 9)],
        demandCharge: 100,
        meterRent: 50,
        vatPercent: 5,
        rebatePercent: 0,
      );

      await repo.createVersion(
          label: 'V1', effectiveFrom: DateTime(2000), tariff: _tariff);
      await repo.createVersion(
          label: 'V2', effectiveFrom: DateTime(2026, 7, 1), tariff: v2Tariff);

      final before = await repo.tariffForDate(DateTime(2026, 6, 15));
      expect(before.demandCharge, 84); // V1

      final after = await repo.tariffForDate(DateTime(2026, 8, 1));
      expect(after.demandCharge, 100); // V2
    });

    Tariff withDemand(double d) => Tariff(
          slabs: const [TariffSlabRange(fromUnit: 0, toUnit: null, rate: 5)],
          demandCharge: d,
          meterRent: 0,
          vatPercent: 0,
          rebatePercent: 0,
        );

    test('resolves by effective date, not creation order', () async {
      final repo = TariffVersionRepository(db);
      // Insert out of order: A(1 Jun), then B(15 Jun), then C(10 Jun) last.
      await repo.createVersion(
          label: 'A', effectiveFrom: DateTime(2026, 6, 1), tariff: withDemand(10));
      await repo.createVersion(
          label: 'B', effectiveFrom: DateTime(2026, 6, 15), tariff: withDemand(30));
      await repo.createVersion(
          label: 'C', effectiveFrom: DateTime(2026, 6, 10), tariff: withDemand(20));

      expect((await repo.tariffForDate(DateTime(2026, 6, 2))).demandCharge, 10);
      expect((await repo.tariffForDate(DateTime(2026, 6, 12))).demandCharge, 20);
      expect((await repo.tariffForDate(DateTime(2026, 6, 16))).demandCharge, 30);
    });

    test('rejects duplicate effective dates', () async {
      final repo = TariffVersionRepository(db);
      await repo.createVersion(
          label: 'A', effectiveFrom: DateTime(2026, 6, 1), tariff: withDemand(10));
      await expectLater(
        repo.createVersion(
            label: 'B', effectiveFrom: DateTime(2026, 6, 1), tariff: withDemand(20)),
        throwsA(isA<TariffException>()),
      );
    });

    test('archived versions are excluded from resolution', () async {
      final repo = TariffVersionRepository(db);
      final aId = await repo.createVersion(
          label: 'A', effectiveFrom: DateTime(2026, 6, 1), tariff: withDemand(10));
      await repo.createVersion(
          label: 'B', effectiveFrom: DateTime(2026, 6, 10), tariff: withDemand(20));

      // Before archiving, 12 Jun resolves to B(20)... archive B → falls back to A.
      await repo.setArchived(
          (await repo.getAll()).firstWhere((v) => v.label == 'B').id,
          archived: true);
      expect((await repo.tariffForDate(DateTime(2026, 6, 12))).demandCharge, 10);
      expect(aId, isNotNull);
    });
  });

  group('BillingPeriodRepository', () {
    late AppDatabase db;
    setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
    tearDown(() => db.close());

    Future<int> makeProperty() => db
        .into(db.properties)
        .insert(PropertiesCompanion.insert(name: 'P'));

    test('finalize freezes an immutable snapshot; unlock reverts', () async {
      final repo = BillingPeriodRepository(db);
      final propId = await makeProperty();

      final period = await repo.getOrCreate(propId, 2026, 6);
      expect(period.status, 'draft');

      final bill = _sampleBill();
      await repo.finalize(
        id: period.id,
        bill: bill,
        tariffVersionId: 7,
        billingMethod: 'usageBased',
        currency: 'BDT',
      );

      final finalized = await repo.find(propId, 2026, 6);
      expect(finalized!.status, 'finalized');
      expect(finalized.finalizedAt, isNotNull);
      expect(finalized.tariffVersionId, 7);
      expect(finalized.billingMethodSnapshot, 'usageBased');

      final snap = repo.snapshotOf(finalized)!;
      expect(snap.totalBilled, closeTo(bill.totalBilled, 1e-6));
      expect(snap.tenantBills.length, 2);

      // The snapshot is what makes the record immutable: it does not depend on
      // live readings/tariff any more.
      expect(await repo.isFinalized(propId, 2026, 6), isTrue);

      await repo.unlock(period.id);
      final draftAgain = await repo.find(propId, 2026, 6);
      expect(draftAgain!.status, 'draft');
      expect(draftAgain.calculationSnapshot, isNull);
      expect(draftAgain.finalizedAt, isNull);
    });

    test('finalized month blocks reading & recharge mutations', () async {
      final propId = await makeProperty();
      final providerId = await db
          .into(db.electricityProviders)
          .insert(ElectricityProvidersCompanion.insert(name: 'DPDC'));
      final meterId = await db.into(db.mainMeters).insert(
            MainMetersCompanion.insert(
              propertyId: propId,
              providerId: providerId,
              name: 'M',
            ),
          );

      final periodRepo = BillingPeriodRepository(db);
      final period = await periodRepo.getOrCreate(propId, 2026, 6);
      await periodRepo.finalize(
        id: period.id,
        bill: _sampleBill(),
        billingMethod: 'usageBased',
        currency: 'BDT',
      );

      final readingRepo = ReadingRepository(db);
      final rechargeRepo = RechargeRepository(db);

      // Writes into the finalized month are rejected at the data layer.
      await expectLater(
        readingRepo.addSession(
          mainMeterId: meterId,
          date: DateTime(2026, 6, 15),
          mainReading: 100,
          tenantReadings: const {},
        ),
        throwsA(isA<FinalizedPeriodException>()),
      );
      await expectLater(
        rechargeRepo.create(meterId, (
          date: DateTime(2026, 6, 10),
          amount: 500,
          energyCost: 0,
          demandCharge: 0,
          meterRent: 0,
          vat: 0,
          rebate: 0,
          agentFee: 0,
          otherExpenses: 0,
          paidBy: null,
          paidByTenantId: null,
          tokenNumber: null,
          notes: null,
          receiptPath: null,
        )),
        throwsA(isA<FinalizedPeriodException>()),
      );

      // A different (draft) month is still editable.
      await readingRepo.addSession(
        mainMeterId: meterId,
        date: DateTime(2026, 7, 15),
        mainReading: 100,
        tenantReadings: const {},
      );
      expect((await db.select(db.meterReadings).get()).length, 1);
    });

    test('finalized month freezes property/meter/tenant metadata', () async {
      final propId = await makeProperty();
      final providerId = await db
          .into(db.electricityProviders)
          .insert(ElectricityProvidersCompanion.insert(name: 'DPDC'));
      final meterId = await db.into(db.mainMeters).insert(
            MainMetersCompanion.insert(
              propertyId: propId,
              providerId: providerId,
              name: 'M',
            ),
          );
      final tenantId = await db.into(db.tenants).insert(
            TenantsCompanion.insert(mainMeterId: meterId, name: 'A'),
          );

      final periodRepo = BillingPeriodRepository(db);
      final period = await periodRepo.getOrCreate(propId, 2026, 6);
      await periodRepo.finalize(
        id: period.id,
        bill: _sampleBill(),
        billingMethod: 'usageBased',
        currency: 'BDT',
      );

      final properties = PropertyRepository(db);
      final meters = MainMeterRepository(db);
      final tenants = TenantRepository(db);

      // All of these values are printed on historical invoices.
      await expectLater(
        properties.upsertSingle(name: 'Renamed', currencyCode: 'USD'),
        throwsA(isA<FinalizedPeriodException>()),
      );
      await expectLater(
        properties.setCurrency('USD'),
        throwsA(isA<FinalizedPeriodException>()),
      );
      await expectLater(
        meters.upsertSingle(
          propertyId: propId,
          providerId: providerId,
          name: 'Renamed',
          providerName: 'DESCO',
        ),
        throwsA(isA<FinalizedPeriodException>()),
      );
      await expectLater(
        tenants.updateFields(tenantId, name: 'Renamed'),
        throwsA(isA<FinalizedPeriodException>()),
      );

      // No metadata actually changed.
      expect((await properties.getFirst())!.name, 'P');
      expect((await tenants.getAll()).single.name, 'A');
    });

    test('latestFinalizedBefore finds the prior finalized period', () async {
      final repo = BillingPeriodRepository(db);
      final propId = await makeProperty();

      final may = await repo.getOrCreate(propId, 2026, 5);
      await repo.finalize(
        id: may.id,
        bill: _sampleBill(),
        billingMethod: 'usageBased',
        currency: 'BDT',
      );
      await repo.getOrCreate(propId, 2026, 6); // draft

      final prior = await repo.latestFinalizedBefore(propId, 2026, 6);
      expect(prior, isNotNull);
      expect(prior!.month, 5);

      final nonePrior = await repo.latestFinalizedBefore(propId, 2026, 5);
      expect(nonePrior, isNull);
    });
  });
}
