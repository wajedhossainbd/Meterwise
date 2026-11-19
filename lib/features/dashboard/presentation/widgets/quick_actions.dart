// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// Three primary actions as one quiet set: soft raised surfaces with a recessed
/// icon tile and a single accent. No confetti colours, no outlines.
class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(
      children: [
        _ActionButton(
          icon: Icons.add_chart_outlined,
          color: AppColors.cyan,
          label: l.dashAddReading,
          onTap: () => context.pushNamed(AppRoutes.addReadingName),
        ),
        const SizedBox(width: AppTokens.s3),
        _ActionButton(
          icon: Icons.bolt_outlined,
          color: AppColors.powerYellow,
          label: l.dashAddRecharge,
          onTap: () => context.pushNamed(AppRoutes.addRechargeName),
        ),
        const SizedBox(width: AppTokens.s3),
        _ActionButton(
          icon: Icons.receipt_long_outlined,
          color: AppColors.teal,
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
    required this.color,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SoftSurface(
        depth: SoftDepth.subtle,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(
          vertical: AppTokens.s4,
          horizontal: AppTokens.s2,
        ),
        child: Column(
          children: [
            SoftSurface(
              color: color,
              depth: SoftDepth.subtle,
              borderRadius: BorderRadius.circular(AppTokens.radiusControl),
              child: SizedBox(
                width: AppTokens.iconButtonSize - AppTokens.s4,
                height: AppTokens.iconButtonSize - AppTokens.s4,
                child: Icon(icon, size: AppTokens.iconMedium, color: Colors.white),
              ),
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
                color: Soft.text(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
