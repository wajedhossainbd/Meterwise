// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// The one rich moment on the dashboard: the prepaid balance.
///
/// Solid brand blue with a hairline highlight — no hue gradient, no glows.
/// Everything else on the screen stays quiet so this number reads first.
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
    const onPrimary = Colors.white;
    final l = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.seed,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: onPrimary.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,
                  color: onPrimary.withValues(alpha: 0.88), size: 20),
              const SizedBox(width: 8),
              Text(l.dashAvailableBalance,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: onPrimary, fontWeight: FontWeight.w500)),
              const Spacer(),
              PeriodStatusChip(status: status),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedCount(
            value: remaining,
            formatter: (v) => Formatters.money(v, currencyCode: currency),
            style: theme.textTheme.headlineLarge
                ?.copyWith(color: onPrimary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: onPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              l.dashRechargedThisMonth(
                  Formatters.money(monthRecharge, currencyCode: currency)),
              style: theme.textTheme.bodyMedium?.copyWith(color: onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
