import 'package:flutter/material.dart';

import '../../../core/widgets/brand_chip.dart';
import '../../../l10n/app_localizations.dart';
import '../data/billing_period_repository.dart';

/// Period status: Draft (editable) or Finalized (locked).
class PeriodStatusChip extends StatelessWidget {
  const PeriodStatusChip({required this.status, super.key});

  final PeriodStatus status;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final finalized = status == PeriodStatus.finalized;
    return BrandChip(
      label: finalized ? l.statusFinalized : l.statusDraft,
      tone: finalized ? BrandChipTone.success : BrandChipTone.warning,
      icon: finalized ? Icons.lock_outlined : Icons.edit_note_outlined,
    );
  }
}
