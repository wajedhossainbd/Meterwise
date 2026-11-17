import 'package:drift/drift.dart';

import 'main_meters_table.dart';

/// A tenant occupying a unit, metered by a sub-meter under a [MainMeters].
///
/// [status] is stored as a plain string ('active' / 'inactive') at the storage
/// layer; the typed enum + mapping is introduced in the domain layer (Phase 2)
/// so the database stays free of app-level business types.
class Tenants extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mainMeterId =>
      integer().references(MainMeters, #id, onDelete: KeyAction.cascade)();

  TextColumn get name => text().withLength(min: 1, max: 120)();

  TextColumn get phone => text().nullable()();

  TextColumn get email => text().nullable()();

  TextColumn get apartment => text().nullable()();

  TextColumn get meterNumber => text().nullable()();

  TextColumn get status =>
      text().withLength(max: 20).withDefault(const Constant('active'))();

  /// Billing contract: 'shared' (slab-sharing, default) or 'fixed' (flat
  /// per-unit price stored in [fixedRate]).
  TextColumn get billingMode =>
      text().withLength(max: 10).withDefault(const Constant('shared'))();

  /// Negotiated flat price per unit; only meaningful when [billingMode] is
  /// 'fixed'.
  RealColumn get fixedRate => real().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
