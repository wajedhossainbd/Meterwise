import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../data/billing_period_repository.dart';

/// A small pill showing whether a billing period is Draft (🟡) or Finalized (🟢).
class PeriodStatusChip extends StatelessWidget {
  const PeriodStatusChip({required this.status, super.key});

  final PeriodStatus status;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final finalized = status == PeriodStatus.finalized;
    final color = finalized ? AppColors.credit : AppColors.powerYellow;
    final label = finalized ? l.statusFinalized : l.statusDraft;
    final icon = finalized ? Icons.lock : Icons.edit_note;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
