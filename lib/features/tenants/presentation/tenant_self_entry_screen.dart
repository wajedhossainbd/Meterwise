import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../../billing/data/period_guard.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../readings/data/reading_repository.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../settlements/data/settlement_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../data/tenant_repository.dart';

enum _EntryKind { reading, recharge, payment }

/// Tenant self-service: their own sub-meter reading, their own recharge, and a
/// manual payment/reimbursement to another tenant — all into the same ledger
/// the landlord's bills are computed from.
class TenantSelfEntryScreen extends ConsumerStatefulWidget {
  const TenantSelfEntryScreen({super.key});

  @override
  ConsumerState<TenantSelfEntryScreen> createState() =>
      _TenantSelfEntryScreenState();
}

class _TenantSelfEntryScreenState extends ConsumerState<TenantSelfEntryScreen> {
  _EntryKind _kind = _EntryKind.reading;
  final _value = TextEditingController();
  DateTime _date = DateTime.now();
  bool _busy = false;
  bool _iPaid = true;
  int? _otherTenantId;

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(DateTime.now().year - 2),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final amount = double.tryParse(_value.text.trim());
    if (amount == null || amount <= 0) return;
    final identity = ref.read(tenantIdentityProvider);
    final tenants = ref.read(tenantListProvider).value ?? const [];
    final me = (identity.id == null
            ? tenants.where((t) => t.name == identity.name)
            : tenants.where((t) => t.id == identity.id))
        .cast<Tenant>()
        .firstOrNull;
    final meter = await ref.read(currentMainMeterProvider.future);
    if (me == null || meter == null) return;

    setState(() => _busy = true);
    try {
      switch (_kind) {
        case _EntryKind.reading:
          final readings = ref.read(readingListProvider).value ?? const [];
          final last = readings
              .where((r) => r.tenantId == me.id)
              .map((r) => r.readingValue)
              .cast<double>()
              .toList()
            ..sort();
          if (last.isNotEmpty && amount <= last.last) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l.tenantReadingTooLow)),
              );
            }
            return;
          }
          await ref.read(readingRepositoryProvider).addTenantReading(
                tenantId: me.id,
                date: _date,
                readingValue: amount,
              );
        case _EntryKind.recharge:
          await ref.read(rechargeRepositoryProvider).create(
                meter.id,
                (
                  date: _date,
                  amount: amount,
                  energyCost: 0,
                  demandCharge: 0,
                  meterRent: 0,
                  vat: 0,
                  rebate: 0,
                  agentFee: 0,
                  otherExpenses: 0,
                  paidBy: identity.name,
                  paidByTenantId: me.id,
                  tokenNumber: null,
                  notes: null,
                  receiptPath: null,
                ),
              );
        case _EntryKind.payment:
          if (_otherTenantId == null) return;
          await ref.read(settlementRepositoryProvider).create(
                meter.id,
                (
                  date: _date,
                  fromTenantId: _iPaid ? me.id : _otherTenantId!,
                  toTenantId: _iPaid ? _otherTenantId! : me.id,
                  amount: amount,
                  notes: l.tenantMarkPayment,
                ),
              );
      }
      HapticFeedback.mediumImpact();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.tenantEntrySaved)));
        Navigator.of(context).pop(true);
      }
    } on FinalizedPeriodException {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.periodLockedMessage)));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final identity = ref.watch(tenantIdentityProvider);
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final others = tenants.where((t) => t.name != identity.name).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l.tenantSelfEntry)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SegmentedButton<_EntryKind>(
            segments: [
              ButtonSegment(
                  value: _EntryKind.reading,
                  label: Text(l.tenantAddReading),
                  icon: const Icon(Icons.speed_outlined)),
              ButtonSegment(
                  value: _EntryKind.recharge,
                  label: Text(l.tenantAddRecharge),
                  icon: const Icon(Icons.bolt_outlined)),
              ButtonSegment(
                  value: _EntryKind.payment,
                  label: Text(l.tenantMarkPayment),
                  icon: const Icon(Icons.payments_outlined)),
            ],
            selected: {_kind},
            onSelectionChanged: (s) => setState(() => _kind = s.first),
          ),
          const SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today_outlined),
            title: Text(Formatters.date(_date)),
            trailing: Text(l.actionEdit),
            onTap: _pickDate,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _value,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: _kind == _EntryKind.reading
                  ? l.tenantReadingValue
                  : l.tenantAmount,
              border: const OutlineInputBorder(),
            ),
          ),
          if (_kind == _EntryKind.payment) ...[
            const SizedBox(height: 16),
            SwitchListTile(
              title: Text(_iPaid ? l.tenantPaidTo : l.tenantReceivedFrom),
              value: _iPaid,
              onChanged: (v) => setState(() => _iPaid = v),
            ),
            DropdownButtonFormField<int>(
              initialValue: _otherTenantId,
              decoration:
                  InputDecoration(labelText: l.tenantSelectTenant),
              items: [
                for (final t in others)
                  DropdownMenuItem(value: t.id, child: Text(t.name)),
              ],
              onChanged: (v) => setState(() => _otherTenantId = v),
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _busy ? null : _save,
            child: _busy
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l.tenantSaveEntry),
          ),
          if (_kind == _EntryKind.recharge)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(l.tenantNoSubMeter,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ),
        ],
      ),
    );
  }
}
