// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// Three primary actions, styled as one quiet set: neutral surfaces, hairline
/// outline, a single brand accent in the icon tile. No confetti colours.
class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(
      children: [
        _ActionButton(
          icon: Icons.add_chart_outlined,
          label: l.dashAddReading,
          onTap: () => context.pushNamed(AppRoutes.addReadingName),
        ),
        const SizedBox(width: AppTokens.s3),
        _ActionButton(
          icon: Icons.bolt_outlined,
          label: l.dashAddRecharge,
          onTap: () => context.pushNamed(AppRoutes.addRechargeName),
        ),
        const SizedBox(width: AppTokens.s3),
        _ActionButton(
          icon: Icons.receipt_long_outlined,
          label: l.dashViewBills,
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
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Material(
        color: cs.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusCard),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppTokens.s4,
              horizontal: AppTokens.s2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.radiusCard),
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: 0.5),
                width: AppTokens.hairline,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: AppTokens.iconButtonSize,
                  height: AppTokens.iconButtonSize,
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(AppTokens.radiusControl),
                  ),
                  child: Icon(icon, size: AppTokens.iconMedium, color: cs.primary),
                ),
                const SizedBox(height: AppTokens.s3),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppTokens.textCaption,
                    fontWeight: AppTokens.weightSemibold,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
