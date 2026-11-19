// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// The peak moment of the dashboard: a warm gradient hero carrying the prepaid
/// balance and the recessed meter dial. Everything on it is white for contrast;
/// the surrounding cards stay clean white.
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
    final finalized = status == PeriodStatus.finalized;

    return Container(
      padding: const EdgeInsets.all(AppTokens.s6),
      decoration: BoxDecoration(
        gradient: SoftGradient.hero,
        borderRadius: BorderRadius.circular(AppTokens.radiusSurface),
        boxShadow: Soft.raised(context, depth: SoftDepth.strong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined,
                  color: Colors.white, size: AppTokens.iconMedium),
              const SizedBox(width: AppTokens.s2),
              Text(
                l.dashAvailableBalance,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: AppTokens.textTitle,
                  fontWeight: AppTokens.weightMedium,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTokens.s2,
                  vertical: AppTokens.s1,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(AppTokens.radiusChip),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      finalized ? Icons.lock_outlined : Icons.edit_note_outlined,
                      size: 13,
                      color: Colors.white,
                    ),
                    const SizedBox(width: AppTokens.s1),
                    Text(
                      finalized ? l.statusFinalized : l.statusDraft,
                      style: const TextStyle(
                        fontSize: AppTokens.textCaption,
                        fontWeight: AppTokens.weightSemibold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppTokens.textDisplay,
                    fontWeight: AppTokens.weightSemibold,
                    letterSpacing: -1,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              MeterGauge(fraction: usageFraction, onColor: true),
            ],
          ),
          const SizedBox(height: AppTokens.s5),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTokens.s3,
              vertical: AppTokens.s2,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppTokens.radiusChip),
            ),
            child: Text(
              l.dashRechargedThisMonth(
                  Formatters.money(monthRecharge, currencyCode: currency)),
              style: const TextStyle(
                color: Colors.white,
                fontSize: AppTokens.textBody,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
