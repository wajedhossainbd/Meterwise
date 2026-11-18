import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/feature_placeholder.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/billing_period_repository.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../application/reading_sessions.dart';
import '../data/reading_repository.dart';

/// Lists recorded reading sessions, newest first.
class ReadingsScreen extends ConsumerWidget {
  const ReadingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(readingSessionsProvider);
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final tenantNames = {for (final t in tenants) t.id: t.name};
    final ready = ref.watch(isSetupCompleteProvider);
    final finalizedMonths =
        ref.watch(finalizedMonthsProvider).value ?? const <String>{};
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.readingsTitle)),
      floatingActionButton: ready
          ? FloatingActionButton.extended(
              onPressed: () async {
                final saved =
                    await context.pushNamed<bool>(AppRoutes.addReadingName);
                if (saved == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l.readingSaved)),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: Text(l.readingAdd),
            )
          : null,
      body: !ready
          ? FeaturePlaceholder(
              icon: Icons.warning_amber_outlined,
              title: l.finishSetupTitle,
              message: l.finishSetupMsg,
            )
          : sessions.isEmpty
              ? FeaturePlaceholder(
                  icon: Icons.speed_outlined,
                  title: l.readingsEmptyTitle,
                  message: l.readingsEmptyMsg,
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96, top: 8),
                  itemCount: sessions.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 4),
                  itemBuilder: (context, i) => _SessionTile(
                    sessions[i],
                    tenantNames,
                    ref,
                    locked: finalizedMonths
                        .contains(Formatters.monthKey(sessions[i].date)),
                  ),
                ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile(this.session, this.tenantNames, this.ref,
      {required this.locked});

  final ReadingSession session;
  final Map<int, String> tenantNames;
  final WidgetRef ref;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final tenantLines = [
      for (final entry in session.tenantReadings.entries)
        '${tenantNames[entry.key] ?? 'Tenant'}: ${Formatters.units(entry.value)}',
    ];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.speed,
                      size: 18, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 10),
                Text(Formatters.date(session.date),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const Spacer(),
                if (locked)
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.lock_outline,
                        color: theme.colorScheme.onSurfaceVariant),
                    tooltip: l.periodFinalizedChip,
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l.periodLockedMessage)),
                    ),
                  )
                else
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _confirmDelete(context),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            if (session.mainReading != null)
              Text('${l.readingMainMeter}: ${Formatters.units(session.mainReading!)}',
                  style: theme.textTheme.bodyLarge),
            if (tenantLines.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(tenantLines.join('   •   '),
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant)),
              ),
            if (session.notes != null && session.notes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(session.notes!,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(fontStyle: FontStyle.italic)),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.readingDeleteTitle),
        content: Text(l.readingDeleteMsg(Formatters.date(session.date))),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.actionCancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.actionDelete)),
        ],
      ),
    );
    if (confirmed ?? false) {
      final meter = ref.read(currentMainMeterProvider).value;
      try {
        await ref.read(readingRepositoryProvider).deleteSession(session.date);
      } on FinalizedPeriodException {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l.periodLockedMessage)),
          );
        }
        return;
      }
      if (!context.mounted || meter == null) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l.readingDeleted),
            action: SnackBarAction(
              label: l.actionUndo,
              onPressed: () {
                ref.read(readingRepositoryProvider).addSession(
                      mainMeterId: meter.id,
                      date: session.date,
                      mainReading: session.mainReading ?? 0,
                      tenantReadings: session.tenantReadings,
                      notes: session.notes,
                    );
              },
            ),
          ),
        );
    }
  }
}
