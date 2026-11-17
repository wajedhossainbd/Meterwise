import 'package:drift/drift.dart';

/// A single-row table holding app-wide preferences.
///
/// Kept as a typed singleton (always `id = 1`) rather than a loose key/value
/// store so the settings are strongly typed and easy to consume. Repositories
/// guarantee the row exists.
class AppSettings extends Table {
  /// Always 1 — there is exactly one settings row.
  IntColumn get id => integer().withDefault(const Constant(1))();

  /// Multi-tenant building (true) vs single personal meter (false).
  BoolColumn get multiTenant => boolean().withDefault(const Constant(true))();

  /// Billing method: usage-based slab tariff (false) vs flat per-unit rate
  /// (true). See [fixedUnitPrice].
  BoolColumn get fixedRate => boolean().withDefault(const Constant(false))();

  /// Flat price per unit used when [fixedRate] is true.
  ///
  /// v2: superseded by per-tenant billing modes (Tenants.billingMode /
  /// Tenants.fixedRate); kept for migration.
  RealColumn get fixedUnitPrice => real().withDefault(const Constant(8))();

  /// How fixed charges (demand, rent, fees) are split among shared tenants:
  /// 'equal' (default) or 'usage'.
  TextColumn get fixedChargeDistribution =>
      text().withLength(max: 10).withDefault(const Constant('equal'))();

  /// Property-level billing calculation mode: 'sharedSlab' (default,
  /// landlord mode) | 'reconciled' | 'fixedRate'. Snapshotted on finalize.
  TextColumn get billingCalcMode =>
      text().withLength(max: 20).withDefault(const Constant('sharedSlab'))();

  /// UI / invoice language code ('en' or 'bn').
  TextColumn get languageCode =>
      text().withLength(max: 5).withDefault(const Constant('en'))();

  /// Marks that the first-run setup wizard has been completed.
  BoolColumn get onboarded => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
