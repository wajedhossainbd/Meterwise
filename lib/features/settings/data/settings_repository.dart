import 'dart:math';

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
    String? appRole,
    String? meterCode,
    String? joinedMeterCode,
    String? tenantName,
    bool? tenantApproved,
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
        appRole: appRole == null ? const Value.absent() : Value(appRole),
        meterCode: meterCode == null ? const Value.absent() : Value(meterCode),
        joinedMeterCode: joinedMeterCode == null
            ? const Value.absent()
            : Value(joinedMeterCode),
        tenantName:
            tenantName == null ? const Value.absent() : Value(tenantName),
        tenantApproved: tenantApproved == null
            ? const Value.absent()
            : Value(tenantApproved),
      ),
    );
  }

  /// Returns the landlord's shareable meter code, generating one on first use.
  /// Format `MW-XXXX-XXXX` — unambiguous to read aloud and QR-friendly.
  Future<String> ensureMeterCode() async {
    final current = await get();
    if (current.meterCode != null && current.meterCode!.isNotEmpty) {
      return current.meterCode!;
    }
    const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final random = Random();
    String block(int length) => List.generate(
          length,
          (_) => alphabet[random.nextInt(alphabet.length)],
        ).join();
    final code = 'MW-${block(4)}-${block(4)}';
    await update(meterCode: code);
    return code;
  }

  /// Switch this install between landlord and tenant views (local prototype).
  Future<void> setRole(String role) => update(appRole: role);

  /// Tenant joins a meter by code and picks their name from the landlord's roster.
  Future<void> joinMeter({required String code, required String name}) =>
      update(
        appRole: 'tenant',
        joinedMeterCode: code.trim().toUpperCase(),
        tenantName: name.trim(),
        tenantApproved: false,
      );

  /// Landlord approves a pending tenant join.
  Future<void> approveTenant() => update(tenantApproved: true);

  /// Leave the joined meter and return to landlord mode.
  Future<void> leaveMeter() => update(
        appRole: 'landlord',
        joinedMeterCode: null,
        tenantName: null,
        tenantApproved: false,
      );
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

/// The landlord's shareable code, created on first open of the invite screen.
final meterCodeProvider = FutureProvider<String>(
  (ref) => ref.watch(settingsRepositoryProvider).ensureMeterCode(),
);

/// 'landlord' or 'tenant' — scoped UI is chosen from this.
final appRoleProvider = Provider<String>(
  (ref) => ref.watch(appSettingsProvider).value?.appRole ?? 'landlord',
);

/// The tenant identity chosen after joining a meter.
final tenantIdentityProvider = Provider<({String? code, String? name, bool approved})>(
  (ref) {
    final s = ref.watch(appSettingsProvider).value;
    return (
      code: s?.joinedMeterCode,
      name: s?.tenantName,
      approved: s?.tenantApproved ?? false,
    );
  },
);

/// Current app locale derived from the stored language code (defaults to en).
final localeProvider = Provider<Locale>(
  (ref) => Locale(ref.watch(appSettingsProvider).value?.languageCode ?? 'en'),
);
