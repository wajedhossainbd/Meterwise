import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../billing/data/period_guard.dart';

/// Mutable fields of a settlement.
typedef SettlementDraft = ({
  DateTime date,
  int fromTenantId,
  int toTenantId,
  double amount,
  String? notes,
});

/// Data access for tenant-to-tenant [Settlements].
class SettlementRepository {
  SettlementRepository(this._db);

  final AppDatabase _db;
  late final PeriodGuard _guard = PeriodGuard(_db);

  Stream<List<Settlement>> watchAll() => (_db.select(_db.settlements)
        ..orderBy([
          (t) => OrderingTerm(
              expression: t.settlementDate, mode: OrderingMode.desc),
        ]))
      .watch();

  Future<Settlement?> _byId(int id) =>
      (_db.select(_db.settlements)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<int> create(int mainMeterId, SettlementDraft d) async {
    await _guard.ensureMainMeterEditable(mainMeterId, d.date);
    return _db.into(_db.settlements).insert(
          SettlementsCompanion.insert(
            mainMeterId: mainMeterId,
            settlementDate: d.date,
            fromTenantId: d.fromTenantId,
            toTenantId: d.toTenantId,
            amount: d.amount,
            notes: Value(d.notes),
          ),
        );
  }

  Future<void> delete(int id) async {
    final existing = await _byId(id);
    if (existing != null) {
      await _guard.ensureMainMeterEditable(
          existing.mainMeterId, existing.settlementDate);
    }
    await (_db.delete(_db.settlements)..where((t) => t.id.equals(id))).go();
  }
}

final settlementRepositoryProvider = Provider<SettlementRepository>(
  (ref) => SettlementRepository(ref.watch(appDatabaseProvider)),
);

final settlementListProvider = StreamProvider<List<Settlement>>(
  (ref) => ref.watch(settlementRepositoryProvider).watchAll(),
);
