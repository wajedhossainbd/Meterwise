import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

enum BrandButtonVariant { primary, secondary, quiet, danger }

/// The four button roles used everywhere in MeterWise.
///
/// Sizing, radius and label type come from the theme tokens, so a button looks
/// identical on every screen. Use [loading] instead of ad-hoc spinners.
class BrandButton extends StatelessWidget {
  const BrandButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.variant = BrandButtonVariant.primary,
    this.loading = false,
    this.expanded = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final BrandButtonVariant variant;
  final bool loading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final enabled = onPressed != null && !loading;
    final child = loading
        ? SizedBox(
            height: AppTokens.iconSmall,
            width: AppTokens.iconSmall,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == BrandButtonVariant.primary ||
                      variant == BrandButtonVariant.danger
                  ? cs.onPrimary
                  : cs.primary,
            ),
          )
        : icon == null
            ? Text(label)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: AppTokens.iconSmall),
                  const SizedBox(width: AppTokens.s2),
                  Text(label),
                ],
              );

    final Widget button;
    switch (variant) {
      case BrandButtonVariant.primary:
        button = FilledButton(
          onPressed: enabled ? onPressed : null,
          child: child,
        );
      case BrandButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: enabled ? onPressed : null,
          child: child,
        );
      case BrandButtonVariant.quiet:
        button = TextButton(
          onPressed: enabled ? onPressed : null,
          child: child,
        );
      case BrandButtonVariant.danger:
        button = FilledButton(
          onPressed: enabled ? onPressed : null,
          style: FilledButton.styleFrom(backgroundColor: AppColors.due),
          child: child,
        );
    }
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
