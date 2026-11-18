// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// The one rich moment on the dashboard: the prepaid balance and the meter dial
/// that explains where this month's units went.
class _BalanceHero extends StatelessWidget {
  const _BalanceHero({
    required this.remaining,
    required this.monthRecharge,
    required this.currency,
    required this.status,
    required this.usageFraction,
  });

  final double remaining;
  final double monthRecharge;
  final String currency;
  final PeriodStatus status;
  final double usageFraction;

  @override
  Widget build(BuildContext context) {
    const onPrimary = Colors.white;
    final l = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(AppTokens.s6),
      decoration: BoxDecoration(
        color: AppColors.seed,
        borderRadius: BorderRadius.circular(AppTokens.radiusSurface),
        border: Border.all(color: onPrimary.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,
                  color: onPrimary.withValues(alpha: 0.88),
                  size: AppTokens.iconMedium),
              const SizedBox(width: AppTokens.s2),
              Text(l.dashAvailableBalance,
                  style: const TextStyle(
                      color: onPrimary,
                      fontSize: AppTokens.textTitle,
                      fontWeight: AppTokens.weightMedium)),
              const Spacer(),
              PeriodStatusChip(status: status),
            ],
          ),
          const SizedBox(height: AppTokens.s4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedCount(
                  value: remaining,
                  formatter: (v) =>
                      Formatters.money(v, currencyCode: currency),
                  style: const TextStyle(
                    color: onPrimary,
                    fontSize: AppTokens.textDisplay,
                    fontWeight: AppTokens.weightSemibold,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              MeterGauge(fraction: usageFraction),
            ],
          ),
          const SizedBox(height: AppTokens.s4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s3,
              vertical: AppTokens.s2,
            ),
            decoration: BoxDecoration(
              color: onPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppTokens.radiusChip),
            ),
            child: Text(
              l.dashRechargedThisMonth(
                  Formatters.money(monthRecharge, currencyCode: currency)),
              style: const TextStyle(
                color: onPrimary,
                fontSize: AppTokens.textBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
