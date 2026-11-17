import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../data/property_repository.dart';

/// Create or edit the (single, for now) property.
class PropertyEditScreen extends ConsumerStatefulWidget {
  const PropertyEditScreen({super.key});

  @override
  ConsumerState<PropertyEditScreen> createState() => _PropertyEditScreenState();
}

class _PropertyEditScreenState extends ConsumerState<PropertyEditScreen> {
  static const _currencies = ['BDT', 'USD', 'EUR', 'GBP', 'INR', 'PKR'];

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _address = TextEditingController();
  String _currency = 'BDT';

  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    await ref.read(propertyRepositoryProvider).upsertSingle(
          name: _name.text.trim(),
          address:
              _address.text.trim().isEmpty ? null : _address.text.trim(),
          currencyCode: _currency,
        );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Hydrate the form once from the current property, if any.
    final property = ref.watch(currentPropertyProvider).value;
    if (!_initialized && property != null) {
      _name.text = property.name;
      _address.text = property.address ?? '';
      _currency = property.currencyCode;
      _initialized = true;
    }

    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.propertyTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: l.propertyName,
                hintText: l.propertyNameHint,
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? l.propertyNameRequired
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _address,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 2,
              decoration: InputDecoration(labelText: l.propertyAddress),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _currency,
              decoration: InputDecoration(labelText: l.settingsCurrency),
              items: [
                for (final c in _currencies)
                  DropdownMenuItem(value: c, child: Text(c)),
              ],
              onChanged: (v) => setState(() => _currency = v ?? 'BDT'),
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
