import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/data/period_guard.dart';
import '../../properties/data/property_repository.dart';

/// Data access for [MainMeter] records.
class MainMeterRepository {
  MainMeterRepository(this._db);

  final AppDatabase _db;
  late final PeriodGuard _guard = PeriodGuard(_db);

  Stream<MainMeter?> watchFirst() =>
      (_db.select(_db.mainMeters)..limit(1)).watchSingleOrNull();

  Future<MainMeter?> getFirst() =>
      (_db.select(_db.mainMeters)..limit(1)).getSingleOrNull();

  Future<int> create({
    required int propertyId,
    required int providerId,
    required String name,
    String? meterNumber,
  }) {
    return _db.into(_db.mainMeters).insert(
          MainMetersCompanion.insert(
            propertyId: propertyId,
            providerId: providerId,
            name: name,
            meterNumber: Value(meterNumber),
          ),
        );
  }

  /// Creates the single main meter if none exists, otherwise updates its
  /// editable fields (name / meter number). When [providerName] is given, the
  /// linked electricity-provider record is renamed (DPDC, DESCO, …) so
  /// invoices show the correct utility.
  Future<void> upsertSingle({
    required int propertyId,
    required int providerId,
    required String name,
    String? meterNumber,
    String? providerName,
  }) async {
    final existing = await getFirst();
    final int meterProviderId;
    if (existing == null) {
      await create(
        propertyId: propertyId,
        providerId: providerId,
        name: name,
        meterNumber: meterNumber,
      );
      meterProviderId = providerId;
    } else {
      await _guard.ensureNoFinalizedPeriods(existing.propertyId);
      await (_db.update(_db.mainMeters)..where((t) => t.id.equals(existing.id)))
          .write(
        MainMetersCompanion(
          name: Value(name),
          meterNumber: Value(meterNumber),
          updatedAt: Value(DateTime.now()),
        ),
      );
      meterProviderId = existing.providerId;
    }
    if (providerName != null && providerName.trim().isNotEmpty) {
      await (_db.update(_db.electricityProviders)
            ..where((t) => t.id.equals(meterProviderId)))
          .write(ElectricityProvidersCompanion(name: Value(providerName)));
    }
  }

  /// Name of the utility serving the current main meter (e.g. "DPDC").
  Future<String?> providerName() async {
    final meter = await getFirst();
    if (meter == null) return null;
    final provider = await (_db.select(_db.electricityProviders)
          ..where((t) => t.id.equals(meter.providerId)))
        .getSingleOrNull();
    return provider?.name;
  }

  Future<void> delete(int id) async {
    final meter = await (_db.select(_db.mainMeters)
          ..where((t) => t.id.equals(id))
          ..limit(1))
        .getSingleOrNull();
    if (meter != null) {
      await _guard.ensureNoFinalizedPeriods(meter.propertyId);
    }
    await (_db.delete(_db.mainMeters)..where((t) => t.id.equals(id))).go();
  }
}

final mainMeterRepositoryProvider = Provider<MainMeterRepository>(
  (ref) => MainMeterRepository(ref.watch(appDatabaseProvider)),
);

/// The single active main meter (or null until one is created).
final currentMainMeterProvider = StreamProvider<MainMeter?>(
  (ref) => ref.watch(mainMeterRepositoryProvider).watchFirst(),
);

/// True once the user has completed minimum setup (property + main meter).
final isSetupCompleteProvider = Provider<bool>((ref) {
  final property = ref.watch(currentPropertyProvider).value;
  final meter = ref.watch(currentMainMeterProvider).value;
  return property != null && meter != null;
});
