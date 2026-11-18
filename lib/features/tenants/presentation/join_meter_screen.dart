import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../l10n/app_localizations.dart';
import '../../settings/data/settings_repository.dart';
import '../data/tenant_repository.dart';

/// Tenant-side join: scan the landlord's QR or type the meter code, then pick
/// the roster name the landlord already created. Approval follows on the
/// landlord's device (Invite tenant screen).
class JoinMeterScreen extends ConsumerStatefulWidget {
  const JoinMeterScreen({super.key});

  @override
  ConsumerState<JoinMeterScreen> createState() => _JoinMeterScreenState();
}

class _JoinMeterScreenState extends ConsumerState<JoinMeterScreen> {
  final _code = TextEditingController();
  final _scanner = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
  );
  bool _scanning = true;
  bool _busy = false;

  @override
  void dispose() {
    _code.dispose();
    _scanner.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final value = capture.barcodes.firstOrNull?.rawValue;
    if (value == null || value.isEmpty || _busy) return;
    _code.text = value;
    setState(() => _scanning = false);
    _scanner.stop();
  }

  Future<void> _join(String name) async {
    final l = AppLocalizations.of(context);
    final code = _code.text.trim().toUpperCase();
    if (code.isEmpty || name.isEmpty) return;
    setState(() => _busy = true);
    // Prototype: accept any well-formed code so a tenant on a different device
    // can join using the landlord's code. Real deployment resolves it against
    // the shared Drive room instead.
    final wellFormed = RegExp(r'^MW-[A-Z0-9]{4}-[A-Z0-9]{4}$').hasMatch(code);
    if (!wellFormed) {
      if (mounted) {
        setState(() => _busy = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.tenantCodeMismatch)));
      }
      return;
    }
    await ref
        .read(settingsRepositoryProvider)
        .joinMeter(code: code, name: name);
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final selected = tenants.isEmpty ? null : tenants.first.name;
    String? chosenName = selected;

    return Scaffold(
      appBar: AppBar(title: Text(l.tenantJoinTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_scanning)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 260,
                child: MobileScanner(controller: _scanner, onDetect: _onDetect),
              ),
            )
          else
            TextField(
              controller: _code,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: l.tenantMeterCode,
                border: const OutlineInputBorder(),
              ),
            ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {
              if (_scanning) {
                _scanner.stop();
              } else {
                _scanner.start();
              }
              setState(() => _scanning = !_scanning);
            },
            icon: Icon(_scanning ? Icons.keyboard_outlined : Icons.qr_code_scanner),
            label: Text(_scanning ? l.tenantEnterCode : l.tenantScanQr),
          ),
          const SizedBox(height: 24),
          Text(l.tenantChooseName,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (tenants.isEmpty)
            Text(l.commonSomethingWrong, style: theme.textTheme.bodyMedium)
          else
            StatefulBuilder(
              builder: (context, setLocal) => DropdownButtonFormField<String>(
                initialValue: chosenName,
                items: [
                  for (final t in tenants)
                    DropdownMenuItem(value: t.name, child: Text(t.name)),
                ],
                onChanged: (v) {
                  setLocal(() => chosenName = v);
                },
              ),
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _busy ? null : () => _join(chosenName ?? ''),
            child: _busy
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l.tenantJoinTitle),
          ),
        ],
      ),
    );
  }
}
