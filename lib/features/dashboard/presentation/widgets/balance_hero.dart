// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// The peak moment of the dashboard: the prepaid balance, with the recessed
/// meter dial explaining where this month's units went. A soft raised surface,
/// a single accent, no coloured billboard.
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
    final l = AppLocalizations.of(context);
    final accent = Soft.accent(context);

    return SoftCard(
      depth: SoftDepth.strong,
      padding: const EdgeInsets.all(AppTokens.s6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,
                  color: accent, size: AppTokens.iconMedium),
              const SizedBox(width: AppTokens.s2),
              Text(
                l.dashAvailableBalance,
                style: TextStyle(
                  color: Soft.muted(context),
                  fontSize: AppTokens.textTitle,
                  fontWeight: AppTokens.weightMedium,
                ),
              ),
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
                  formatter: (v) => Formatters.money(v, currencyCode: currency),
                  style: TextStyle(
                    color: Soft.text(context),
                    fontSize: AppTokens.textDisplay,
                    fontWeight: AppTokens.weightSemibold,
                    letterSpacing: -1,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              MeterGauge(fraction: usageFraction),
            ],
          ),
          const SizedBox(height: AppTokens.s5),
          SoftInset(
            radius: AppTokens.radiusChip,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s3,
              vertical: AppTokens.s2,
            ),
            child: Text(
              l.dashRechargedThisMonth(
                  Formatters.money(monthRecharge, currencyCode: currency)),
              style: TextStyle(
                color: Soft.muted(context),
                fontSize: AppTokens.textBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
