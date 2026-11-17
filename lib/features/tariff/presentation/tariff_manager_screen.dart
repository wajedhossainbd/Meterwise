import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/domain/models/tariff.dart';
import '../data/tariff_version_repository.dart';
import '../domain/tariff_presets.dart';
import 'tariff_version_edit_screen.dart';

/// Full tariff manager: presets + versioned tariffs with create / edit / clone
/// / archive / delete / preview.
class TariffManagerScreen extends ConsumerWidget {
  const TariffManagerScreen({super.key});

  Future<void> _openEditor(
    BuildContext context, {
    int? versionId,
    Tariff? source,
    String? label,
    DateTime? effectiveFrom,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => TariffVersionEditScreen(
          versionId: versionId,
          source: source,
          initialLabel: label,
          initialEffectiveFrom: effectiveFrom,
        ),
      ),
    );
  }

  Future<void> _addVersion(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(tariffVersionRepositoryProvider);
    final latest = await repo.latestTariff();
    final label = await repo.nextLabel();
    if (!context.mounted) return;
    await _openEditor(context,
        source: latest, label: label, effectiveFrom: DateTime.now());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versions = ref.watch(tariffVersionsProvider);
    final repo = ref.read(tariffVersionRepositoryProvider);
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.tariffTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addVersion(context, ref),
        icon: const Icon(Icons.add),
        label: Text(l.tariffAddVersion),
      ),
      body: AsyncValueView(
        value: versions,
        onRetry: () => ref.invalidate(tariffVersionsProvider),
        data: (list) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            Text(l.tariffPresets,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final preset in kTariffPresets)
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.bookmark_outline),
                  title: Text(preset.name),
                  subtitle: Text(preset.description),
                  trailing: TextButton(
                    onPressed: () => _openEditor(
                      context,
                      source: preset.tariff,
                      label: preset.name,
                      effectiveFrom: DateTime.now(),
                    ),
                    child: Text(l.actionUse),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text(l.tariffVersions,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l.tariffNoVersions),
              ),
            for (final v in list)
              _VersionTile(version: v, repo: repo, onEditor: _openEditor),
          ],
        ),
      ),
    );
  }
}

class _VersionTile extends StatelessWidget {
  const _VersionTile({
    required this.version,
    required this.repo,
    required this.onEditor,
  });

  final TariffVersion version;
  final TariffVersionRepository repo;
  final Future<void> Function(
    BuildContext context, {
    int? versionId,
    Tariff? source,
    String? label,
    DateTime? effectiveFrom,
  }) onEditor;

  void _snack(BuildContext context, String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  Future<void> _handle(BuildContext context, String action) async {
    final l = AppLocalizations.of(context);
    final tariff = repo.decode(version.tariffJson);
    switch (action) {
      case 'edit':
        await onEditor(context,
            versionId: version.id,
            source: tariff,
            label: version.label,
            effectiveFrom: version.effectiveFrom);
      case 'clone':
        await onEditor(context,
            source: tariff,
            label: '${version.label} (copy)',
            effectiveFrom: DateTime.now());
      case 'archive':
        await repo.setArchived(version.id, archived: !version.archived);
      case 'delete':
        final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.tariffDeleteTitle),
            content: Text(l.tariffDeleteMsg(version.label)),
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
        if (ok ?? false) {
          try {
            await repo.deleteVersion(version.id);
          } on TariffException catch (e) {
            if (context.mounted) _snack(context, e.message);
          }
        }
      case 'preview':
        await _preview(context, tariff);
    }
  }

  Future<void> _preview(BuildContext context, Tariff t) {
    final l = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(version.label,
                style: Theme.of(ctx).textTheme.titleLarge),
            Text(l.tariffEffective(Formatters.date(version.effectiveFrom)),
                style: Theme.of(ctx).textTheme.bodySmall),
            const SizedBox(height: 12),
            if (t.lifelineUpTo != null && t.lifelineRate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  '${l.tariffLifeline}: ≤${t.lifelineUpTo}  →  '
                  '${Formatters.units(t.lifelineRate!)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            for (final s in t.slabs)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(s.toUnit == null
                    ? '${s.fromUnit}+  →  ${Formatters.units(s.rate)}'
                    : '${s.fromUnit}–${s.toUnit}  →  ${Formatters.units(s.rate)}'),
              ),
            const Divider(),
            Text('${l.tariffDemandCharge}: ${Formatters.units(t.demandCharge)}'),
            Text('${l.tariffMeterRent}: ${Formatters.units(t.meterRent)}'),
            Text('${l.tariffVat}: ${Formatters.units(t.vatPercent)}'),
            Text('${l.tariffRebate}: ${Formatters.units(t.rebatePercent)}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(version.archived
            ? Icons.inventory_2_outlined
            : Icons.receipt_long_outlined),
        title: Row(
          children: [
            Flexible(child: Text(version.label)),
            if (version.archived) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(l.tariffArchived, style: theme.textTheme.labelSmall),
              ),
            ],
          ],
        ),
        subtitle: Text(l.tariffEffective(Formatters.date(version.effectiveFrom))),
        trailing: PopupMenuButton<String>(
          onSelected: (a) => _handle(context, a),
          itemBuilder: (ctx) => [
            PopupMenuItem(value: 'preview', child: Text(l.actionPreview)),
            PopupMenuItem(value: 'edit', child: Text(l.actionEdit)),
            PopupMenuItem(value: 'clone', child: Text(l.actionClone)),
            PopupMenuItem(
                value: 'archive',
                child:
                    Text(version.archived ? l.actionUnarchive : l.actionArchive)),
            PopupMenuItem(value: 'delete', child: Text(l.actionDelete)),
          ],
        ),
        onTap: () => _preview(context, repo.decode(version.tariffJson)),
      ),
    );
  }
}
