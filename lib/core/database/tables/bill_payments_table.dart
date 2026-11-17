import 'package:drift/drift.dart';

/// Records that a tenant's bill for a given month was manually marked paid.
///
/// Kept separate from the computed bill (bills aren't persisted). [tenantId] is
/// not a foreign key so it can also hold the single-meter owner account id.
/// One row per (tenant, month).
class BillPayments extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tenantId => integer()();

  /// 'yyyy-MM' key of the billed month.
  TextColumn get monthKey => text().withLength(min: 7, max: 7)();

  DateTimeColumn get paidAt => dateTime().withDefault(currentDateAndTime)();
}
