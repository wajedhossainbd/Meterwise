// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

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
