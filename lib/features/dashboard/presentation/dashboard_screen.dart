import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/animated_count.dart';
import '../../../core/widgets/async_value_view.dart';
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
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
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

/// Owner-facing monthly summary. Its content adapts to the calculation mode:
/// Shared-Slab shows the Owner Benefit/Loss; the reconciled modes show that
/// tenant collections exactly match the meter bill. NEVER shown on invoices.
class _OwnerSummaryCard extends StatelessWidget {
  const _OwnerSummaryCard({required this.bill, required this.currency});

  final MonthlyBill bill;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    String money(num v) => Formatters.money(v, currencyCode: currency);
    final isSharedSlab = bill.calcMode == 'sharedSlab';
    final benefit = bill.ownerBenefit;
    final isLoss = benefit < 0;

    Widget row(String label, String value, {Color? color, bool bold = false}) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              Text(value,
                  style: (bold
                          ? theme.textTheme.titleMedium
                          : theme.textTheme.bodyMedium)
                      ?.copyWith(
                          fontWeight: FontWeight.w700, color: color)),
            ],
          ),
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_outlined,
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(l.ownerSummaryTitle,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            row(l.ownerMainBill, money(bill.buildingBill)),
            if (bill.calcMode == 'fixedRate') ...[
              row(l.ownerCollectedFixed, money(bill.fixedCollections)),
              row(l.ownerRemainingShared, money(bill.sharedCollections)),
            ],
            row(l.ownerTenantTotal, money(bill.totalBilled)),
            const Divider(height: 18),
            if (isSharedSlab)
              row(
                isLoss ? l.ownerLoss : l.ownerBenefit,
                money(benefit.abs()),
                color: isLoss ? AppColors.due : AppColors.credit,
                bold: true,
              )
            else
              row(l.ownerDifference, money(0), bold: true),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _miniStat(theme, l.ownerCollectionPct,
                    '${bill.collectionPercent.toStringAsFixed(0)}%'),
                _miniStat(theme, l.ownerAvgCost, money(bill.averageUnitCost)),
                _miniStat(
                    theme, l.ownerAvgSell, money(bill.averageSellingRate)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(ThemeData theme, String label, String value) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: theme.textTheme.labelSmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            Text(value,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      );
}

/// A colorful tenant row: palette avatar, usage-share bar, bill + balance.
class _TenantBillRow extends StatelessWidget {
  const _TenantBillRow({
    required this.bill,
    required this.color,
    required this.usageFraction,
    required this.money,
  });

  final TenantBill bill;
  final Color color;
  final double usageFraction;
  final String Function(num) money;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final initial = bill.tenantName.trim().isEmpty
        ? '?'
        : bill.tenantName.trim()[0].toUpperCase();

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.18),
                  foregroundColor: color,
                  child: Text(initial,
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bill.tenantName,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      Text(
                        '${Formatters.units(bill.billedUnits)} kWh • '
                        '${l.effectiveRateLabel} '
                        '${l.effectiveRateValue(money(bill.effectiveRate))}'
                        '${bill.billingMode == 'fixed' ? ' • ${l.tenantModeFixed}' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(money(bill.totalBill),
                        style: const TextStyle(fontWeight: FontWeight.w800)),
                    Text(
                      '${bill.isCredit ? l.dashInCredit : l.dashDue}'
                      ' ${money(bill.balance.abs())}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                            bill.isCredit ? AppColors.credit : AppColors.due,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Usage share of the whole meter, animated.
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: usageFraction.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, v, _) => LinearProgressIndicator(
                  value: v,
                  minHeight: 7,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceHero extends StatelessWidget {
  const _BalanceHero({
    required this.remaining,
    required this.monthRecharge,
    required this.currency,
    required this.status,
  });

  /// Remaining prepaid balance = total recharge − total bill used.
  final double remaining;
  final double monthRecharge;
  final String currency;
  final PeriodStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l = AppLocalizations.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.seed, AppColors.violet],
          ),
        ),
        child: Stack(
          children: [
            // Decorative glow circles for a modern "wallet" feel.
            Positioned(
              top: -38,
              right: -28,
              child: _glowCircle(110, Colors.white.withValues(alpha: 0.10)),
            ),
            Positioned(
              bottom: -46,
              left: -20,
              child: _glowCircle(130, AppColors.cyan.withValues(alpha: 0.18)),
            ),
            Positioned(
              top: 30,
              right: 60,
              child: _glowCircle(34, Colors.white.withValues(alpha: 0.12)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet,
                          color: cs.onPrimary.withValues(alpha: 0.9),
                          size: 20),
                      const SizedBox(width: 8),
                      Text(l.dashAvailableBalance,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(color: cs.onPrimary)),
                      const Spacer(),
                      PeriodStatusChip(status: status),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AnimatedCount(
                    value: remaining,
                    formatter: (v) =>
                        Formatters.money(v, currencyCode: currency),
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      l.dashRechargedThisMonth(Formatters.money(monthRecharge,
                          currencyCode: currency)),
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: cs.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glowCircle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(
      children: [
        _ActionButton(
          icon: Icons.add_chart,
          label: l.dashAddReading,
          color: AppColors.seed,
          onTap: () => context.pushNamed(AppRoutes.addReadingName),
        ),
        const SizedBox(width: 12),
        _ActionButton(
          icon: Icons.bolt,
          label: l.dashAddRecharge,
          color: AppColors.accentOrange,
          onTap: () => context.pushNamed(AppRoutes.addRechargeName),
        ),
        const SizedBox(width: 12),
        _ActionButton(
          icon: Icons.receipt_long,
          label: l.dashViewBills,
          color: AppColors.teal,
          onTap: () => context.go(AppRoutes.bills),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return Expanded(
      child: Material(
        color: color.withValues(alpha: isLight ? 0.10 : 0.22),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 22),
                ),
                const SizedBox(height: 8),
                Text(label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatGrid extends ConsumerWidget {
  const _StatGrid({
    required this.monthly,
    required this.currency,
    required this.multiTenant,
  });

  final MonthlyBill? monthly;
  final String currency;
  final bool multiTenant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String money(num v) => Formatters.money(v, currencyCode: currency);
    final l = AppLocalizations.of(context);
    final tenantCount = ref.watch(tenantListProvider).value?.length ?? 0;
    final m = monthly;

    final cards = <Widget>[
      StatCard(
        label: l.dashMainUnits,
        value: m == null ? '—' : '${Formatters.units(m.mainMeterUnits)} kWh',
        icon: Icons.electric_meter,
        color: AppColors.cyan,
        onTap: () => context.go(AppRoutes.readings),
      ),
      StatCard(
        label: l.dashRecharge,
        value: m == null ? '—' : money(m.totalRecharge),
        icon: Icons.bolt,
        color: AppColors.accentOrange,
        onTap: () => context.go(AppRoutes.recharge),
      ),
      StatCard(
        label: l.dashEstimatedBill,
        value: m == null ? '—' : money(m.totalBilled),
        icon: Icons.request_quote,
        color: AppColors.violet,
        onTap: () => context.go(AppRoutes.bills),
      ),
      StatCard(
        label: l.dashOutstanding,
        value: m == null ? money(0) : money(m.totalOutstanding),
        icon: Icons.error_outline,
        color: m != null && m.totalOutstanding > 0
            ? AppColors.due
            : AppColors.credit,
        onTap: () => context.go(AppRoutes.bills),
      ),
      StatCard(
        label: l.dashCommonArea,
        value:
            m == null ? '—' : '${Formatters.units(m.commonAreaUnits)} kWh',
        icon: Icons.lightbulb_outline,
        color: AppColors.powerYellow,
      ),
      if (multiTenant)
        StatCard(
          label: l.dashTenants,
          value: '$tenantCount',
          icon: Icons.people_outline,
          color: AppColors.teal,
          onTap: () => context.pushNamed(AppRoutes.tenantsName),
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth > 420
            ? (constraints.maxWidth - 12) / 2
            : constraints.maxWidth;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [for (final c in cards) SizedBox(width: width, child: c)],
        );
      },
    );
  }
}

class _TrendCard extends ConsumerStatefulWidget {
  const _TrendCard();

  @override
  ConsumerState<_TrendCard> createState() => _TrendCardState();
}

enum _Series { usage, recharge, bill, rate }

class _TrendCardState extends ConsumerState<_TrendCard> {
  _Series _series = _Series.usage;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(monthlyHistoryProvider());
    final currency = ref.watch(currencyCodeProvider);
    final l = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.dashMonthlyOverview,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            // Horizontally scrollable so labels never wrap on narrow screens
            // (especially with the longer Bengali labels).
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<_Series>(
                style: SegmentedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w600),
                  visualDensity: VisualDensity.compact,
                ),
                segments: [
                  ButtonSegment(
                      value: _Series.usage, label: Text(l.dashUsage)),
                  ButtonSegment(
                      value: _Series.recharge, label: Text(l.dashRecharge)),
                  ButtonSegment(value: _Series.bill, label: Text(l.dashBill)),
                  ButtonSegment(
                      value: _Series.rate, label: Text(l.effectiveRateLabel)),
                ],
                selected: {_series},
                showSelectedIcon: false,
                onSelectionChanged: (s) => setState(() => _series = s.first),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: history.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('$e')),
                data: (months) {
                  if (months.every((m) => _value(m) == 0)) {
                    return Center(
                      child: Text(l.dashNoData,
                          style: Theme.of(context).textTheme.bodyMedium),
                    );
                  }
                  return MiniBarChart(
                    values: [for (final m in months) _value(m)],
                    labels: [
                      for (final m in months) Formatters.monthShort(m.month)
                    ],
                    color: _color,
                    tooltipFormatter: (v) => _series == _Series.usage
                        ? '${Formatters.units(v)} kWh'
                        : Formatters.money(v, currencyCode: currency),
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _series == _Series.usage
                  ? 'Units (kWh) per month'
                  : 'Amount (${Formatters.currencySymbol(currency).trim()}) per month',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  double _value(MonthlySummary m) => switch (_series) {
        _Series.usage => m.units,
        _Series.recharge => m.recharge,
        _Series.bill => m.billed,
        _Series.rate => m.units > 0 ? m.billed / m.units : 0,
      };

  Color get _color => switch (_series) {
        _Series.usage => AppColors.lightBlue,
        _Series.recharge => AppColors.powerYellow,
        _Series.bill => AppColors.seed,
        _Series.rate => AppColors.accentOrange,
      };
}

class _RecentActivity extends ConsumerWidget {
  const _RecentActivity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(readingSessionsProvider);
    final recharges = ref.watch(rechargeListProvider).value ?? const [];
    final currency = ref.watch(currencyCodeProvider);

    final lastReading = sessions.isEmpty ? null : sessions.first;
    final lastRecharge = recharges.isEmpty ? null : recharges.first;
    final l = AppLocalizations.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.dashRecentActivity,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.speed_outlined),
              title: Text(l.dashLastReading),
              subtitle: Text(
                lastReading == null
                    ? l.dashNone
                    : '${Formatters.date(lastReading.date)} • '
                        '${lastReading.mainReading == null ? '' : '${Formatters.units(lastReading.mainReading!)} kWh'}',
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.bolt_outlined),
              title: Text(l.dashLastRecharge),
              subtitle: Text(
                lastRecharge == null
                    ? l.dashNone
                    : '${Formatters.date(lastRecharge.rechargeDate)} • '
                        '${Formatters.money(lastRecharge.amount, currencyCode: currency)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetupChecklist extends StatelessWidget {
  const _SetupChecklist({
    required this.hasProperty,
    required this.hasMeter,
    required this.tenantCount,
  });

  final bool hasProperty;
  final bool hasMeter;
  final int tenantCount;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(l.welcomeTitle(AppConstants.appName),
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(l.setupSubtitle,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        _step(context, l.stepProperty, hasProperty,
            '${AppRoutes.settings}/${AppRoutes.property}'),
        _step(context, l.stepMeter, hasMeter,
            '${AppRoutes.settings}/${AppRoutes.mainMeter}'),
        _step(context, l.stepTenants, tenantCount > 0,
            '${AppRoutes.settings}/${AppRoutes.tenants}'),
      ],
    );
  }

  Widget _step(BuildContext context, String title, bool done, String path) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          done ? Icons.check_circle : Icons.radio_button_unchecked,
          color: done ? AppColors.credit : null,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go(path),
      ),
    );
  }
}
