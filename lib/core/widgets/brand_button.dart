import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

enum BrandButtonVariant { primary, secondary, quiet, danger }

/// The four button roles used everywhere in MeterWise.
///
/// Sizing, radius and label type come from the theme tokens. A short scale-down
/// on press and a light haptic make the interaction feel physical, not flat.
class BrandButton extends StatefulWidget {
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
  State<BrandButton> createState() => _BrandButtonState();
}

class _BrandButtonState extends State<BrandButton> {
  bool _pressed = false;

  void _handleTap() {
    if (widget.onPressed == null || widget.loading) return;
    HapticFeedback.lightImpact();
    widget.onPressed!.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final enabled = widget.onPressed != null && !widget.loading;
    final child = widget.loading
        ? SizedBox(
            height: AppTokens.iconSmall,
            width: AppTokens.iconSmall,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: widget.variant == BrandButtonVariant.primary ||
                      widget.variant == BrandButtonVariant.danger
                  ? cs.onPrimary
                  : cs.primary,
            ),
          )
        : widget.icon == null
            ? Text(widget.label)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: AppTokens.iconSmall),
                  const SizedBox(width: AppTokens.s2),
                  Text(widget.label),
                ],
              );

    final Widget button;
    switch (widget.variant) {
      case BrandButtonVariant.primary:
        button = FilledButton(onPressed: enabled ? _handleTap : null, child: child);
      case BrandButtonVariant.secondary:
        button =
            OutlinedButton(onPressed: enabled ? _handleTap : null, child: child);
      case BrandButtonVariant.quiet:
        button = TextButton(onPressed: enabled ? _handleTap : null, child: child);
      case BrandButtonVariant.danger:
        button = FilledButton(
          onPressed: enabled ? _handleTap : null,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.due,
            foregroundColor: Colors.white,
          ),
          child: child,
        );
    }

    return AnimatedScale(
      scale: _pressed ? 0.97 : 1,
      duration: AppTokens.durationShort,
      curve: AppTokens.easing,
      child: Listener(
        onPointerDown: (_) => setState(() => _pressed = true),
        onPointerUp: (_) => setState(() => _pressed = false),
        onPointerCancel: (_) => setState(() => _pressed = false),
        child: widget.expanded
            ? SizedBox(width: double.infinity, child: button)
            : button,
      ),
    );
  }
}
