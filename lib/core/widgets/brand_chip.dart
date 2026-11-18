import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

enum BrandChipTone { neutral, brand, success, warning, danger }

/// Compact status chip: tinted surface, 8px radius, 12/600 label.
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
    final cs = Theme.of(context).colorScheme;
    final color = switch (tone) {
      BrandChipTone.neutral => cs.onSurfaceVariant,
      BrandChipTone.brand => AppColors.seed,
      BrandChipTone.success => AppColors.credit,
      BrandChipTone.warning => AppColors.accentOrange,
      BrandChipTone.danger => AppColors.due,
    };
    return Container(
      height: AppTokens.chipHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.s2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTokens.radiusChip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
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
    );
  }
}
