import 'package:drift/drift.dart';

import 'properties_table.dart';

/// One accounting period (a property + month). The unit of finalization.
///
/// A period starts as `draft` (editable, recomputed live) and becomes
/// `finalized` (immutable) once the user finalizes it. On finalization the fully
/// computed bill is frozen into [calculationSnapshot] and the tariff version,
/// billing method and currency used are recorded — so the record never changes
/// even if settings/tariff/readings change later.
class BillingPeriods extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get propertyId =>
      integer().references(Properties, #id, onDelete: KeyAction.cascade)();

  IntColumn get year => integer()();

  /// 1–12.
  IntColumn get month => integer()();

  /// 'draft' or 'finalized'.
  TextColumn get status =>
      text().withLength(max: 20).withDefault(const Constant('draft'))();

  DateTimeColumn get finalizedAt => dateTime().nullable()();
  TextColumn get finalizedBy => text().nullable()();

  /// The tariff version used at finalization.
  IntColumn get tariffVersionId => integer().nullable()();

  /// 'usageBased' or 'fixedRate' at finalization.
  TextColumn get billingMethodSnapshot => text().nullable()();
  TextColumn get currencySnapshot => text().nullable()();

  /// Serialized [MonthlyBill] computed at finalization (the immutable bill).
  TextColumn get calculationSnapshot => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {propertyId, year, month},
      ];
}
