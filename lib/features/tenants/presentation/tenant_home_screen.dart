import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/application/billing_providers.dart';
import '../../billing/domain/models/billing_result.dart';
import '../../billing/presentation/tenant_bill_detail_screen.dart';
import '../../properties/data/property_repository.dart';
import '../../settings/data/settings_repository.dart';

/// Tenant-scoped view: the numbers that matter to one tenant, and nothing of
/// the other tenants or the owner's benefit. Data comes from the same engine.
class TenantHomeScreen extends ConsumerWidget {
  const TenantHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final identity = ref.watch(tenantIdentityProvider);
    final currency = ref.watch(currencyCodeProvider);
    final month = ref.watch(billingMonthProvider);
    final viewAsync = ref.watch(periodViewProvider);

    if (!identity.approved) {
      return Scaffold(
        appBar: AppBar(title: Text(l.tenantHomeTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.hourglass_top,
                    size: 56, color: theme.colorScheme.primary),
                const SizedBox(height: 16),
                Text(l.tenantPendingApproval,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l.tenantHomeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2),
            tooltip: l.tenantMeterCode,
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(identity.code ?? '')),
            ),
          ),
        ],
      ),
      body: viewAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l.commonSomethingWrong)),
        data: (view) {
          final bill = view.bill?.tenantBills
              .where((b) => b.tenantName == identity.name)
              .cast<TenantBill?>()
              .firstOrNull;
          if (bill == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(l.commonSomethingWrong,
                    textAlign: TextAlign.center),
              ),
            );
          }
          String money(num v) => Formatters.money(v, currencyCode: currency);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: bill.isCredit ? AppColors.credit : AppColors.due,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(identity.name ?? '',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(color: Colors.white)),
                    Text(Formatters.monthYear(month),
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white70)),
                    const SizedBox(height: 12),
                    Text(money(bill.balance.abs()),
                        style: theme.textTheme.headlineLarge
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                    Text(bill.isCredit
                        ? l.invoiceCarryForward
                        : l.invoiceAmountDue,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: l.tenantHomeTitle,
                child: Column(
                  children: [
                    _row(l.dashMainUnits,
                        '${Formatters.units(view.bill?.mainMeterUnits ?? 0)} kWh'),
                    _row(l.invoiceOwnConsumption,
                        '${Formatters.units(bill.ownUnits)} kWh'),
                    _row(l.invoiceCommonShare,
                        '${Formatters.units(bill.commonUnits)} kWh'),
                    _row(l.invoiceBilledUnits,
                        '${Formatters.units(bill.billedUnits)} kWh'),
                    _row(l.effectiveRateLabel,
                        '${money(bill.effectiveRate)} / kWh'),
                    _row(l.invoiceTotalBill, money(bill.totalBill)),
                  ],
                ),
              ),
              if (bill.ownUnits == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(l.tenantNoSubMeter,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ),
              const SizedBox(height: 16),
              SectionCard(
                title: l.invoicePayment,
                child: Column(
                  children: [
                    _row(l.invoicePreviousBalance,
                        money(bill.previousBalance)),
                    _row(l.invoiceRechargePaid, money(bill.rechargePaid)),
                    _row(l.invoiceAvailableBalance,
                        money(bill.availableBalance)),
                    _row(l.invoiceTotalBill, money(bill.totalBill)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () => context.pushNamed(AppRoutes.tenantEntryName),
                icon: const Icon(Icons.edit_outlined),
                label: Text(l.tenantSelfEntry),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TenantBillDetailScreen(
                      bill: bill,
                      month: month,
                    ),
                  ),
                ),
                icon: const Icon(Icons.receipt_long),
                label: Text(l.invoiceTitle),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      );
}
