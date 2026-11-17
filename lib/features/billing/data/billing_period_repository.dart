import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../properties/data/property_repository.dart';
import '../domain/models/billing_result.dart';

/// Status of a billing period.
enum PeriodStatus { draft, finalized }

/// Data access for [BillingPeriods] — the accounting periods that turn draft
/// months into immutable finalized records.
class BillingPeriodRepository {
  BillingPeriodRepository(this._db);

  final AppDatabase _db;

  Future<BillingPeriod?> find(int propertyId, int year, int month) {
    return (_db.select(_db.billingPeriods)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.year.equals(year) &
              t.month.equals(month))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Returns the period, creating a draft row if none exists.
  Future<BillingPeriod> getOrCreate(int propertyId, int year, int month) async {
    final existing = await find(propertyId, year, month);
    if (existing != null) return existing;
    await _db.into(_db.billingPeriods).insert(
          BillingPeriodsCompanion.insert(
            propertyId: propertyId,
            year: year,
            month: month,
          ),
        );
    return (await find(propertyId, year, month))!;
  }

  Stream<List<BillingPeriod>> watchAll(int propertyId) =>
      (_db.select(_db.billingPeriods)
            ..where((t) => t.propertyId.equals(propertyId))
            ..orderBy([
              (t) => OrderingTerm(expression: t.year, mode: OrderingMode.desc),
              (t) => OrderingTerm(expression: t.month, mode: OrderingMode.desc),
            ]))
          .watch();

  Future<bool> isFinalized(int propertyId, int year, int month) async {
    final p = await find(propertyId, year, month);
    return p?.status == 'finalized';
  }

  /// The most recent finalized period strictly before (year, month).
  Future<BillingPeriod?> latestFinalizedBefore(
    int propertyId,
    int year,
    int month,
  ) async {
    final finalized = await (_db.select(_db.billingPeriods)
          ..where((t) =>
              t.propertyId.equals(propertyId) & t.status.equals('finalized')))
        .get();
    final before = finalized
        .where((p) => p.year < year || (p.year == year && p.month < month))
        .toList()
      ..sort((a, b) {
        final byYear = b.year.compareTo(a.year);
        return byYear != 0 ? byYear : b.month.compareTo(a.month);
      });
    return before.isEmpty ? null : before.first;
  }

  /// Whether an earlier draft period (after the last finalized one) still has
  /// unfinalized data — used to enforce in-order finalization.
  Future<bool> hasEarlierDraft(int propertyId, int year, int month) async {
    final all = await (_db.select(_db.billingPeriods)
          ..where((t) => t.propertyId.equals(propertyId)))
        .get();
    return all.any((p) =>
        p.status == 'draft' &&
        (p.year < year || (p.year == year && p.month < month)));
  }

  Future<void> finalize({
    required int id,
    required MonthlyBill bill,
    int? tariffVersionId,
    required String billingMethod,
    required String currency,
  }) {
    return (_db.update(_db.billingPeriods)..where((t) => t.id.equals(id))).write(
      BillingPeriodsCompanion(
        status: const Value('finalized'),
        finalizedAt: Value(DateTime.now()),
        tariffVersionId: Value(tariffVersionId),
        billingMethodSnapshot: Value(billingMethod),
        currencySnapshot: Value(currency),
        calculationSnapshot: Value(jsonEncode(bill.toJson())),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> unlock(int id) {
    return (_db.update(_db.billingPeriods)..where((t) => t.id.equals(id))).write(
      BillingPeriodsCompanion(
        status: const Value('draft'),
        finalizedAt: const Value(null),
        calculationSnapshot: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Decodes the stored immutable bill of a finalized period.
  MonthlyBill? snapshotOf(BillingPeriod period) {
    final json = period.calculationSnapshot;
    if (json == null) return null;
    return MonthlyBill.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
}

final billingPeriodRepositoryProvider = Provider<BillingPeriodRepository>(
  (ref) => BillingPeriodRepository(ref.watch(appDatabaseProvider)),
);

/// 'yyyy-MM' key for a finalized-month lookup (matches Formatters.monthKey).
String periodMonthKey(int year, int month) =>
    '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}';

/// Set of finalized month keys for the current property — lets the UI disable
/// edit/delete on locked months.
final finalizedMonthsProvider = StreamProvider<Set<String>>((ref) async* {
  final property = ref.watch(currentPropertyProvider).value;
  if (property == null) {
    yield <String>{};
    return;
  }
  yield* ref.watch(billingPeriodRepositoryProvider).watchAll(property.id).map(
        (periods) => {
          for (final p in periods)
            if (p.status == 'finalized') periodMonthKey(p.year, p.month),
        },
      );
});
