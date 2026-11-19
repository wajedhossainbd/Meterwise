import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/database/app_database.dart';
import '../../../core/theme/soft_ui.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/data/settings_repository.dart';
import '../data/tenant_repository.dart';

/// Tenant-side join: scan the landlord's QR or type the meter code, then enter
/// the roster name the landlord created. A name can always be typed even when
/// the roster has not been synced to this device yet.
class JoinMeterScreen extends ConsumerStatefulWidget {
  const JoinMeterScreen({super.key});

  @override
  ConsumerState<JoinMeterScreen> createState() => _JoinMeterScreenState();
}

class _JoinMeterScreenState extends ConsumerState<JoinMeterScreen> {
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _scanner = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
  );
  bool _scanning = true;
  bool _busy = false;
  int? _chosenTenantId;

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
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

  Future<void> _join() async {
    final l = AppLocalizations.of(context);
    final code = _code.text.trim().toUpperCase();
    final name = _name.text.trim();
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
    await ref.read(settingsRepositoryProvider).joinMeter(
          code: code,
          name: name,
          tenantId: _chosenTenantId,
        );
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final tenants = ref.watch(tenantListProvider).value ?? const [];

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
            icon: Icon(
                _scanning ? Icons.keyboard_outlined : Icons.qr_code_scanner),
            label: Text(_scanning ? l.tenantEnterCode : l.tenantScanQr),
          ),
          const SizedBox(height: 24),
          Text(l.tenantChooseName,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          SoftInset(
            padding: const EdgeInsets.all(12),
            child: Text(l.tenantJoinNameHint,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(labelText: l.rechargePaidByName),
          ),
          if (tenants.isNotEmpty) ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: _chosenTenantId,
              decoration:
                  InputDecoration(labelText: l.rechargeCreditedTo),
              items: [
                for (final t in tenants)
                  DropdownMenuItem<int>(
                    value: t.id,
                    child: Text(t.name),
                  ),
              ],
              onChanged: (v) {
                setState(() {
                  _chosenTenantId = v;
                  final match = tenants
                      .where((t) => t.id == v)
                      .cast<Tenant>()
                      .firstOrNull;
                  if (match != null) _name.text = match.name;
                });
              },
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _busy || _name.text.trim().isEmpty ? null : _join,
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
