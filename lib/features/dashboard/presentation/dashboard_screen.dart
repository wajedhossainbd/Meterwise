import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/soft_ui.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/animated_count.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/meter_gauge.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/application/billing_providers.dart';
import '../../billing/data/billing_period_repository.dart';
import '../../billing/domain/models/billing_result.dart';
import '../../billing/presentation/period_status_chip.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../readings/application/reading_sessions.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import 'widgets/mini_bar_chart.dart';
import 'widgets/stat_card.dart';

part 'widgets/balance_hero.dart';
part 'widgets/owner_summary_card.dart';
part 'widgets/quick_actions.dart';
part 'widgets/recent_activity.dart';
part 'widgets/setup_checklist.dart';
part 'widgets/stat_grid.dart';
part 'widgets/tenant_bill_row.dart';
part 'widgets/trend_card.dart';

/// Home dashboard: available balance, quick actions, monthly figures, a trend
/// chart and recent activity.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ready = ref.watch(isSetupCompleteProvider);
    final month = ref.watch(billingMonthProvider);
    final property = ref.watch(currentPropertyProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(property?.name ?? AppConstants.appName),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(22),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                Formatters.monthYear(month),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.88),
                    ),
              ),
            ),
          ),
        ),
      ),
      body: !ready
          ? _SetupChecklist(
              hasProperty: property != null,
              hasMeter: ref.watch(currentMainMeterProvider).value != null,
              tenantCount: ref.watch(tenantListProvider).value?.length ?? 0,
            )
          : const _DashboardBody(),
    );
  }
}

class _DashboardBody extends ConsumerWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewAsync = ref.watch(periodViewProvider);
    final currency = ref.watch(currencyCodeProvider);
    final multiTenant = ref.watch(isMultiTenantProvider);

    return AsyncValueView(
      value: viewAsync,
      onRetry: () {
        ref.invalidate(periodViewProvider);
        ref.invalidate(monthlyHistoryProvider);
      },
      data: (view) {
        final monthly = view.bill;
        String money(num v) => Formatters.money(v, currencyCode: currency);
        final l = AppLocalizations.of(context);

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(periodViewProvider);
            ref.invalidate(monthlyHistoryProvider);
            await ref.read(periodViewProvider.future);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              FadeSlideIn(
                index: 0,
                child: _BalanceHero(
                  remaining: view.carryForward,
                  monthRecharge: monthly?.totalRecharge ?? 0,
                  currency: currency,
                  status: view.status,
                  usageFraction: monthly != null && monthly.mainMeterUnits > 0
                      ? monthly.totalTenantUnits / monthly.mainMeterUnits
                      : 0,
                ),
              ),
              const SizedBox(height: 16),
              const FadeSlideIn(index: 1, child: _QuickActions()),
              const SizedBox(height: 16),
              FadeSlideIn(
                index: 2,
                child: _StatGrid(
                    monthly: monthly,
                    currency: currency,
                    multiTenant: multiTenant),
              ),
              if (monthly != null && multiTenant) ...[
                const SizedBox(height: 16),
                FadeSlideIn(
                  index: 3,
                  child: _OwnerSummaryCard(bill: monthly, currency: currency),
                ),
              ],
              const SizedBox(height: 16),
              const FadeSlideIn(index: 3, child: _TrendCard()),
              const SizedBox(height: 16),
              const FadeSlideIn(index: 4, child: _RecentActivity()),
              if (monthly != null) ...[
                const SizedBox(height: 16),
                FadeSlideIn(
                  index: 5,
                  child: Text(l.dashTenantBills,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
                const SizedBox(height: 8),
                for (final (i, t) in monthly.tenantBills.indexed)
                  FadeSlideIn(
                    index: 5 + i,
                    child: _TenantBillRow(
                      bill: t,
                      color: AppColors
                          .chartPalette[i % AppColors.chartPalette.length],
                      usageFraction: monthly.mainMeterUnits > 0
                          ? t.billedUnits / monthly.mainMeterUnits
                          : 0,
                      money: money,
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}
