import 'package:drift/drift.dart';

import '../constants/app_constants.dart';
import 'connection/database_connection.dart';
import 'tables/app_settings_table.dart';
import 'tables/bill_payments_table.dart';
import 'tables/billing_periods_table.dart';
import 'tables/electricity_providers_table.dart';
import 'tables/main_meters_table.dart';
import 'tables/meter_readings_table.dart';
import 'tables/properties_table.dart';
import 'tables/recharges_table.dart';
import 'tables/settlements_table.dart';
import 'tables/tariff_slabs_table.dart';
import 'tables/tariff_versions_table.dart';
import 'tables/tenants_table.dart';

part 'app_database.g.dart';

/// The application's Drift database.
///
/// This is the single source of truth for persisted data. Feature repositories
/// (Phase 2+) depend on this class — never on raw SQL scattered through the UI.
///
/// DAOs are intentionally omitted in Phase 1; each feature will introduce its
/// own DAO alongside its repository so query logic stays colocated with the
/// feature that owns it.
@DriftDatabase(
  tables: [
    Properties,
    ElectricityProviders,
    TariffSlabs,
    MainMeters,
    Tenants,
    MeterReadings,
    Recharges,
    AppSettings,
    BillPayments,
    TariffVersions,
    BillingPeriods,
    Settlements,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  /// Test-only constructor allowing an injected (e.g. in-memory) executor.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => AppConstants.databaseSchemaVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(appSettings);
            await m.addColumn(recharges, recharges.receiptPath);
            await m.addColumn(meterReadings, meterReadings.photoPath);
          }
          if (from < 3) {
            await m.createTable(billPayments);
          }
          if (from < 4) {
            await m.createTable(tariffVersions);
            await m.createTable(billingPeriods);
          }
          // Only when coming from exactly v4: tariffVersions existed there
          // without `archived`. From <4 the createTable above already includes
          // the column (current DDL), so adding it again would fail.
          if (from == 4) {
            await m.addColumn(tariffVersions, tariffVersions.archived);
          }
          if (from < 6) {
            await m.createTable(settlements);
          }
          if (from < 7) {
            // Tenants and AppSettings exist in every pre-v7 schema without
            // these columns, so addColumn is safe on all upgrade paths.
            await m.addColumn(tenants, tenants.billingMode);
            await m.addColumn(tenants, tenants.fixedRate);
            await m.addColumn(appSettings, appSettings.fixedChargeDistribution);
            // Migrate the legacy GLOBAL fixed-rate setting to per-tenant
            // contracts so existing users keep their billing behavior.
            await customStatement(
              "UPDATE tenants SET billing_mode = 'fixed', "
              'fixed_rate = (SELECT fixed_unit_price FROM app_settings WHERE id = 1) '
              'WHERE (SELECT fixed_rate FROM app_settings WHERE id = 1) = 1',
            );
          }
          if (from < 8) {
            // Property-level billing calculation mode (default 'sharedSlab'
            // keeps existing users' billing behavior unchanged).
            await m.addColumn(appSettings, appSettings.billingCalcMode);
          }
        },
        beforeOpen: (details) async {
          // Enforce foreign-key constraints (off by default in SQLite).
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
