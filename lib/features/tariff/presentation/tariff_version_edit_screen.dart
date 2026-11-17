import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/application/billing_providers.dart';
import '../../billing/domain/models/tariff.dart';
import '../../properties/data/property_repository.dart';
import '../data/tariff_version_repository.dart';

/// Create, edit or clone a tariff version.
class TariffVersionEditScreen extends ConsumerStatefulWidget {
  const TariffVersionEditScreen({
    this.versionId,
    this.source,
    this.initialLabel,
    this.initialEffectiveFrom,
    super.key,
  });

  /// When set, edits this existing version; otherwise creates a new one.
  final int? versionId;

  /// Tariff to prefill from (clone/preset/edit source).
  final Tariff? source;
  final String? initialLabel;
  final DateTime? initialEffectiveFrom;

  @override
  ConsumerState<TariffVersionEditScreen> createState() =>
      _TariffVersionEditScreenState();
}

class _SlabRow {
  _SlabRow({String from = '', String to = '', String rate = ''})
      : from = TextEditingController(text: from),
        to = TextEditingController(text: to),
        rate = TextEditingController(text: rate);
  final TextEditingController from;
  final TextEditingController to;
  final TextEditingController rate;
  void dispose() {
    from.dispose();
    to.dispose();
    rate.dispose();
  }
}

