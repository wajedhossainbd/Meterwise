import 'package:drift/drift.dart';

import 'main_meters_table.dart';
import 'tenants_table.dart';

/// A single timestamped meter reading.
///
/// Design decision: we store **raw readings only**, never monthly summaries.
/// The billing engine derives consumption between any two readings, which makes
/// multiple readings per month, mid-month corrections, and richer analytics
/// possible without schema changes.
///
/// A reading belongs to *either* a main meter *or* a tenant sub-meter. Exactly
/// one of [mainMeterId] / [tenantId] is non-null; this invariant is enforced by
/// a table-level check constraint below and by the repository layer.
class MeterReadings extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mainMeterId => integer()
      .nullable()
      .references(MainMeters, #id, onDelete: KeyAction.cascade)();

  IntColumn get tenantId => integer()
      .nullable()
      .references(Tenants, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get readingDate => dateTime()();

  /// Cumulative meter value at [readingDate].
  RealColumn get readingValue => real()();

  TextColumn get notes => text().nullable()();

  /// Local file path to an attached meter photo (optional).
  TextColumn get photoPath => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<String> get customConstraints => [
        // Exactly one owner: main meter XOR tenant.
        'CHECK ((main_meter_id IS NULL) <> (tenant_id IS NULL))',
      ];
}
