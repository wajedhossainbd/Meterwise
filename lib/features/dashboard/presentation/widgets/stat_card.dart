import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';

/// A tappable figure card. Neutral surface with one quiet accent in the icon
/// tile — the number is the content, not the decoration.
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
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(AppTokens.radiusCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTokens.radiusCard),
        child: Container(
          padding: const EdgeInsets.all(AppTokens.s4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTokens.radiusCard),
            border: Border.all(
              color: cs.outlineVariant.withValues(alpha: 0.5),
              width: AppTokens.hairline,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: AppTokens.iconButtonSize,
                    height: AppTokens.iconButtonSize,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius:
                          BorderRadius.circular(AppTokens.radiusControl),
                    ),
                    child: Icon(icon, size: AppTokens.iconMedium, color: color),
                  ),
                  const Spacer(),
                  if (onTap != null)
                    Icon(Icons.chevron_right,
                        size: AppTokens.iconSmall,
                        color: cs.onSurfaceVariant.withValues(alpha: 0.6)),
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
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: AppTokens.s1),
              Text(
                label,
                style: TextStyle(
                  fontSize: AppTokens.textCaption,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
