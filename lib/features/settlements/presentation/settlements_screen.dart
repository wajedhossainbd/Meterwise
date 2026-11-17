import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feature_placeholder.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/billing_period_repository.dart';
import '../../billing/data/period_guard.dart';
import '../../properties/data/property_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/settlement_repository.dart';
import 'settlement_edit_screen.dart';

/// Lists tenant-to-tenant settlements with add / delete.
class SettlementsScreen extends ConsumerWidget {
  const SettlementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settlements = ref.watch(settlementListProvider);
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final names = {for (final t in tenants) t.id: t.name};
    final currency = ref.watch(currencyCodeProvider);
    final finalizedMonths =
        ref.watch(finalizedMonthsProvider).value ?? const <String>{};
    final canAdd = tenants.length >= 2;
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.settlementsTitle)),
      floatingActionButton: canAdd
          ? FloatingActionButton.extended(
              onPressed: () async {
                final saved = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => const SettlementEditScreen(),
                  ),
                );
                if (saved == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l.settlementSaved)),
                  );
                }
              },
              icon: const Icon(Icons.swap_horiz),
              label: Text(l.settlementAdd),
            )
          : null,
      body: AsyncValueView(
        value: settlements,
        onRetry: () => ref.invalidate(settlementListProvider),
        data: (list) {
          if (!canAdd) {
            return FeaturePlaceholder(
              icon: Icons.swap_horiz,
              title: l.settlementsNeedTwoTitle,
              message: l.settlementsNeedTwoMsg,
            );
          }
          if (list.isEmpty) {
            return FeaturePlaceholder(
              icon: Icons.swap_horiz,
              title: l.settlementsEmptyTitle,
              message: l.settlementsEmptyMsg,
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 96, top: 8),
            itemCount: list.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final s = list[i];
              final locked = finalizedMonths
                  .contains(Formatters.monthKey(s.settlementDate));
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.violet.withValues(alpha: 0.16),
                  foregroundColor: AppColors.violet,
                  child: const Icon(Icons.swap_horiz),
                ),
                title: Text(
                  '${names[s.fromTenantId] ?? 'Tenant'} → '
                  '${names[s.toTenantId] ?? 'Tenant'}',
                ),
                subtitle: Text(Formatters.date(s.settlementDate)),
                trailing: locked
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Formatters.money(s.amount, currencyCode: currency),
                            style:
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.lock_outline,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            Formatters.money(s.amount, currencyCode: currency),
                            style:
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _delete(context, ref, s.id),
                          ),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, int id) async {
    try {
      await ref.read(settlementRepositoryProvider).delete(id);
    } on FinalizedPeriodException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).periodLockedMessage)),
        );
      }
    }
  }
}
