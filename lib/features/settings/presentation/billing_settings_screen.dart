import 'package:flutter/material.dart';
import '../../../core/theme/soft_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/application/billing_providers.dart';
import '../data/settings_repository.dart';

/// Configure billing mode (single vs multi-tenant) and how fixed charges are
/// distributed. Per-tenant billing contracts live on each tenant's profile.
class BillingSettingsScreen extends ConsumerStatefulWidget {
  const BillingSettingsScreen({super.key});

  @override
  ConsumerState<BillingSettingsScreen> createState() =>
      _BillingSettingsScreenState();
}

class _BillingSettingsScreenState
    extends ConsumerState<BillingSettingsScreen> {
  Future<void> _update({
    bool? multiTenant,
    String? fixedChargeDistribution,
    String? billingCalcMode,
  }) async {
    await ref.read(settingsRepositoryProvider).update(
          multiTenant: multiTenant,
          fixedChargeDistribution: fixedChargeDistribution,
          billingCalcMode: billingCalcMode,
        );
    ref.invalidate(periodViewProvider);
    ref.invalidate(monthlyHistoryProvider);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.billingTitle)),
      body: AsyncValueView(
        value: settings,
        onRetry: () => ref.invalidate(appSettingsProvider),
        data: (s) {
          if (s == null) return const SizedBox.shrink();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionCard(
                title: l.billingMode,
                child: Column(
                  children: [
                    RadioGroup<bool>(
                      groupValue: s.multiTenant,
                      onChanged: (v) async {
                        if (v == null || v == s.multiTenant) return;
                        if (!v &&
                            !await _confirmSingleMode(context, l)) {
                          return;
                        }
                        await _update(multiTenant: v);
                      },
                      child: Column(
                        children: [
                          RadioListTile<bool>(
                            value: false,
                            title: Text(l.billingModeSingle),
                            subtitle: Text(l.billingModeSingleSub),
                          ),
                          RadioListTile<bool>(
                            value: true,
                            title: Text(l.billingModeMulti),
                            subtitle: Text(l.billingModeMultiSub),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: l.calcModeTitle,
                child: RadioGroup<String>(
                  groupValue: s.billingCalcMode,
                  onChanged: (v) {
                    if (v != null) _update(billingCalcMode: v);
                  },
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        value: 'sharedSlab',
                        title: Text(l.calcModeSharedSlab),
                        subtitle: Text(l.calcModeSharedSlabSub),
                      ),
                      RadioListTile<String>(
                        value: 'reconciled',
                        title: Text(l.calcModeReconciled),
                        subtitle: Text(l.calcModeReconciledSub),
                      ),
                      RadioListTile<String>(
                        value: 'fixedRate',
                        title: Text(l.calcModeFixed),
                        subtitle: Text(l.calcModeFixedSub),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: l.distributionTitle,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.distributionSub,
                        style: Theme.of(context).textTheme.bodySmall),
                    RadioGroup<String>(
                      groupValue: s.fixedChargeDistribution,
                      onChanged: (v) {
                        if (v != null) _update(fixedChargeDistribution: v);
                      },
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            value: 'equal',
                            title: Text(l.distributionEqual),
                            subtitle: Text(l.distributionEqualSub),
                          ),
                          RadioListTile<String>(
                            value: 'usage',
                            title: Text(l.distributionUsage),
                            subtitle: Text(l.distributionUsageSub),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SoftCard(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(child: Text(l.billingPerTenantHint)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _confirmSingleMode(BuildContext context, AppLocalizations l) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.billingModeSingle),
        content: Text(l.billingModeSwitchWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l.actionSave),
          ),
        ],
      ),
    );
    return ok == true;
  }

}
