// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

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
