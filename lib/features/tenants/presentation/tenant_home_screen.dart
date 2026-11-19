import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/soft_ui.dart';
import '../../../core/widgets/brand_button.dart';
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
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'leave') {
                await ref.read(settingsRepositoryProvider).leaveMeter();
              } else if (value == 'landlord') {
                // Same-device prototype: switch roles without dropping the
                // join, so the owner can approve and then switch back.
                await ref
                    .read(settingsRepositoryProvider)
                    .setRole('landlord');
              } else if (value == 'sync' && context.mounted) {
                context.pushNamed(AppRoutes.driveSyncName);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'sync',
                child: Row(
                  children: [
                    const Icon(Icons.cloud_sync_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(l.driveSyncTitle),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'landlord',
                child: Row(
                  children: [
                    const Icon(Icons.admin_panel_settings_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(l.tenantSwitchLandlord),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'leave',
                child: Row(
                  children: [
                    const Icon(Icons.logout, size: 18),
                    const SizedBox(width: 8),
                    Text(l.tenantLeave),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: !identity.approved
          ? Center(
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
                    const SizedBox(height: 20),
                    BrandButton(
                      label: l.tenantCheckStatus,
                      icon: Icons.refresh,
                      variant: BrandButtonVariant.secondary,
                      onPressed: () {
                        ref.invalidate(appSettingsProvider);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.tenantPendingApproval)),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          : viewAsync.when(
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
                padding: const EdgeInsets.all(AppTokens.s6),
                decoration: BoxDecoration(
                  gradient: bill.isCredit
                      ? SoftGradient.credit
                      : SoftGradient.due,
                  borderRadius: BorderRadius.circular(AppTokens.radiusSurface),
                  boxShadow: Soft.raised(context, depth: SoftDepth.strong),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppTokens.s2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(
                                AppTokens.radiusControl),
                          ),
                          child: Icon(
                            bill.isCredit
                                ? Icons.savings_outlined
                                : Icons.account_balance_wallet_outlined,
                            size: AppTokens.iconMedium,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppTokens.s3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(identity.name ?? '',
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(color: Colors.white)),
                              Text(Formatters.monthYear(month),
                                  style: theme.textTheme.bodySmall
                                      ?.copyWith(
                                          color: Colors.white
                                              .withValues(alpha: 0.88))),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTokens.s2,
                            vertical: AppTokens.s1,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.20),
                            borderRadius:
                                BorderRadius.circular(AppTokens.radiusChip),
                          ),
                          child: Text(
                            bill.isCredit
                                ? l.invoiceCarryForward
                                : l.invoiceAmountDue,
                            style: const TextStyle(
                              fontSize: AppTokens.textCaption,
                              fontWeight: AppTokens.weightSemibold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTokens.s5),
                    Text(
                      money(bill.balance.abs()),
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        letterSpacing: -1,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: AppTokens.s1),
                    Text(
                      bill.isCredit
                          ? l.invoiceCarryForward
                          : l.invoiceAmountDue,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white.withValues(alpha: 0.88)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: l.tenantHomeTitle,
                child: Column(
                  children: [
                    _row(l.tenantBuildingTotal,
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
              BrandButton(
                label: l.tenantSelfEntry,
                icon: Icons.edit_outlined,
                variant: BrandButtonVariant.secondary,
                expanded: true,
                onPressed: () =>
                    context.pushNamed(AppRoutes.tenantEntryName),
              ),
              const SizedBox(height: 12),
              BrandButton(
                label: l.invoiceTitle,
                icon: Icons.receipt_long_outlined,
                expanded: true,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TenantBillDetailScreen(
                      bill: bill,
                      month: month,
                    ),
                  ),
                ),
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
            Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
