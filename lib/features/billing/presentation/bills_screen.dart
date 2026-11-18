import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/brand_button.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../properties/data/property_repository.dart';
import '../application/billing_providers.dart';
import '../application/period_actions.dart';
import '../data/bill_payment_repository.dart';
import '../domain/models/billing_result.dart';
import 'period_status_chip.dart';
import 'tenant_bill_detail_screen.dart';

/// Monthly bills: pick a month, see its accounting status, finalize or unlock.
class BillsScreen extends ConsumerWidget {
  const BillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final month = ref.watch(billingMonthProvider);
    final viewAsync = ref.watch(periodViewProvider);
    final currency = ref.watch(currencyCodeProvider);
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.billsTitle)),
      body: Column(
        children: [
          _MonthSelector(month: month),
          const Divider(height: 1),
          Expanded(
            child: AsyncValueView(
              value: viewAsync,
              onRetry: () => ref.invalidate(periodViewProvider),
              data: (view) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _PeriodHeader(view: view),
                  const SizedBox(height: 16),
                  if (view.bill == null)
                    _NoBillCard(l: l)
                  else
                    ..._billSections(
                      context,
                      view.bill!,
                      month: month,
                      monthKey: Formatters.monthKey(month),
                      currency: currency,
                      l: l,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _billSections(
  BuildContext context,
  MonthlyBill monthly, {
  required DateTime month,
  required String monthKey,
  required String currency,
  required AppLocalizations l,
}) {
  String money(num v) => Formatters.money(v, currencyCode: currency);
  return [
    SectionCard(
      title: l.billsMonthSummary,
      child: Column(
        children: [
          LabelValueRow(l.dashMainUnits,
              '${Formatters.units(monthly.mainMeterUnits)} kWh'),
          LabelValueRow(l.dashTenants,
              '${Formatters.units(monthly.totalTenantUnits)} kWh'),
          LabelValueRow(l.dashCommonArea,
              '${Formatters.units(monthly.commonAreaUnits)} kWh'),
          const Divider(),
          LabelValueRow(l.billsTotalBilled, money(monthly.totalBilled)),
          LabelValueRow(l.billsTotalRecharge, money(monthly.totalRecharge)),
          LabelValueRow(
            l.billsOutstanding,
            money(monthly.totalOutstanding),
            emphasize: true,
            valueColor:
                monthly.totalOutstanding > 0 ? AppColors.due : AppColors.credit,
          ),
        ],
      ),
    ),
    const SizedBox(height: 16),
    Text(l.billsTenantBills, style: Theme.of(context).textTheme.titleMedium),
    const SizedBox(height: 8),
    for (final (i, tenant) in monthly.tenantBills.indexed)
      _TenantBillCard(
        bill: tenant,
        month: month,
        monthKey: monthKey,
        currency: currency,
        color: AppColors.chartPalette[i % AppColors.chartPalette.length],
      ),
  ];
}

class _MonthSelector extends ConsumerWidget {
  const _MonthSelector({required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(billingMonthProvider.notifier);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton.filledTonal(
            icon: const Icon(Icons.chevron_left),
            onPressed: controller.previousMonth,
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.25),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                Formatters.monthYear(month),
                key: ValueKey(month),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          IconButton.filledTonal(
            icon: const Icon(Icons.chevron_right),
            onPressed: controller.nextMonth,
          ),
        ],
      ),
    );
  }
}

/// Status banner with the finalize (draft) or unlock (finalized) action.
class _PeriodHeader extends ConsumerStatefulWidget {
  const _PeriodHeader({required this.view});
  final PeriodView view;

  @override
  ConsumerState<_PeriodHeader> createState() => _PeriodHeaderState();
}

class _PeriodHeaderState extends ConsumerState<_PeriodHeader> {
  bool _busy = false;

  Future<void> _finalize() async {
    setState(() => _busy = true);
    final l = AppLocalizations.of(context);
    final errors = await ref.read(periodActionsProvider).finalize(l);
    if (!mounted) return;
    setState(() => _busy = false);
    if (errors.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.periodFinalizedToast)),
      );
    } else {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.periodCannotFinalize),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final e in errors)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('•  '),
                      Expanded(child: Text(e)),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l.actionGotIt)),
          ],
        ),
      );
    }
  }

  Future<void> _unlock() async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.periodUnlockTitle),
        content: Text(l.periodUnlockWarning),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.actionCancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.periodUnlock)),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _busy = true);
    await ref.read(periodActionsProvider).unlock();
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final view = widget.view;
    final finalized = view.isFinalized;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PeriodStatusChip(status: view.status),
                const Spacer(),
                if (_busy)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (finalized)
                  BrandButton(
                    label: l.periodUnlock,
                    icon: Icons.lock_open_outlined,
                    variant: BrandButtonVariant.secondary,
                    onPressed: _unlock,
                  )
                else
                  BrandButton(
                    label: l.periodFinalize,
                    icon: Icons.lock_outlined,
                    onPressed: view.bill == null ? null : _finalize,
                  ),
              ],
            ),
            if (finalized && view.finalizedAt != null) ...[
              const SizedBox(height: 8),
              Text(
                l.periodFinalizedOn(Formatters.date(view.finalizedAt!)),
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant),
              ),
            ] else if (!finalized) ...[
              const SizedBox(height: 8),
              Text(
                l.periodDraftHint,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NoBillCard extends StatelessWidget {
  const _NoBillCard({required this.l});
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.request_quote_outlined, size: 40),
            const SizedBox(height: 12),
            Text(l.billsNoBillTitle,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(l.billsNoBillMsg, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _TenantBillCard extends ConsumerWidget {
  const _TenantBillCard({
    required this.bill,
    required this.month,
    required this.monthKey,
    required this.currency,
    required this.color,
  });

  final TenantBill bill;
  final DateTime month;
  final String monthKey;
  final String currency;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final isCredit = bill.isCredit;
    final paid = ref
            .watch(paidTenantIdsProvider(monthKey))
            .value
            ?.contains(bill.tenantId) ??
        false;

    final Color statusColor;
    final String statusLabel;
    if (paid) {
      statusColor = AppColors.credit;
      statusLabel = l.billsPaid;
    } else if (isCredit) {
      statusColor = AppColors.credit;
      statusLabel = l.billsCreditAmount(
          Formatters.money(bill.balance.abs(), currencyCode: currency));
    } else {
      statusColor = AppColors.due;
      statusLabel = l.billsDueAmount(
          Formatters.money(bill.balance.abs(), currencyCode: currency));
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TenantBillDetailScreen(
              bill: bill,
              month: month,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: color.withValues(alpha: 0.18),
                    foregroundColor: color,
                    child: Text(
                      bill.tenantName.trim().isEmpty
                          ? '?'
                          : bill.tenantName.trim()[0].toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(bill.tenantName,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    Formatters.money(bill.totalBill, currencyCode: currency),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${Formatters.units(bill.billedUnits)} kWh • '
                '${l.billsRecharged(Formatters.money(bill.rechargePaid, currencyCode: currency))}',
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (paid)
                          Icon(Icons.check_circle,
                              size: 14, color: statusColor),
                        if (paid) const SizedBox(width: 4),
                        Text(statusLabel,
                            style: theme.textTheme.labelMedium
                                ?.copyWith(color: statusColor)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      final repo = ref.read(billPaymentRepositoryProvider);
                      if (paid) {
                        repo.unmark(bill.tenantId, monthKey);
                      } else {
                        repo.markPaid(bill.tenantId, monthKey);
                      }
                    },
                    child: Text(paid ? l.billsUnmark : l.billsMarkPaid),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
