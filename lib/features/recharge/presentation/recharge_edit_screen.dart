import 'package:flutter/material.dart';
import '../../../core/theme/soft_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/attachment_picker.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/application/period_actions.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/recharge_repository.dart';

/// Add a new recharge or edit an existing one (passed via `extra`).
class RechargeEditScreen extends ConsumerStatefulWidget {
  const RechargeEditScreen({this.recharge, super.key});

  final Recharge? recharge;

  @override
  ConsumerState<RechargeEditScreen> createState() => _RechargeEditScreenState();
}

class _RechargeEditScreenState extends ConsumerState<RechargeEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _amount;
  late final TextEditingController _energy;
  late final TextEditingController _demand;
  late final TextEditingController _meterRent;
  late final TextEditingController _vat;
  late final TextEditingController _rebate;
  late final TextEditingController _agentFee;
  late final TextEditingController _other;
  late final TextEditingController _paidBy;
  late final TextEditingController _token;
  late final TextEditingController _notes;

  late DateTime _date;
  String? _receiptPath;
  bool _saving = false;

  bool get _isEditing => widget.recharge != null;

  @override
  void initState() {
    super.initState();
    final r = widget.recharge;
    _date = r?.rechargeDate ?? DateTime.now();
    _receiptPath = r?.receiptPath;
    _amount = _ctrl(r?.amount);
    _energy = _ctrl(r?.energyCost);
    _demand = _ctrl(r?.demandCharge);
    _meterRent = _ctrl(r?.meterRent);
    _vat = _ctrl(r?.vat);
    _rebate = _ctrl(r?.rebate);
    _agentFee = _ctrl(r?.agentFee);
    _other = _ctrl(r?.otherExpenses);
    _paidBy = TextEditingController(text: r?.paidBy ?? '');
    _token = TextEditingController(text: r?.tokenNumber ?? '');
    _notes = TextEditingController(text: r?.notes ?? '');
  }

  TextEditingController _ctrl(double? v) =>
      TextEditingController(text: (v == null || v == 0) ? '' : _fmt(v));

  @override
  void dispose() {
    for (final c in [
      _amount,
      _energy,
      _demand,
      _meterRent,
      _vat,
      _rebate,
      _agentFee,
      _other,
      _paidBy,
      _token,
      _notes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  double _num(TextEditingController c) =>
      double.tryParse(c.text.trim()) ?? 0;

  String? _nn(TextEditingController c) =>
      c.text.trim().isEmpty ? null : c.text.trim();

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
    if (!_formKey.currentState!.validate()) return;

    // Block changes in a finalized (locked) month — both the target month and,
    // when editing, the original month.
    final actions = ref.read(periodActionsProvider);
    final targetDate = DateTime(_date.year, _date.month, _date.day);
    final locked = await actions.isFinalizedOn(targetDate) ||
        (_isEditing &&
            await actions.isFinalizedOn(widget.recharge!.rechargeDate));
    if (locked) {
      if (mounted) _showLocked();
      return;
    }

    setState(() => _saving = true);

    final draft = (
      date: DateTime(_date.year, _date.month, _date.day),
      amount: _num(_amount),
      energyCost: _num(_energy),
      demandCharge: _num(_demand),
      meterRent: _num(_meterRent),
      vat: _num(_vat),
      rebate: _num(_rebate),
      agentFee: _num(_agentFee),
      otherExpenses: _num(_other),
      paidBy: _nn(_paidBy),
      tokenNumber: _nn(_token),
      notes: _nn(_notes),
      receiptPath: _receiptPath,
    );

    final repo = ref.read(rechargeRepositoryProvider);
    if (_isEditing) {
      await repo.updateRecharge(widget.recharge!.id, draft);
    } else {
      final meter = await ref.read(mainMeterRepositoryProvider).getFirst();
      if (meter == null) {
        setState(() => _saving = false);
        return;
      }
      await repo.create(meter.id, draft);
    }
    if (mounted) Navigator.of(context).pop(true);
  }

  void _showLocked() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).rechargeLockedMsg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l.rechargeEditTitle : l.rechargeAddTitle),
      ),
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
              title: l.rechargeAmountPaid,
              child: _money(_amount, l.rechargeAmount, required: true),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.rechargePaidBy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _paidBy,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l.rechargePaidByName,
                      helperText: l.rechargePaidByHelp,
                    ),
                  ),
                  if (tenants.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final t in tenants)
                          ActionChip(
                            label: Text(t.name),
                            onPressed: () => setState(
                                () => _paidBy.text = t.name),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.rechargeReceipt,
              child: AttachmentPicker(
                label: l.rechargeReceipt,
                path: _receiptPath,
                onChanged: (p) => setState(() => _receiptPath = p),
              ),
            ),
            const SizedBox(height: 16),
            SoftCard(
              child: ExpansionTile(
                shape: const Border(),
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                childrenPadding:
                    const EdgeInsets.fromLTRB(16, 0, 16, 16),
                title: Text(l.rechargeBreakdown),
                subtitle: Text(l.rechargeBreakdownSub),
                children: [
                  _money(_energy, l.rechargeEnergy),
                  const SizedBox(height: 12),
                  _money(_demand, l.rechargeDemand),
                  const SizedBox(height: 12),
                  _money(_meterRent, l.rechargeMeterRent),
                  const SizedBox(height: 12),
                  _money(_vat, l.rechargeVat),
                  const SizedBox(height: 12),
                  _money(_rebate, l.rechargeRebate),
                  const SizedBox(height: 12),
                  _money(_agentFee, l.rechargeAgentFee),
                  const SizedBox(height: 12),
                  _money(_other, l.rechargeOther),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _token,
              decoration: InputDecoration(labelText: l.rechargeToken),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notes,
              maxLines: 2,
              decoration: InputDecoration(labelText: l.commonNotes),
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
                  : Text(l.rechargeAdd),
            ),
          ],
        ),
      ),
    );
  }

  Widget _money(
    TextEditingController c,
    String label, {
    bool required = false,
  }) {
    return TextFormField(
      controller: c,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        final l = AppLocalizations.of(context);
        if (!required && (v == null || v.trim().isEmpty)) return null;
        if (v == null || v.trim().isEmpty) return l.commonRequired;
        if (double.tryParse(v.trim()) == null) return l.commonEnterNumber;
        return null;
      },
    );
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}
