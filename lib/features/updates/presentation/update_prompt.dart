import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constants/app_constants.dart';
import '../../../l10n/app_localizations.dart';
import '../data/update_service.dart';

/// One-shot update check on cold start for GitHub-distributed APK builds.
class UpdatePrompt {
  UpdatePrompt._();

  static bool _checked = false;

  static void maybeShow(BuildContext context) {
    if (!AppConstants.githubUpdaterEnabled || _checked) return;
    _checked = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) return;
      final info = await PackageInfo.fromPlatform();
      final latest = await UpdateService.checkLatest();
      if (latest == null ||
          !UpdateService.isNewer(latest.version, info.version) ||
          !context.mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (ctx) => _UpdateDialog(release: latest),
      );
    });
  }
}

class _UpdateDialog extends StatefulWidget {
  const _UpdateDialog({required this.release});

  final ReleaseInfo release;

  @override
  State<_UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<_UpdateDialog> {
  bool _busy = false;
  int _received = 0;
  int _total = 0;
  String? _error;

  Future<void> _downloadAndInstall() async {
    final l = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final path = await UpdateService.downloadApk(
        widget.release.apkUrl,
        (received, total) {
          if (mounted) {
            setState(() {
              _received = received;
              _total = total;
            });
          }
        },
      );
      final result = await OpenFilex.open(path);
      if (!mounted) return;
      if (result.type != ResultType.done) {
        setState(() => _error = result.message);
      } else {
        Navigator.of(context).pop();
      }
    } on Object {
      if (mounted) setState(() => _error = l.updateFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final progress = _total > 0 ? (_received / _total).clamp(0.0, 1.0) : null;

    return AlertDialog(
      title: Text(l.updateAvailable(widget.release.version)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.updateBody, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            Text(
              widget.release.notes.length > 500
                  ? '${widget.release.notes.substring(0, 500)}…'
                  : widget.release.notes,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            if (_busy && progress != null) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(value: progress),
            ],
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: Text(l.updateLater),
        ),
        FilledButton(
          onPressed: _busy ? null : _downloadAndInstall,
          child: Text(l.updateInstall),
        ),
      ],
    );
  }
}
