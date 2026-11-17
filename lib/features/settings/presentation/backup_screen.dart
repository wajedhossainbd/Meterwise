import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../data/backup_service.dart';

/// Local backup & restore. Google Drive sync is planned but needs the user's
/// Google Cloud OAuth credentials, so it's shown as "coming soon".
class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _busy = false;

  Future<void> _backup() async {
    final l = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final file = await ref.read(backupServiceProvider).createBackup();
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'MeterWise backup',
        ),
      );
    } catch (e) {
      _snack(l.backupFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _restore() async {
    final l = AppLocalizations.of(context);
    final picked = await FilePicker.platform.pickFiles(type: FileType.any);
    final path = picked?.files.single.path;
    if (path == null) return;
    if (!path.toLowerCase().endsWith('.zip')) {
      _snack(l.backupChooseZip);
      return;
    }
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.backupRestoreTitle),
        content: Text(l.backupRestoreWarning),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.actionCancel)),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.backupRestore)),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _busy = true);
    try {
      final ok =
          await ref.read(backupServiceProvider).restoreFrom(File(path));
      if (!mounted) return;
      if (!ok) {
        _snack(l.backupNotValid);
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.backupRestoreStagedTitle),
          content: Text(l.backupRestoreStagedMsg),
          actions: [
            FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l.actionGotIt)),
          ],
        ),
      );
    } catch (e) {
      _snack(l.backupRestoreFailed('$e'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _snack(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.backupTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            title: l.backupLocal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l.backupDesc),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _busy ? null : _backup,
                  icon: const Icon(Icons.backup_outlined),
                  label: Text(l.backupNow),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _busy ? null : _restore,
                  icon: const Icon(Icons.restore_outlined),
                  label: Text(l.backupRestore),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.cloud_outlined),
              title: Text(l.backupDriveTitle),
              subtitle: Text(l.backupDriveSoon),
              enabled: false,
            ),
          ),
          if (_busy)
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
