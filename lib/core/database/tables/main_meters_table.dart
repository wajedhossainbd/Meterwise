import 'package:drift/drift.dart';

import 'electricity_providers_table.dart';
import 'properties_table.dart';

/// A physical main (prepaid) meter feeding a set of tenant sub-meters.
///
/// A property may have several (e.g. "Ground Floor DPDC", "Generator Meter").
/// Each main meter is billed against exactly one [ElectricityProviders] tariff.
class MainMeters extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get propertyId =>
      integer().references(Properties, #id, onDelete: KeyAction.cascade)();

  IntColumn get providerId =>
      integer().references(ElectricityProviders, #id, onDelete: KeyAction.restrict)();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get meterNumber => text().nullable()();

  /// Sanctioned load in kW; used for the demand-charge calculation.
  RealColumn get sanctionedLoad => real().nullable()();

  TextColumn get notes => text().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
