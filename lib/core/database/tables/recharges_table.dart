import 'package:drift/drift.dart';

import 'main_meters_table.dart';

/// A prepaid recharge / top-up event on a main meter.
///
/// Recharges can happen multiple times per billing period. The cost breakdown
/// (energy vs demand charge vs VAT vs ...) is captured as reported on the
/// recharge token so the engine can reconcile actual spend against the computed
/// bill and produce credit/due balances.
class Recharges extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get mainMeterId =>
      integer().references(MainMeters, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get rechargeDate => dateTime()();

  /// Total amount paid for this recharge (what actually left the wallet).
  RealColumn get amount => real()();

  // --- Reported breakdown from the recharge token (all default to 0) ---
  RealColumn get energyCost => real().withDefault(const Constant(0))();
  RealColumn get demandCharge => real().withDefault(const Constant(0))();
  RealColumn get meterRent => real().withDefault(const Constant(0))();
  RealColumn get vat => real().withDefault(const Constant(0))();
  RealColumn get rebate => real().withDefault(const Constant(0))();
  RealColumn get agentFee => real().withDefault(const Constant(0))();
  RealColumn get otherExpenses => real().withDefault(const Constant(0))();

  /// Free-text name of the person who paid (display only).
  TextColumn get paidBy => text().nullable()();

  /// The tenant this recharge is credited to. Stored as an ID so a rename or a
  /// typo in [paidBy] can never silently lose the credit.
  IntColumn get paidByTenantId => integer().nullable()();

  TextColumn get tokenNumber => text().nullable()();

  TextColumn get notes => text().nullable()();

  /// Local file path to an attached receipt image (optional).
  TextColumn get receiptPath => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
