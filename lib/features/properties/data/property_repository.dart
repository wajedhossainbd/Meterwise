import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

/// Data access for [Property] records.
///
/// The MVP uses a single property, but everything here is list-based so adding
/// multiple properties later needs no API change.
class PropertyRepository {
  PropertyRepository(this._db);

  final AppDatabase _db;

  Stream<List<Property>> watchAll() => _db.select(_db.properties).watch();

  Stream<Property?> watchFirst() =>
      (_db.select(_db.properties)..limit(1)).watchSingleOrNull();

  Future<Property?> getFirst() =>
      (_db.select(_db.properties)..limit(1)).getSingleOrNull();

  Future<int> create({
    required String name,
    String? address,
    String currencyCode = AppConstants.defaultCurrencyCode,
  }) {
    return _db.into(_db.properties).insert(
          PropertiesCompanion.insert(
            name: name,
            address: Value(address),
            currencyCode: Value(currencyCode),
          ),
        );
  }

  /// Creates the single property if none exists, otherwise updates it.
  Future<void> upsertSingle({
    required String name,
    String? address,
    required String currencyCode,
  }) async {
    final existing = await getFirst();
    if (existing == null) {
      await create(name: name, address: address, currencyCode: currencyCode);
      return;
    }
    await (_db.update(_db.properties)..where((t) => t.id.equals(existing.id)))
        .write(
      PropertiesCompanion(
        name: Value(name),
        address: Value(address),
        currencyCode: Value(currencyCode),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Updates just the currency of the current property (used from Settings).
  Future<void> setCurrency(String currencyCode) async {
    final existing = await getFirst();
    if (existing == null) return;
    await (_db.update(_db.properties)..where((t) => t.id.equals(existing.id)))
        .write(
      PropertiesCompanion(
        currencyCode: Value(currencyCode),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> delete(int id) =>
      (_db.delete(_db.properties)..where((t) => t.id.equals(id))).go();
}

final propertyRepositoryProvider = Provider<PropertyRepository>(
  (ref) => PropertyRepository(ref.watch(appDatabaseProvider)),
);

/// The single active property (or null until one is created).
final currentPropertyProvider = StreamProvider<Property?>(
  (ref) => ref.watch(propertyRepositoryProvider).watchFirst(),
);

/// App-wide currency code, derived from the current property (defaults to BDT).
final currencyCodeProvider = Provider<String>((ref) {
  final property = ref.watch(currentPropertyProvider).value;
  return property?.currencyCode ?? AppConstants.defaultCurrencyCode;
});