class _TariffVersionEditScreenState
    extends ConsumerState<TariffVersionEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _label = TextEditingController();
  final _demand = TextEditingController();
  final _meterRent = TextEditingController();
  final _vat = TextEditingController();
  final _rebate = TextEditingController();
  final _lifelineUpTo = TextEditingController();
  final _lifelineRate = TextEditingController();
  final List<_SlabRow> _slabs = [];

  late DateTime _effectiveFrom;
  bool _saving = false;

  bool get _isEditing => widget.versionId != null;

  @override
  void initState() {
    super.initState();
    _effectiveFrom = widget.initialEffectiveFrom ?? DateTime.now();
    _label.text = widget.initialLabel ?? '';
    final t = widget.source;
    if (t != null) {
      _demand.text = _fmt(t.demandCharge);
      _meterRent.text = _fmt(t.meterRent);
      _vat.text = _fmt(t.vatPercent);
      _rebate.text = _fmt(t.rebatePercent);
      if (t.lifelineUpTo != null) _lifelineUpTo.text = '${t.lifelineUpTo}';
      if (t.lifelineRate != null) _lifelineRate.text = _fmt(t.lifelineRate!);
      for (final s in t.slabs) {
        _slabs.add(_SlabRow(
          from: '${s.fromUnit}',
          to: s.toUnit?.toString() ?? '',
          rate: _fmt(s.rate),
        ));
      }
    }
    if (_slabs.isEmpty) _slabs.add(_SlabRow(from: '0'));
  }

  @override
  void dispose() {
    for (final c in [
      _label,
      _demand,
      _meterRent,
      _vat,
      _rebate,
      _lifelineUpTo,
      _lifelineRate,
    ]) {
      c.dispose();
    }
    for (final s in _slabs) {
      s.dispose();
    }
    super.dispose();
  }

  void _addSlab() => setState(() => _slabs.add(_SlabRow()));
  void _removeSlab(int i) => setState(() => _slabs.removeAt(i).dispose());

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _effectiveFrom,
      firstDate: DateTime(2015),
      lastDate: DateTime(DateTime.now().year + 5, 12, 31),
    );
    if (picked != null) setState(() => _effectiveFrom = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final lifelineUpTo = int.tryParse(_lifelineUpTo.text.trim());
    final lifelineRate = double.tryParse(_lifelineRate.text.trim());
    final tariff = Tariff(
      slabs: [
        for (final s in _slabs)
          TariffSlabRange(
            fromUnit: int.parse(s.from.text.trim()),
            toUnit:
                s.to.text.trim().isEmpty ? null : int.parse(s.to.text.trim()),
            rate: double.parse(s.rate.text.trim()),
          ),
      ],
      demandCharge: double.parse(_demand.text.trim()),
      meterRent: double.parse(_meterRent.text.trim()),
      vatPercent: double.parse(_vat.text.trim()),
      rebatePercent: double.parse(_rebate.text.trim()),
      currencyCode: ref.read(currencyCodeProvider),
      // Lifeline is preserved only when BOTH fields are set.
      lifelineUpTo:
          (lifelineUpTo != null && lifelineRate != null) ? lifelineUpTo : null,
      lifelineRate:
          (lifelineUpTo != null && lifelineRate != null) ? lifelineRate : null,
    );
    final repo = ref.read(tariffVersionRepositoryProvider);
    final label =
        _label.text.trim().isEmpty ? 'Untitled version' : _label.text.trim();
    final date =
        DateTime(_effectiveFrom.year, _effectiveFrom.month, _effectiveFrom.day);

    try {
      if (_isEditing) {
        await repo.updateVersion(
            id: widget.versionId!,
            label: label,
            effectiveFrom: date,
            tariff: tariff);
      } else {
        await repo.createVersion(
            label: label, effectiveFrom: date, tariff: tariff);
      }
    } on TariffException catch (e) {
      setState(() => _saving = false);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
      return;
    }

    ref.invalidate(periodViewProvider);
    ref.invalidate(monthlyHistoryProvider);
    if (mounted) {
      final l = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(_isEditing ? l.tariffUpdatedToast : l.tariffSavedToast)),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l.tariffEditVersion : l.tariffNewVersion),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _label,
              decoration: InputDecoration(labelText: l.tariffVersionLabel),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l.tariffEnterLabel : null,
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.event),
                title: Text(l.tariffEffectiveFrom),
                subtitle: Text(Formatters.date(_effectiveFrom)),
                trailing: const Icon(Icons.edit_calendar_outlined),
                onTap: _pickDate,
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.tariffSlabs,
              trailing: IconButton(
                onPressed: _addSlab,
                icon: const Icon(Icons.add),
                tooltip: l.tariffAddVersion,
              ),
              child: Column(
                children: [
                  _SlabHeader(l: l),
                  for (var i = 0; i < _slabs.length; i++) _slabRow(i, _slabs[i]),
                  const SizedBox(height: 4),
                  Text(
                    l.tariffSlabHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.tariffLifeline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.tariffLifelineHint,
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _lifelineUpTo,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                              labelText: l.tariffLifelineUpTo),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _lifelineRate,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                          decoration: InputDecoration(
                              labelText: l.tariffLifelineRate),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.tariffFixedCharges,
              child: Column(
                children: [
                  _numberField(_demand, l.tariffDemandCharge),
                  const SizedBox(height: 12),
                  _numberField(_meterRent, l.tariffMeterRent),
                  const SizedBox(height: 12),
                  _numberField(_vat, l.tariffVat),
                  const SizedBox(height: 12),
                  _numberField(_rebate, l.tariffRebate),
                ],
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
                  : Text(_isEditing ? l.tariffSaveChanges : l.tariffSaveVersion),
            ),
          ],
        ),
      ),
    );
  }

  Widget _slabRow(int i, _SlabRow row) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(child: _slabCell(row.from, l.tariffSlabFrom, isInt: true)),
          const SizedBox(width: 8),
          Expanded(
              child: _slabCell(row.to, l.tariffSlabTo,
                  isInt: true, optional: true)),
          const SizedBox(width: 8),
          Expanded(child: _slabCell(row.rate, l.tariffSlabRate)),
          IconButton(
            onPressed: _slabs.length > 1 ? () => _removeSlab(i) : null,
            icon: const Icon(Icons.remove_circle_outline),
            tooltip: l.actionRemove,
          ),
        ],
      ),
    );
  }

  Widget _slabCell(TextEditingController c, String hint,
      {bool isInt = false, bool optional = false}) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.numberWithOptions(decimal: !isInt),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            isInt ? RegExp(r'[0-9]') : RegExp(r'[0-9.]')),
      ],
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      validator: (v) {
        if (optional && (v == null || v.trim().isEmpty)) return null;
        if (v == null || v.trim().isEmpty) return '!';
        if (isInt && int.tryParse(v.trim()) == null) return '!';
        if (!isInt && double.tryParse(v.trim()) == null) return '!';
        return null;
      },
    );
  }

  Widget _numberField(TextEditingController c, String label) {
    return TextFormField(
      controller: c,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      decoration: InputDecoration(labelText: label),
      validator: (v) => (v == null || double.tryParse(v.trim()) == null)
          ? AppLocalizations.of(context).commonEnterNumber
          : null,
    );
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}

class _SlabHeader extends StatelessWidget {
  const _SlabHeader({required this.l});
  final AppLocalizations l;
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall;
    return Row(
      children: [
        Expanded(child: Text(l.tariffSlabFrom, style: style)),
        const SizedBox(width: 8),
        Expanded(child: Text(l.tariffSlabTo, style: style)),
        const SizedBox(width: 8),
        Expanded(child: Text(l.tariffSlabRate, style: style)),
        const SizedBox(width: 48),
      ],
    );
  }
}
