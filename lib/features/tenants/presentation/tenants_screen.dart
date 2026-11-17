import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/database/app_database.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feature_placeholder.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../readings/data/reading_repository.dart';
import '../data/tenant_repository.dart';

/// Lists tenants with last reading and quick actions (call / WhatsApp / edit).
class TenantsScreen extends ConsumerWidget {
  const TenantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenants = ref.watch(tenantListProvider);
    final hasMeter = ref.watch(currentMainMeterProvider).value != null;
    final readings = ref.watch(readingListProvider).value ?? const [];
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.tenantsTitle)),
      floatingActionButton: hasMeter
          ? FloatingActionButton.extended(
              onPressed: () async {
                final saved =
                    await context.pushNamed<bool>(AppRoutes.addTenantName);
                if (saved == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l.tenantSaved)),
                  );
                }
              },
              icon: const Icon(Icons.person_add),
              label: Text(l.tenantAdd),
            )
          : null,
      body: AsyncValueView(
        value: tenants,
        data: (list) {
          if (!hasMeter) {
            return FeaturePlaceholder(
              icon: Icons.warning_amber_outlined,
              title: l.tenantSetupFirstTitle,
              message: l.tenantSetupFirstMsg,
            );
          }
          if (list.isEmpty) {
            return FeaturePlaceholder(
              icon: Icons.people_outline,
              title: l.tenantsEmptyTitle,
              message: l.tenantsEmptyMsg,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, i) => _TenantCard(
              tenant: list[i],
              readings: readings,
              color:
                  AppColors.chartPalette[i % AppColors.chartPalette.length],
            ),
          );
        },
      ),
    );
  }
}

class _TenantCard extends ConsumerWidget {
  const _TenantCard({
    required this.tenant,
    required this.readings,
    required this.color,
  });

  final Tenant tenant;
  final List<MeterReading> readings;
  final Color color;

  double? get _lastReading {
    final mine = readings.where((r) => r.tenantId == tenant.id).toList()
      ..sort((a, b) => b.readingDate.compareTo(a.readingDate));
    return mine.isEmpty ? null : mine.first.readingValue;
  }

  Future<void> _launch(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${uri.scheme}')),
      );
    }
  }

  String _digits(String phone) => phone.replaceAll(RegExp(r'[^0-9+]'), '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final last = _lastReading;
    final hasPhone = tenant.phone != null && tenant.phone!.trim().isNotEmpty;
    final subtitle = [
      if (tenant.apartment != null && tenant.apartment!.isNotEmpty)
        '${l.tenantApartment} ${tenant.apartment}',
      if (tenant.meterNumber != null && tenant.meterNumber!.isNotEmpty)
        '${l.meterNumber} ${tenant.meterNumber}',
      if (tenant.billingMode == 'fixed')
        l.tenantFixedChip(
            Formatters.units(tenant.fixedRate ?? 0))
      else
        l.tenantModeShared,
    ].join(' • ');

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.18),
                  foregroundColor: color,
                  child: Text(_initial(tenant.name),
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tenant.name, style: theme.textTheme.titleMedium),
                      if (subtitle.isNotEmpty)
                        Text(subtitle,
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant)),
                      Text(
                        last == null
                            ? l.tenantNoReadings
                            : l.tenantLastReading(Formatters.units(last)),
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  tooltip: l.tenantCall,
                  icon: const Icon(Icons.call_outlined),
                  onPressed: hasPhone
                      ? () => _launch(
                          context, Uri.parse('tel:${_digits(tenant.phone!)}'))
                      : null,
                ),
                IconButton(
                  tooltip: l.tenantWhatsapp,
                  icon: const Icon(Icons.chat_outlined),
                  onPressed: hasPhone
                      ? () => _launch(context,
                          Uri.parse('https://wa.me/${_digits(tenant.phone!)}'))
                      : null,
                ),
                const Spacer(),
                TextButton.icon(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: Text(l.actionEdit),
                  onPressed: () async {
                    final saved = await context.pushNamed<bool>(
                      AppRoutes.editTenantName,
                      extra: tenant,
                    );
                    if (saved == true && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l.tenantSaved)),
                      );
                    }
                  },
                ),
                IconButton(
                  tooltip: l.actionDelete,
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _confirmDelete(context, ref),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.tenantDeleteTitle),
        content: Text(l.tenantDeleteMsg(tenant.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      try {
        await ref.read(tenantRepositoryProvider).delete(tenant.id);
      } on FinalizedPeriodException {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.periodLockedMessage)),
          );
        }
      }
    }
  }

  String _initial(String name) =>
      name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();
}
