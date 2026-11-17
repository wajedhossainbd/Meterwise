import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../properties/data/property_repository.dart';
import '../../tariff/data/tariff_repository.dart';
import '../data/main_meter_repository.dart';

/// Create or edit the (single, for now) main meter.
class MainMeterEditScreen extends ConsumerStatefulWidget {
  const MainMeterEditScreen({super.key});

  @override
  ConsumerState<MainMeterEditScreen> createState() =>
      _MainMeterEditScreenState();
}

class _MainMeterEditScreenState extends ConsumerState<MainMeterEditScreen> {
  /// Bangladesh distribution utilities. Retail residential tariffs are uniform
  /// nationwide (BERC), so the choice is a label used on invoices/presets.
  static const providers = ['DPDC', 'DESCO', 'BPDB', 'BREB', 'NESCO', 'WZPDCL'];

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _meterNumber = TextEditingController();
  String _provider = 'DPDC';

  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _meterNumber.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final property = await ref.read(propertyRepositoryProvider).getFirst();
    if (property == null) {
      setState(() => _saving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context).meterCreatePropertyFirst)),
        );
      }
      return;
    }
    final provider =
        await ref.read(tariffRepositoryProvider).getDefaultProvider();

    await ref.read(mainMeterRepositoryProvider).upsertSingle(
          propertyId: property.id,
          providerId: provider.id,
          name: _name.text.trim(),
          meterNumber: _meterNumber.text.trim().isEmpty
              ? null
              : _meterNumber.text.trim(),
          providerName: _provider,
        );
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _initProvider() async {
    final name = await ref.read(mainMeterRepositoryProvider).providerName();
    if (mounted && name != null && providers.contains(name)) {
      setState(() => _provider = name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final meter = ref.watch(currentMainMeterProvider).value;
    if (!_initialized && meter != null) {
      _name.text = meter.name;
      _meterNumber.text = meter.meterNumber ?? '';
      _initialized = true;
      _initProvider();
    }

    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.meterTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: l.meterName,
                hintText: l.meterNameHint,
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l.meterNameRequired : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _meterNumber,
              decoration: InputDecoration(labelText: l.meterNumber),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _provider,
              decoration: InputDecoration(labelText: l.meterProvider),
              items: [
                for (final p in _MainMeterEditScreenState.providers)
                  DropdownMenuItem(value: p, child: Text(p)),
              ],
              onChanged: (v) => setState(() => _provider = v ?? 'DPDC'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l.actionSave),
            ),
          ],
        ),
      ),
    );
  }
}
