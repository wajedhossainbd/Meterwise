import 'package:flutter/material.dart';
import '../../../core/theme/soft_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/attachment_picker.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/application/period_actions.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/reading_repository.dart';

/// Records a reading session: one main-meter value plus a value per tenant,
/// all on the chosen date.
class AddReadingScreen extends ConsumerStatefulWidget {
  const AddReadingScreen({super.key});

  @override
  ConsumerState<AddReadingScreen> createState() => _AddReadingScreenState();
}

class _AddReadingScreenState extends ConsumerState<AddReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _main = TextEditingController();
  final _notes = TextEditingController();
  final Map<int, TextEditingController> _tenantCtrls = {};

  DateTime _date = DateTime.now();
  String? _photoPath;
  bool _saving = false;

  @override
  void dispose() {
    _main.dispose();
    _notes.dispose();
    for (final c in _tenantCtrls.values) {
      c.dispose();
    }
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

  /// Returns an error message if the entry is invalid, else null.
  String? _validateReadings(
      double mainValue, Map<int, double> tenantReadings, AppLocalizations l) {
    final readings = ref.read(readingListProvider).value ?? const [];
    final date = DateTime(_date.year, _date.month, _date.day);

    // Prevent a duplicate session on the same date.
    final duplicate = readings.any((r) => r.readingDate == date);
    if (duplicate) {
      return l.readingDuplicate(Formatters.date(date));
    }

    // Prevent impossible (lower) main reading vs the last one before this date.
    final lastMain = readings
        .where((r) => r.mainMeterId != null && r.readingDate.isBefore(date))
        .fold<double?>(null, (max, r) => max == null || r.readingValue > max ? r.readingValue : max);
    if (lastMain != null && mainValue < lastMain) {
      return l.readingMainLower(
          Formatters.units(mainValue), Formatters.units(lastMain));
    }

    for (final entry in tenantReadings.entries) {
      final lastT = readings
          .where((r) =>
              r.tenantId == entry.key && r.readingDate.isBefore(date))
          .fold<double?>(null,
              (max, r) => max == null || r.readingValue > max ? r.readingValue : max);
      if (lastT != null && entry.value < lastT) {
        return l.readingTenantLower(
            Formatters.units(entry.value), Formatters.units(lastT));
      }
    }
    return null;
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    final meter = await ref.read(mainMeterRepositoryProvider).getFirst();
    if (meter == null || !mounted) return;

    final locked = await ref
        .read(periodActionsProvider)
        .isFinalizedOn(DateTime(_date.year, _date.month, _date.day));
    if (locked) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.readingLockedMsg)),
        );
      }
      return;
    }
    if (!mounted) return;

    final tenantReadings = <int, double>{
      for (final entry in _tenantCtrls.entries)
        if (entry.value.text.trim().isNotEmpty)
          entry.key: double.parse(entry.value.text.trim()),
    };
    final mainValue = double.parse(_main.text.trim());

    final error = _validateReadings(mainValue, tenantReadings, l);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    setState(() => _saving = true);
    await ref.read(readingRepositoryProvider).addSession(
          mainMeterId: meter.id,
          date: DateTime(_date.year, _date.month, _date.day),
          mainReading: mainValue,
          tenantReadings: tenantReadings,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
          photoPath: _photoPath,
        );

    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final l = AppLocalizations.of(context);
    for (final t in tenants) {
      _tenantCtrls.putIfAbsent(t.id, TextEditingController.new);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.readingAdd)),
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
              title: l.readingMainMeter,
              child: _readingField(
                _main,
                l.readingCurrentReading,
                required: true,
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.readingTenantSubmeters,
              child: Column(
                children: [
                  if (tenants.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(l.readingNoTenants),
                    ),
                  for (final t in tenants) ...[
                    _readingField(_tenantCtrls[t.id]!, t.name),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.readingMeterPhoto,
              child: AttachmentPicker(
                label: l.readingMeterPhoto,
                path: _photoPath,
                onChanged: (p) => setState(() => _photoPath = p),
              ),
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
                  : Text(l.readingAdd),
            ),
          ],
        ),
      ),
    );
  }

  Widget _readingField(
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
}
