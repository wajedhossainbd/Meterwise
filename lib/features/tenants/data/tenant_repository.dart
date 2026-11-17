import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/data/period_guard.dart';

/// Data access for [Tenant] records.
class TenantRepository {
  TenantRepository(this._db);

  final AppDatabase _db;
  late final PeriodGuard _guard = PeriodGuard(_db);

  Stream<List<Tenant>> watchAll() => (_db.select(_db.tenants)
        ..orderBy([(t) => OrderingTerm(expression: t.name)]))
      .watch();

  Future<List<Tenant>> getAll() => _db.select(_db.tenants).get();

  Future<int> create({
    required int mainMeterId,
    required String name,
    String? phone,
    String? email,
    String? apartment,
    String? meterNumber,
    String billingMode = 'shared',
    double? fixedRate,
  }) {
    return _db.into(_db.tenants).insert(
          TenantsCompanion.insert(
            mainMeterId: mainMeterId,
            name: name,
            phone: Value(phone),
            email: Value(email),
            apartment: Value(apartment),
            meterNumber: Value(meterNumber),
            billingMode: Value(billingMode),
            fixedRate: Value(fixedRate),
          ),
        );
  }

  Future<void> updateFields(
    int id, {
    required String name,
    String? phone,
    String? email,
    String? apartment,
    String? meterNumber,
    String billingMode = 'shared',
    double? fixedRate,
  }) {
    return (_db.update(_db.tenants)..where((t) => t.id.equals(id))).write(
      TenantsCompanion(
        name: Value(name),
        phone: Value(phone),
        email: Value(email),
        apartment: Value(apartment),
        meterNumber: Value(meterNumber),
        billingMode: Value(billingMode),
        fixedRate: Value(fixedRate),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> delete(int id) async {
    // A tenant with readings in a finalized month cannot be deleted, since the
    // cascade would alter finalized accounting.
    await _guard.ensureTenantDeletable(id);
    await (_db.delete(_db.tenants)..where((t) => t.id.equals(id))).go();
  }
}

final tenantRepositoryProvider = Provider<TenantRepository>(
  (ref) => TenantRepository(ref.watch(appDatabaseProvider)),
);

/// All tenants, ordered by name (reactive).
final tenantListProvider = StreamProvider<List<Tenant>>(
  (ref) => ref.watch(tenantRepositoryProvider).watchAll(),
);
