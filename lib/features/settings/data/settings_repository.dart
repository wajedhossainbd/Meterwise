import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';

/// Data access for the single-row [AppSettings] (billing mode/method, language,
/// onboarding state).
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Future<AppSetting> _ensureRow() async {
    final existing = await (_db.select(_db.appSettings)
          ..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (existing != null) return existing;
    await _db
        .into(_db.appSettings)
        .insert(const AppSettingsCompanion(id: Value(1)));
    return (_db.select(_db.appSettings)..where((t) => t.id.equals(1)))
        .getSingle();
  }

  Future<void> ensureSeeded() => _ensureRow();

  Stream<AppSetting?> watch() =>
      (_db.select(_db.appSettings)..where((t) => t.id.equals(1)))
          .watchSingleOrNull();

  Future<AppSetting> get() => _ensureRow();

  Future<void> update({
    bool? multiTenant,
    bool? fixedRate,
    double? fixedUnitPrice,
    String? languageCode,
    bool? onboarded,
    String? fixedChargeDistribution,
    String? billingCalcMode,
    String? themeMode,
    String? invoiceLanguage,
  }) async {
    await _ensureRow();
    await (_db.update(_db.appSettings)..where((t) => t.id.equals(1))).write(
      AppSettingsCompanion(
        multiTenant:
            multiTenant == null ? const Value.absent() : Value(multiTenant),
        fixedRate: fixedRate == null ? const Value.absent() : Value(fixedRate),
        fixedUnitPrice: fixedUnitPrice == null
            ? const Value.absent()
            : Value(fixedUnitPrice),
        languageCode:
            languageCode == null ? const Value.absent() : Value(languageCode),
        onboarded: onboarded == null ? const Value.absent() : Value(onboarded),
        fixedChargeDistribution: fixedChargeDistribution == null
            ? const Value.absent()
            : Value(fixedChargeDistribution),
        billingCalcMode: billingCalcMode == null
            ? const Value.absent()
            : Value(billingCalcMode),
        themeMode: themeMode == null ? const Value.absent() : Value(themeMode),
        invoiceLanguage: invoiceLanguage == null
            ? const Value.absent()
            : Value(invoiceLanguage),
      ),
    );
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(appDatabaseProvider)),
);

/// Reactive app settings (null only momentarily before the row is seeded).
final appSettingsProvider = StreamProvider<AppSetting?>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);

/// Convenience: are we in multi-tenant mode? Defaults to true while loading.
final isMultiTenantProvider = Provider<bool>(
  (ref) => ref.watch(appSettingsProvider).value?.multiTenant ?? true,
);

/// Current app locale derived from the stored language code (defaults to en).
final localeProvider = Provider<Locale>(
  (ref) => Locale(ref.watch(appSettingsProvider).value?.languageCode ?? 'en'),
);
