import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/core/database/app_database.dart';
import 'package:meterwise/features/billing/data/billing_period_repository.dart';
import 'package:meterwise/features/billing/domain/models/tariff.dart';
import 'package:meterwise/features/tariff/data/tariff_version_repository.dart';
import 'package:sqlite3/sqlite3.dart';

/// Verifies the v3 → v4 upgrade preserves existing data and creates the new
/// accounting tables (TariffVersions, BillingPeriods).
void main() {
  test('v3 → v4 migration keeps data and adds new tables', () async {
    final raw = sqlite3.openInMemory();

    // 1. Open at the current version to create the full schema, seed some data.
    final v4 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    final propId = await v4.into(v4.properties).insert(
          PropertiesCompanion.insert(name: 'Rahman Villa'),
        );
    final providerId = await v4.into(v4.electricityProviders).insert(
          ElectricityProvidersCompanion.insert(name: 'DPDC'),
        );
    final meterId = await v4.into(v4.mainMeters).insert(
          MainMetersCompanion.insert(
            propertyId: propId,
            providerId: providerId,
            name: 'Ground Floor',
          ),
        );
    await v4.into(v4.meterReadings).insert(
          MeterReadingsCompanion.insert(
            mainMeterId: Value(meterId),
            readingDate: DateTime(2026, 5, 31),
            readingValue: 1250,
          ),
        );
    await v4.close();

    // 2. Simulate an older v3 database: drop everything added after v3 and
    //    lower the schema version. The user's existing data
    //    (property/meter/reading) remains.
    raw.execute('DROP TABLE billing_periods');
    raw.execute('DROP TABLE tariff_versions');
    raw.execute('DROP TABLE settlements');
    raw.execute('ALTER TABLE tenants DROP COLUMN billing_mode');
    raw.execute('ALTER TABLE tenants DROP COLUMN fixed_rate');
    raw.execute(
        'ALTER TABLE app_settings DROP COLUMN fixed_charge_distribution');
    raw.execute('ALTER TABLE app_settings DROP COLUMN billing_calc_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN theme_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN invoice_language');
    raw.execute('ALTER TABLE app_settings DROP COLUMN app_role');
    raw.execute('ALTER TABLE app_settings DROP COLUMN meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN joined_meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_name');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_approved');
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 3');

    // 3. Re-open: drift runs onUpgrade(3 → 4), recreating the new tables.
    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    // Existing data survived the upgrade.
    final properties = await upgraded.select(upgraded.properties).get();
    expect(properties.length, 1);
    expect(properties.first.name, 'Rahman Villa');

    final readings = await upgraded.select(upgraded.meterReadings).get();
    expect(readings.length, 1);
    expect(readings.first.readingValue, 1250);

    // New accounting tables exist and are usable.
    final periodRepo = BillingPeriodRepository(upgraded);
    final period = await periodRepo.getOrCreate(propId, 2026, 5);
    expect(period.status, 'draft');

    await upgraded.close();
    raw.close();
  });

  test('v6 → v7 migrates the legacy global fixed rate to per-tenant contracts',
      () async {
    final raw = sqlite3.openInMemory();

    // Create current schema and seed: a property/meter/tenants + legacy
    // global fixed-rate settings row.
    final v7 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    final propId = await v7.into(v7.properties).insert(
          PropertiesCompanion.insert(name: 'P'),
        );
    final providerId = await v7.into(v7.electricityProviders).insert(
          ElectricityProvidersCompanion.insert(name: 'DPDC'),
        );
    final meterId = await v7.into(v7.mainMeters).insert(
          MainMetersCompanion.insert(
              propertyId: propId, providerId: providerId, name: 'M'),
        );
    await v7.into(v7.tenants).insert(
        TenantsCompanion.insert(mainMeterId: meterId, name: 'A'));
    await v7.into(v7.tenants).insert(
        TenantsCompanion.insert(mainMeterId: meterId, name: 'B'));
    await v7.close();

    // Downgrade to a v6 shape: drop the v7 columns, set legacy global fixed
    // rate ON at 9.5/unit, and set user_version=6.
    raw.execute('ALTER TABLE tenants DROP COLUMN billing_mode');
    raw.execute('ALTER TABLE tenants DROP COLUMN fixed_rate');
    raw.execute(
        'ALTER TABLE app_settings DROP COLUMN fixed_charge_distribution');
    raw.execute('ALTER TABLE app_settings DROP COLUMN billing_calc_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN theme_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN invoice_language');
    raw.execute('ALTER TABLE app_settings DROP COLUMN app_role');
    raw.execute('ALTER TABLE app_settings DROP COLUMN meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN joined_meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_name');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_approved');
    raw.execute(
        'INSERT INTO app_settings (id, multi_tenant, fixed_rate, fixed_unit_price, language_code, onboarded) '
        "VALUES (1, 1, 1, 9.5, 'en', 1)");
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 6');

    // Re-open → onUpgrade(6 → 7) runs.
    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    final tenants = await upgraded.select(upgraded.tenants).get();
    expect(tenants.length, 2);
    for (final t in tenants) {
      expect(t.billingMode, 'fixed'); // migrated from global setting
      expect(t.fixedRate, 9.5);
    }
    final settings =
        await upgraded.select(upgraded.appSettings).getSingle();
    expect(settings.fixedChargeDistribution, 'equal'); // new default

    await upgraded.close();
    raw.close();
  });

  test('v4 → v5 migration adds the archived column without data loss', () async {
    final raw = sqlite3.openInMemory();

    final v5 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    await TariffVersionRepository(v5).createVersion(
      label: 'Version 1',
      effectiveFrom: DateTime(2000),
      tariff: const Tariff(
        slabs: [TariffSlabRange(fromUnit: 0, toUnit: null, rate: 5)],
        demandCharge: 84,
        meterRent: 40,
        vatPercent: 5,
        rebatePercent: 0,
      ),
    );
    await v5.close();

    // Simulate a v4 database: tariff_versions existed without `archived`,
    // and nothing added after v4 exists yet.
    raw.execute('ALTER TABLE tariff_versions DROP COLUMN archived');
    raw.execute('DROP TABLE settlements');
    raw.execute('ALTER TABLE tenants DROP COLUMN billing_mode');
    raw.execute('ALTER TABLE tenants DROP COLUMN fixed_rate');
    raw.execute(
        'ALTER TABLE app_settings DROP COLUMN fixed_charge_distribution');
    raw.execute('ALTER TABLE app_settings DROP COLUMN billing_calc_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN theme_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN invoice_language');
    raw.execute('ALTER TABLE app_settings DROP COLUMN app_role');
    raw.execute('ALTER TABLE app_settings DROP COLUMN meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN joined_meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_name');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_approved');
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 4');

    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    final repo = TariffVersionRepository(upgraded);
    final versions = await repo.getAll();
    expect(versions.length, 1);
    expect(versions.first.archived, isFalse); // new column, default value
    // Resolution still works after the upgrade.
    expect((await repo.tariffForDate(DateTime(2026, 1, 1))).demandCharge, 84);

    await upgraded.close();
    raw.close();
  });

  test('v7 → v8 migration adds billing calculation mode with the default',
      () async {
    final raw = sqlite3.openInMemory();

    final v8 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    await v8.into(v8.properties).insert(
          PropertiesCompanion.insert(name: 'P'),
        );
    await v8.close();

    raw.execute('ALTER TABLE app_settings DROP COLUMN billing_calc_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN theme_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN invoice_language');
    raw.execute('ALTER TABLE app_settings DROP COLUMN app_role');
    raw.execute('ALTER TABLE app_settings DROP COLUMN meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN joined_meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_name');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_approved');
    raw.execute(
        'INSERT INTO app_settings (id, multi_tenant, fixed_rate, fixed_unit_price, '
        'language_code, onboarded, fixed_charge_distribution) '
        "VALUES (1, 1, 0, 8, 'en', 1, 'equal')");
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 7');

    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    final settings = await upgraded.select(upgraded.appSettings).getSingle();
    expect(settings.billingCalcMode, 'sharedSlab');

    await upgraded.close();
    raw.close();
  });

  test('v8 → v9 migration adds persisted theme mode with the default', () async {
    final raw = sqlite3.openInMemory();

    final v9 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    await v9.into(v9.properties).insert(
          PropertiesCompanion.insert(name: 'P'),
        );
    await v9.close();

    raw.execute('ALTER TABLE app_settings DROP COLUMN theme_mode');
    raw.execute('ALTER TABLE app_settings DROP COLUMN invoice_language');
    raw.execute('ALTER TABLE app_settings DROP COLUMN app_role');
    raw.execute('ALTER TABLE app_settings DROP COLUMN meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN joined_meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_name');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_approved');
    raw.execute(
        'INSERT INTO app_settings (id, multi_tenant, fixed_rate, fixed_unit_price, '
        'language_code, onboarded, fixed_charge_distribution, billing_calc_mode) '
        "VALUES (1, 1, 0, 8, 'en', 1, 'equal', 'sharedSlab')");
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 8');

    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    final settings = await upgraded.select(upgraded.appSettings).getSingle();
    expect(settings.themeMode, 'system');
    expect((await upgraded.select(upgraded.properties).getSingle()).name, 'P');

    await upgraded.close();
    raw.close();
  });

  test('v9 → v10 migration adds invoice language with the auto default',
      () async {
    final raw = sqlite3.openInMemory();

    final v10 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    await v10.into(v10.properties).insert(
          PropertiesCompanion.insert(name: 'P'),
        );
    await v10.close();

    raw.execute('ALTER TABLE app_settings DROP COLUMN invoice_language');
    raw.execute('ALTER TABLE app_settings DROP COLUMN app_role');
    raw.execute('ALTER TABLE app_settings DROP COLUMN meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN joined_meter_code');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_name');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_approved');
    raw.execute(
        'INSERT INTO app_settings (id, multi_tenant, fixed_rate, fixed_unit_price, '
        'language_code, onboarded, fixed_charge_distribution, billing_calc_mode, theme_mode) '
        "VALUES (1, 1, 0, 8, 'en', 1, 'equal', 'sharedSlab', 'system')");
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 9');

    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    final settings = await upgraded.select(upgraded.appSettings).getSingle();
    expect(settings.invoiceLanguage, 'auto');
    expect(settings.themeMode, 'system');

    await upgraded.close();
    raw.close();
  });

  test('v10 → v11 migration adds tenant role fields with landlord defaults',
      () async {
    final raw = sqlite3.openInMemory();

    final v11 = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );
    await v11.into(v11.properties).insert(
          PropertiesCompanion.insert(name: 'P'),
        );
    await v11.close();

    for (final column in [
      'app_role',
      'meter_code',
      'joined_meter_code',
      'tenant_name',
      'tenant_approved',
    ]) {
      raw.execute('ALTER TABLE app_settings DROP COLUMN $column');
    }
    raw.execute(
        'INSERT INTO app_settings (id, multi_tenant, fixed_rate, fixed_unit_price, '
        'language_code, onboarded, fixed_charge_distribution, billing_calc_mode, '
        'theme_mode, invoice_language) '
        "VALUES (1, 1, 0, 8, 'en', 1, 'equal', 'sharedSlab', 'system', 'auto')");
    raw.execute('ALTER TABLE recharges DROP COLUMN paid_by_tenant_id');
    raw.execute('ALTER TABLE app_settings DROP COLUMN tenant_id');
    raw.execute('PRAGMA user_version = 10');

    final upgraded = AppDatabase.forTesting(
      NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
    );

    final settings = await upgraded.select(upgraded.appSettings).getSingle();
    expect(settings.appRole, 'landlord');
    expect(settings.meterCode, isNull);
    expect(settings.joinedMeterCode, isNull);
    expect(settings.tenantName, isNull);
    expect(settings.tenantApproved, isFalse);

    await upgraded.close();
    raw.close();
  });
}
