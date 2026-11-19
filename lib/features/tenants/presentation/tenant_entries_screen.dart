import 'package:flutter/material.dart';
import '../../../core/theme/soft_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/utils/formatters.dart';
import '../../properties/data/property_repository.dart';
import '../../../l10n/app_localizations.dart';
import '../../readings/data/reading_repository.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../settlements/data/settlement_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../data/tenant_repository.dart';

/// Everything a tenant has entered themselves, newest first: own sub-meter
/// readings, own recharges, and payments/reimbursements with other tenants.
class TenantEntriesScreen extends ConsumerWidget {
  const TenantEntriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final identity = ref.watch(tenantIdentityProvider);
    final tenants = ref.watch(tenantListProvider).value ?? const [];
    final me = tenants
        .where((t) => t.name == identity.name)
        .cast<Tenant>()
        .firstOrNull;
    final meId = me?.id;
    final readings = ref.watch(readingListProvider).value ?? const [];
    final recharges = ref.watch(rechargeListProvider).value ?? const [];
    final settlements = ref.watch(settlementListProvider).value ?? const [];
    final currency = ref.watch(currencyCodeProvider);

    final entries = <_Entry>[];
    for (final r in readings.where((r) => r.tenantId == meId)) {
      entries.add(_Entry(
        Icons.speed_outlined,
        l.tenantAddReading,
        Formatters.date(r.readingDate),
        Formatters.units(r.readingValue),
        r.readingDate,
      ));
    }
    for (final r in recharges.where((r) => r.paidBy == identity.name)) {
      entries.add(_Entry(
        Icons.bolt_outlined,
        l.tenantAddRecharge,
        Formatters.date(r.rechargeDate),
        Formatters.money(r.amount, currencyCode: currency),
        r.rechargeDate,
      ));
    }
    for (final s in settlements.where(
        (s) => s.fromTenantId == meId || s.toTenantId == meId)) {
      final outgoing = s.fromTenantId == meId;
      final otherName = tenants
          .where((t) => t.id == (outgoing ? s.toTenantId : s.fromTenantId))
          .map((t) => t.name)
          .cast<String>()
          .firstOrNull;
      entries.add(_Entry(
        Icons.swap_horiz,
        outgoing ? l.tenantPaidTo : l.tenantReceivedFrom,
        '${Formatters.date(s.settlementDate)} • ${otherName ?? ''}',
        Formatters.money(s.amount, currencyCode: currency),
        s.settlementDate,
      ));
    }
    entries.sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(title: Text(l.tenantSelfEntry)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoutes.tenantEntryName),
        icon: const Icon(Icons.add),
        label: Text(l.tenantSaveEntry),
      ),
      body: entries.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(l.tenantSelfEntry,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
              itemCount: entries.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final e = entries[i];
                return SoftCard(
                  child: ListTile(
                    leading: Icon(e.icon, color: theme.colorScheme.primary),
                    title: Text(e.title),
                    subtitle: Text(e.subtitle),
                    trailing: Text(e.value,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                );
              },
            ),
    );
  }
}

class _Entry {
  const _Entry(this.icon, this.title, this.subtitle, this.value, this.date);
  final IconData icon;
  final String title;
  final String subtitle;
  final String value;
  final DateTime date;
}
