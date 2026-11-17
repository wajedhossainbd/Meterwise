import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

/// Thrown by repositories when a write is attempted against a finalized
/// (locked) billing period. Caught by the UI to show the standard message.
class FinalizedPeriodException implements Exception {
  const FinalizedPeriodException();

  static const String message =
      'This billing period has been finalized. Unlock the month before making '
      'changes.';

  @override
  String toString() => message;
}

/// Enforces immutability of finalized billing periods at the data layer, so a
/// finalized month can never be mutated even if a UI guard is missed.
class PeriodGuard {
  PeriodGuard(this._db);

  final AppDatabase _db;

  Future<bool> isFinalized(int propertyId, int year, int month) async {
    final row = await (_db.select(_db.billingPeriods)
          ..where((t) =>
              t.propertyId.equals(propertyId) &
              t.year.equals(year) &
              t.month.equals(month) &
              t.status.equals('finalized'))
          ..limit(1))
        .getSingleOrNull();
    return row != null;
  }

  Future<int?> _propertyForMainMeter(int mainMeterId) async {
    final m = await (_db.select(_db.mainMeters)
          ..where((t) => t.id.equals(mainMeterId))
          ..limit(1))
        .getSingleOrNull();
    return m?.propertyId;
  }

  Future<int?> _propertyForTenant(int tenantId) async {
    final t = await (_db.select(_db.tenants)
          ..where((x) => x.id.equals(tenantId))
          ..limit(1))
        .getSingleOrNull();
    if (t == null) return null;
    return _propertyForMainMeter(t.mainMeterId);
  }

  /// Throws [FinalizedPeriodException] if the main meter's month is finalized.
  Future<void> ensureMainMeterEditable(int mainMeterId, DateTime date) async {
    final pid = await _propertyForMainMeter(mainMeterId);
    if (pid != null && await isFinalized(pid, date.year, date.month)) {
      throw const FinalizedPeriodException();
    }
  }

  /// Throws if the tenant's month is finalized.
  Future<void> ensureTenantEditable(int tenantId, DateTime date) async {
    final pid = await _propertyForTenant(tenantId);
    if (pid != null && await isFinalized(pid, date.year, date.month)) {
      throw const FinalizedPeriodException();
    }
  }

  /// Throws if the property has ANY finalized month.
  ///
  /// Property/meter/tenant metadata (names, currency, provider, contract) is
  /// printed on historical invoices, so changing it after finalization would
  /// silently rewrite a permanent record.
  Future<void> ensureNoFinalizedPeriods(int propertyId) async {
    final row = await (_db.select(_db.billingPeriods)
          ..where((t) =>
              t.propertyId.equals(propertyId) & t.status.equals('finalized'))
          ..limit(1))
        .getSingleOrNull();
    if (row != null) throw const FinalizedPeriodException();
  }

  /// Throws if the tenant's property has any finalized month.
  Future<void> ensureTenantMetadataEditable(int tenantId) async {
    final pid = await _propertyForTenant(tenantId);
    if (pid != null) await ensureNoFinalizedPeriods(pid);
  }

  /// Throws if any reading recorded on [date] belongs to a finalized month.
  Future<void> ensureReadingsOnDateEditable(DateTime date) async {
    final rows = await (_db.select(_db.meterReadings)
          ..where((t) => t.readingDate.equals(date)))
        .get();
    for (final r in rows) {
      if (r.mainMeterId != null) {
        await ensureMainMeterEditable(r.mainMeterId!, date);
      } else if (r.tenantId != null) {
        await ensureTenantEditable(r.tenantId!, date);
      }
    }
  }

  /// Throws if the tenant has any reading in a finalized month (deleting the
  /// tenant would alter finalized accounting via cascade).
  Future<void> ensureTenantDeletable(int tenantId) async {
    final readings = await (_db.select(_db.meterReadings)
          ..where((t) => t.tenantId.equals(tenantId)))
        .get();
    for (final r in readings) {
      await ensureTenantEditable(tenantId, r.readingDate);
    }
  }
}
