import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/feature_placeholder.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/billing_period_repository.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../data/recharge_repository.dart';

/// Lists recharge transactions, newest first.
class RechargeScreen extends ConsumerWidget {
  const RechargeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recharges = ref.watch(rechargeListProvider);
    final currency = ref.watch(currencyCodeProvider);
    final ready = ref.watch(isSetupCompleteProvider);
    final finalizedMonths =
        ref.watch(finalizedMonthsProvider).value ?? const <String>{};
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.rechargeTitle)),
      floatingActionButton: ready
          ? FloatingActionButton.extended(
              onPressed: () async {
                final saved =
                    await context.pushNamed<bool>(AppRoutes.addRechargeName);
                if (saved == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l.rechargeSaved)),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: Text(l.rechargeAdd),
            )
          : null,
      body: !ready
          ? FeaturePlaceholder(
              icon: Icons.warning_amber_outlined,
              title: l.finishSetupTitle,
              message: l.finishSetupMsg,
            )
          : AsyncValueView(
              value: recharges,
              onRetry: () => ref.invalidate(rechargeListProvider),
              data: (list) {
                if (list.isEmpty) {
                  return FeaturePlaceholder(
                    icon: Icons.bolt_outlined,
                    title: l.rechargeEmptyTitle,
                    message: l.rechargeEmptyMsg,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96, top: 8),
                  itemCount: list.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final r = list[i];
                    final locked = finalizedMonths
                        .contains(Formatters.monthKey(r.rechargeDate));
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            AppColors.accentOrange.withValues(alpha: 0.16),
                        foregroundColor: AppColors.accentOrange,
                        child: const Icon(Icons.bolt),
                      ),
                      title: Text(
                        Formatters.money(r.amount, currencyCode: currency),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        [
                          Formatters.date(r.rechargeDate),
                          if (r.paidBy != null && r.paidBy!.isNotEmpty)
                            l.rechargeBy(r.paidBy!),
                        ].join(' • '),
                      ),
                      trailing: locked
                          ? Icon(Icons.lock_outline,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant)
                          : IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDelete(context, ref, r),
                            ),
                      onTap: () async {
                        if (locked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.periodLockedMessage)),
                          );
                          return;
                        }
                        final saved = await context.pushNamed<bool>(
                          AppRoutes.editRechargeName,
                          extra: r,
                        );
                        if (saved == true && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.rechargeUpdated)),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Recharge r) async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.rechargeDeleteTitle),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.actionCancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.actionDelete)),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;

    try {
      await ref.read(rechargeRepositoryProvider).delete(r.id);
    } on FinalizedPeriodException {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.periodLockedMessage)),
        );
      }
      return;
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l.rechargeDeleted),
          action: SnackBarAction(
            label: l.actionUndo,
            onPressed: () {
              ref.read(rechargeRepositoryProvider).create(
                    r.mainMeterId,
                    (
                      date: r.rechargeDate,
                      amount: r.amount,
                      energyCost: r.energyCost,
                      demandCharge: r.demandCharge,
                      meterRent: r.meterRent,
                      vat: r.vat,
                      rebate: r.rebate,
                      agentFee: r.agentFee,
                      otherExpenses: r.otherExpenses,
                      paidBy: r.paidBy,
                      tokenNumber: r.tokenNumber,
                      notes: r.notes,
                      receiptPath: r.receiptPath,
                    ),
                  );
            },
          ),
        ),
      );
  }
}
