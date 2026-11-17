import 'package:drift/drift.dart';

import 'main_meters_table.dart';
import 'tenants_table.dart';

/// A direct payment from one tenant to another (a real accounting transfer,
/// not a recharge). Example: a tenant in due pays a tenant in credit directly.
///
/// Effect on the ledger: the payer's balance increases (their due shrinks) and
/// the receiver's balance decreases (their credit shrinks) by [amount] — net
/// zero across tenants.
class Settlements extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mainMeterId =>
      integer().references(MainMeters, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get settlementDate => dateTime()();

  /// Tenant paying (was in due).
  IntColumn get fromTenantId =>
      integer().references(Tenants, #id, onDelete: KeyAction.cascade)();

  /// Tenant receiving (was in credit).
  IntColumn get toTenantId =>
      integer().references(Tenants, #id, onDelete: KeyAction.cascade)();

  RealColumn get amount => real()();

  TextColumn get notes => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
