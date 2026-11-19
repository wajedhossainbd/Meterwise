import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import '../theme/soft_ui.dart';

enum BrandChipTone { neutral, brand, success, warning, danger }

/// Compact status chip: a recessed soft pill with a 12/600 label.
/// Colour carries meaning only — never decoration.
class BrandChip extends StatelessWidget {
  const BrandChip({
    required this.label,
    super.key,
    this.tone = BrandChipTone.neutral,
    this.icon,
  });

  final String label;
  final BrandChipTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      BrandChipTone.neutral => Soft.muted(context),
      BrandChipTone.brand => Soft.accent(context),
      BrandChipTone.success => Soft.success(context),
      BrandChipTone.warning => AppColors.accentOrange,
      BrandChipTone.danger => Soft.danger(context),
    };
    return SoftSurface(
      inset: true,
      depth: SoftDepth.subtle,
      borderRadius: BorderRadius.circular(AppTokens.radiusChip),
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.s2),
      child: SizedBox(
        height: AppTokens.chipHeight - AppTokens.s1,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13, color: color),
              const SizedBox(width: AppTokens.s1),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: AppTokens.textCaption,
                fontWeight: AppTokens.weightSemibold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
