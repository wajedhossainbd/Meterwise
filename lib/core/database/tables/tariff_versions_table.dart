import 'package:drift/drift.dart';

/// An immutable, dated snapshot of the complete tariff.
///
/// The billing engine resolves the version whose [effectiveFrom] is the latest
/// on or before a billing month's date. Existing versions are never edited — a
/// tariff change creates a new version — so historical bills stay reproducible.
///
/// The full [Tariff] value object (slabs + charges + currency) is stored as JSON
/// in [tariffJson], keeping the schema simple and the snapshot self-contained.
class TariffVersions extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Human label, e.g. "Version 1".
  TextColumn get label => text().withLength(min: 1, max: 60)();

  /// The date from which this version applies.
  DateTimeColumn get effectiveFrom => dateTime()();

  /// Serialized [Tariff] (slabs, demand charge, meter rent, VAT, rebate).
  TextColumn get tariffJson => text()();

  /// Archived versions are hidden from tariff resolution but kept for history.
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
