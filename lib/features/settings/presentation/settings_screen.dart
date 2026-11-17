import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/settings_repository.dart';

/// Settings hub: setup entry points, appearance and currency.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _currencies = ['BDT', 'USD', 'EUR', 'GBP', 'INR', 'PKR'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeControllerProvider);
    final themeController = ref.read(themeModeControllerProvider.notifier);

    final property = ref.watch(currentPropertyProvider).value;
    final meter = ref.watch(currentMainMeterProvider).value;
    final tenantCount = ref.watch(tenantListProvider).value?.length ?? 0;
    final currency = ref.watch(currencyCodeProvider);
    final multiTenant = ref.watch(isMultiTenantProvider);
    final settings = ref.watch(appSettingsProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l.navSettings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _sectionLabel(context, l.settingsSetup),
          ListTile(
            leading: _iconBadge(Icons.apartment_outlined, AppColors.seed),
            title: Text(l.settingsProperty),
            subtitle: Text(property?.name ?? '—'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRoutes.propertyName),
          ),
          ListTile(
            leading:
                _iconBadge(Icons.electric_meter_outlined, AppColors.cyan),
            title: Text(l.settingsMainMeter),
            subtitle: Text(meter?.name ?? '—'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRoutes.mainMeterName),
          ),
          if (multiTenant)
            ListTile(
              leading: _iconBadge(Icons.people_outline, AppColors.teal),
              title: Text(l.settingsTenants),
              subtitle: Text('$tenantCount'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.pushNamed(AppRoutes.tenantsName),
            ),
          if (multiTenant)
            ListTile(
              leading: _iconBadge(Icons.swap_horiz, AppColors.violet),
              title: Text(l.settingsSettlements),
              subtitle: Text(l.settingsSettlementsSub),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.pushNamed(AppRoutes.settlementsName),
            ),
          ListTile(
            leading: _iconBadge(Icons.tune, AppColors.accentOrange),
            title: Text(l.settingsBilling),
            subtitle: Text(multiTenant ? l.onboardingMulti : l.onboardingSingle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRoutes.billingName),
          ),
          ListTile(
            leading:
                _iconBadge(Icons.receipt_long_outlined, AppColors.powerYellow),
            title: Text(l.settingsTariff),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRoutes.tariffName),
          ),
          ListTile(
            leading: _iconBadge(Icons.backup_outlined, AppColors.credit),
            title: Text(l.settingsBackup),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.pushNamed(AppRoutes.backupName),
          ),
          const Divider(),
          _sectionLabel(context, l.settingsAppearance),
          RadioGroup<ThemeMode>(
            groupValue: themeMode,
            onChanged: (m) {
              if (m == null) return;
              themeController.setThemeMode(m);
              ref
                  .read(settingsRepositoryProvider)
                  .update(themeMode: themeModeToStorage(m));
            },
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  title: Text(l.settingsSystem),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  title: Text(l.settingsLight),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  title: Text(l.settingsDark),
                ),
              ],
            ),
          ),
          const Divider(),
          _sectionLabel(context, l.settingsLanguage),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(l.settingsLanguage),
            trailing: DropdownButton<String>(
              value: settings?.languageCode ?? 'en',
              underline: const SizedBox.shrink(),
              onChanged: (v) {
                if (v != null) {
                  ref.read(settingsRepositoryProvider).update(languageCode: v);
                }
              },
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'bn', child: Text('বাংলা')),
              ],
            ),
          ),
          const Divider(),
          _sectionLabel(context, l.invoiceLanguage),
          RadioGroup<String>(
            groupValue: settings?.invoiceLanguage ?? 'auto',
            onChanged: (v) {
              if (v != null) {
                ref
                    .read(settingsRepositoryProvider)
                    .update(invoiceLanguage: v);
              }
            },
            child: Column(
              children: [
                RadioListTile<String>(
                  value: 'auto',
                  title: Text(l.invoiceLanguageAuto),
                ),
                RadioListTile<String>(
                  value: 'en',
                  title: Text(l.invoiceLanguageEn),
                ),
                RadioListTile<String>(
                  value: 'bn',
                  title: Text(l.invoiceLanguageBn),
                ),
              ],
            ),
          ),
          const Divider(),
          _sectionLabel(context, l.settingsCurrency),
          ListTile(
            leading: const Icon(Icons.payments_outlined),
            title: Text(l.settingsCurrency),
            trailing: DropdownButton<String>(
              value: _currencies.contains(currency) ? currency : null,
              hint: Text(currency),
              underline: const SizedBox.shrink(),
              onChanged: property == null
                  ? null
                  : (v) async {
                      if (v == null) return;
                      try {
                        await ref
                            .read(propertyRepositoryProvider)
                            .setCurrency(v);
                      } on FinalizedPeriodException {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(l.periodLockedMessage)),
                          );
                        }
                      }
                    },
              items: [
                for (final c in _currencies)
                  DropdownMenuItem(value: c, child: Text(c)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '${AppConstants.appName} • v${AppConstants.appVersion}',
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _iconBadge(IconData icon, Color color) => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 22),
      );

  Widget _sectionLabel(BuildContext context, String text) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
}
