import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/domain/models/tariff.dart';

part 'tariff_repository.g.dart';

/// A slab as edited in the Tariff settings form.
typedef SlabDraft = ({int fromUnit, int? toUnit, double rate});

/// Data access for the tariff: the default [ElectricityProvider] plus its
/// [TariffSlab] rows. Maps storage rows to/from the engine's [Tariff] value
/// object so the rest of the app never touches the provider tables directly.
class TariffRepository {
  TariffRepository(this._db);

  final AppDatabase _db;

  /// Default DPDC LT-A tariff, seeded on first launch.
  static const List<SlabDraft> _defaultSlabs = [
    (fromUnit: 0, toUnit: 50, rate: 4.19),
    (fromUnit: 51, toUnit: 75, rate: 5.72),
    (fromUnit: 76, toUnit: 200, rate: 6.02),
    (fromUnit: 201, toUnit: 300, rate: 6.30),
    (fromUnit: 301, toUnit: 400, rate: 6.34),
    (fromUnit: 401, toUnit: 600, rate: 9.94),
    (fromUnit: 601, toUnit: null, rate: 11.46),
  ];

  /// Creates the default provider + slabs if none exists. Idempotent.
  Future<void> ensureSeeded() async {
    final existing = await _defaultProviderQuery().getSingleOrNull();
    if (existing != null) return;

    await _db.transaction(() async {
      final providerId = await _db.into(_db.electricityProviders).insert(
            ElectricityProvidersCompanion.insert(
              name: 'DPDC LT-A',
              vatPercent: const Value(5),
              rebatePercent: const Value(0.5),
              meterRent: const Value(40),
              demandChargePerKw: const Value(84),
              currencyCode: const Value('BDT'),
              isDefault: const Value(true),
            ),
          );
      await _insertSlabs(providerId, _defaultSlabs);
    });
  }

  Future<ElectricityProvider> getDefaultProvider() async {
    await ensureSeeded();
    return _defaultProviderQuery().getSingle();
  }

  Future<List<TariffSlab>> getSlabs(int providerId) {
    return (_db.select(_db.tariffSlabs)
          ..where((t) => t.providerId.equals(providerId))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
  }

  /// Builds the engine's [Tariff] from the stored provider + slabs.
  Future<Tariff> getTariff() async {
    final provider = await getDefaultProvider();
    final slabs = await getSlabs(provider.id);
    return Tariff(
      slabs: [
        for (final s in slabs)
          TariffSlabRange(fromUnit: s.fromUnit, toUnit: s.toUnit, rate: s.rate),
      ],
      demandCharge: provider.demandChargePerKw,
      meterRent: provider.meterRent,
      vatPercent: provider.vatPercent,
      rebatePercent: provider.rebatePercent,
      currencyCode: provider.currencyCode ?? 'BDT',
    );
  }

  /// Persists edited fixed charges and slabs in a single transaction.
  Future<void> saveTariff({
    required double demandCharge,
    required double meterRent,
    required double vatPercent,
    required double rebatePercent,
    required List<SlabDraft> slabs,
  }) async {
    final provider = await getDefaultProvider();
    await _db.transaction(() async {
      await (_db.update(_db.electricityProviders)
            ..where((t) => t.id.equals(provider.id)))
          .write(
        ElectricityProvidersCompanion(
          demandChargePerKw: Value(demandCharge),
          meterRent: Value(meterRent),
          vatPercent: Value(vatPercent),
          rebatePercent: Value(rebatePercent),
          updatedAt: Value(DateTime.now()),
        ),
      );
      await (_db.delete(_db.tariffSlabs)
            ..where((t) => t.providerId.equals(provider.id)))
          .go();
      await _insertSlabs(provider.id, slabs);
    });
  }

  Future<void> _insertSlabs(int providerId, List<SlabDraft> slabs) async {
    for (var i = 0; i < slabs.length; i++) {
      final s = slabs[i];
      await _db.into(_db.tariffSlabs).insert(
            TariffSlabsCompanion.insert(
              providerId: providerId,
              fromUnit: s.fromUnit,
              toUnit: Value(s.toUnit),
              rate: s.rate,
              sortOrder: Value(i),
            ),
          );
    }
  }

  SimpleSelectStatement<$ElectricityProvidersTable, ElectricityProvider>
      _defaultProviderQuery() =>
          _db.select(_db.electricityProviders)
            ..where((t) => t.isDefault.equals(true))
            ..limit(1);
}

@Riverpod(keepAlive: true)
TariffRepository tariffRepository(Ref ref) =>
    TariffRepository(ref.watch(appDatabaseProvider));

/// The current tariff used for billing. Invalidate after editing in Settings.
@riverpod
Future<Tariff> currentTariff(Ref ref) =>
    ref.watch(tariffRepositoryProvider).getTariff();
