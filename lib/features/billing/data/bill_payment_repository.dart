import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

/// Tracks manual "mark paid" status for tenant bills by month.
class BillPaymentRepository {
  BillPaymentRepository(this._db);

  final AppDatabase _db;

  Stream<List<BillPayment>> watchForMonth(String monthKey) =>
      (_db.select(_db.billPayments)..where((t) => t.monthKey.equals(monthKey)))
          .watch();

  Future<void> markPaid(int tenantId, String monthKey) async {
    final existing = await (_db.select(_db.billPayments)
          ..where((t) =>
              t.tenantId.equals(tenantId) & t.monthKey.equals(monthKey)))
        .getSingleOrNull();
    if (existing != null) return;
    await _db.into(_db.billPayments).insert(
          BillPaymentsCompanion.insert(
            tenantId: tenantId,
            monthKey: monthKey,
          ),
        );
  }

  Future<void> unmark(int tenantId, String monthKey) =>
      (_db.delete(_db.billPayments)
            ..where((t) =>
                t.tenantId.equals(tenantId) & t.monthKey.equals(monthKey)))
          .go();
}

final billPaymentRepositoryProvider = Provider<BillPaymentRepository>(
  (ref) => BillPaymentRepository(ref.watch(appDatabaseProvider)),
);

/// Set of tenant ids marked paid for the given month (reactive).
final paidTenantIdsProvider =
    StreamProvider.family<Set<int>, String>((ref, monthKey) {
  return ref
      .watch(billPaymentRepositoryProvider)
      .watchForMonth(monthKey)
      .map((rows) => rows.map((r) => r.tenantId).toSet());
});
