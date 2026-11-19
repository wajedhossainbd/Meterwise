import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/soft_ui.dart';

/// A tappable figure on a soft raised surface. The recessed icon tile holds the
/// only accent; the number is the content, not the decoration.
class StatCard extends StatelessWidget {
  const StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SoftSurface(
      depth: SoftDepth.subtle,
      onTap: onTap,
      padding: const EdgeInsets.all(AppTokens.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SoftInset(
                radius: AppTokens.radiusControl,
                padding: const EdgeInsets.all(AppTokens.s2),
                child: SizedBox(
                  width: AppTokens.iconButtonSize - AppTokens.s4,
                  height: AppTokens.iconButtonSize - AppTokens.s4,
                  child: Icon(icon, size: AppTokens.iconMedium, color: color),
                ),
              ),
              const Spacer(),
              if (onTap != null)
                Icon(Icons.chevron_right,
                    size: AppTokens.iconSmall,
                    color: Soft.muted(context).withValues(alpha: 0.7)),
            ],
          ),
          const SizedBox(height: AppTokens.s3),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: AppTokens.textHeading,
              fontWeight: AppTokens.weightSemibold,
              color: Soft.text(context),
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: AppTokens.s1),
          Text(
            label,
            style: TextStyle(
              fontSize: AppTokens.textCaption,
              color: Soft.muted(context),
            ),
          ),
        ],
      ),
    );
  }
}
