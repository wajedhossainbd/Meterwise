import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../data/tenant_repository.dart';

/// Add a new tenant or edit an existing one (passed via `extra`).
class TenantEditScreen extends ConsumerStatefulWidget {
  const TenantEditScreen({this.tenant, super.key});

  final Tenant? tenant;

  @override
  ConsumerState<TenantEditScreen> createState() => _TenantEditScreenState();
}

class _TenantEditScreenState extends ConsumerState<TenantEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _apartment;
  late final TextEditingController _meterNumber;
  late final TextEditingController _fixedRate;

  String _billingMode = 'shared';
  bool _saving = false;

  bool get _isEditing => widget.tenant != null;

  @override
  void initState() {
    super.initState();
    final t = widget.tenant;
    _name = TextEditingController(text: t?.name ?? '');
    _phone = TextEditingController(text: t?.phone ?? '');
    _email = TextEditingController(text: t?.email ?? '');
    _apartment = TextEditingController(text: t?.apartment ?? '');
    _meterNumber = TextEditingController(text: t?.meterNumber ?? '');
    _billingMode = t?.billingMode ?? 'shared';
    final rate = t?.fixedRate;
    _fixedRate = TextEditingController(
      text: rate == null
          ? ''
          : (rate == rate.roundToDouble()
              ? rate.toStringAsFixed(0)
              : rate.toString()),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _apartment.dispose();
    _meterNumber.dispose();
    _fixedRate.dispose();
    super.dispose();
  }

  String? _nn(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(tenantRepositoryProvider);
    final fixedRate = _billingMode == 'fixed'
        ? double.tryParse(_fixedRate.text.trim())
        : null;

    if (_isEditing) {
      try {
        await repo.updateFields(
          widget.tenant!.id,
          name: _name.text.trim(),
          phone: _nn(_phone),
          email: _nn(_email),
          apartment: _nn(_apartment),
          meterNumber: _nn(_meterNumber),
          billingMode: _billingMode,
          fixedRate: fixedRate,
        );
      } on FinalizedPeriodException {
        if (mounted) {
          setState(() => _saving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context).periodLockedMessage)),
          );
        }
        return;
      }
    } else {
      final meter = await ref.read(mainMeterRepositoryProvider).getFirst();
      if (meter == null) {
        setState(() => _saving = false);
        return;
      }
      await repo.create(
        mainMeterId: meter.id,
        name: _name.text.trim(),
        phone: _nn(_phone),
        email: _nn(_email),
        apartment: _nn(_apartment),
        meterNumber: _nn(_meterNumber),
        billingMode: _billingMode,
        fixedRate: fixedRate,
      );
    }
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(_isEditing ? l.tenantEditTitle : l.tenantAddTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(labelText: l.tenantName),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l.tenantNameRequired : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _apartment,
              decoration: InputDecoration(labelText: l.tenantApartment),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _meterNumber,
              decoration: InputDecoration(labelText: l.tenantSubmeter),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: l.tenantPhone),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: l.tenantEmail),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Text(l.tenantBillingMode,
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    RadioGroup<String>(
                      groupValue: _billingMode,
                      onChanged: (v) =>
                          setState(() => _billingMode = v ?? 'shared'),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            value: 'shared',
                            title: Text(l.tenantModeShared),
                            subtitle: Text(l.tenantModeSharedSub),
                          ),
                          RadioListTile<String>(
                            value: 'fixed',
                            title: Text(l.tenantModeFixed),
                            subtitle: Text(l.tenantModeFixedSub),
                          ),
                        ],
                      ),
                    ),
                    if (_billingMode == 'fixed')
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        child: TextFormField(
                          controller: _fixedRate,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                              labelText: l.tenantFixedRateLabel),
                          validator: (v) {
                            if (_billingMode != 'fixed') return null;
                            final n = double.tryParse((v ?? '').trim());
                            if (n == null || n <= 0) {
                              return l.tenantFixedRateRequired;
                            }
                            return null;
                          },
                        ),
                      ),
                  ],
                ),
              ),
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
