// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

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
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
