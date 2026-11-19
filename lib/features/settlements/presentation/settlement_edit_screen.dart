import 'package:flutter/material.dart';
import '../../../core/theme/soft_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/settlement_repository.dart';

/// Record a tenant-to-tenant settlement (a direct payment between tenants).
class SettlementEditScreen extends ConsumerStatefulWidget {
  const SettlementEditScreen({super.key});

  @override
  ConsumerState<SettlementEditScreen> createState() =>
      _SettlementEditScreenState();
}

class _SettlementEditScreenState extends ConsumerState<SettlementEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _notes = TextEditingController();
  DateTime _date = DateTime.now();
  int? _fromId;
  int? _toId;
  bool _saving = false;

  @override
  void dispose() {
    _amount.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 1, 12, 31),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_fromId == null || _toId == null) return;
    if (_fromId == _toId) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.settlementSameTenant)),
      );
      return;
    }
    final meter = await ref.read(mainMeterRepositoryProvider).getFirst();
    if (meter == null || !mounted) return;

    setState(() => _saving = true);
    try {
      await ref.read(settlementRepositoryProvider).create(meter.id, (
        date: DateTime(_date.year, _date.month, _date.day),
        fromTenantId: _fromId!,
        toTenantId: _toId!,
        amount: double.parse(_amount.text.trim()),
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
      ));
    } on FinalizedPeriodException {
      setState(() => _saving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.periodLockedMessage)),
        );
      }
      return;
    }
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.settlementNew)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SoftCard(
              child: ListTile(
                leading: const Icon(Icons.event),
                title: Text(l.readingDate),
                subtitle: Text(Formatters.date(_date)),
                trailing: const Icon(Icons.edit_calendar_outlined),
                onTap: _pickDate,
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.settlementTransfer,
              child: Column(
                children: [
                  DropdownButtonFormField<int>(
                    initialValue: _fromId,
                    decoration: InputDecoration(labelText: l.settlementFrom),
                    items: [
                      for (final t in tenants)
                        DropdownMenuItem(value: t.id, child: Text(t.name)),
                    ],
                    onChanged: (v) => setState(() => _fromId = v),
                    validator: (v) =>
                        v == null ? l.settlementSelectTenant : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: _toId,
                    decoration: InputDecoration(labelText: l.settlementTo),
                    items: [
                      for (final t in tenants)
                        DropdownMenuItem(value: t.id, child: Text(t.name)),
                    ],
                    onChanged: (v) => setState(() => _toId = v),
                    validator: (v) =>
                        v == null ? l.settlementSelectTenant : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amount,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
              ],
              decoration: InputDecoration(labelText: l.settlementAmount),
              validator: (v) {
                final n = double.tryParse((v ?? '').trim());
                if (n == null || n <= 0) return l.commonEnterPositive;
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notes,
              maxLines: 2,
              decoration: InputDecoration(labelText: l.commonNotesOptional),
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
                  : Text(l.settlementAdd),
            ),
          ],
        ),
      ),
    );
  }
}
