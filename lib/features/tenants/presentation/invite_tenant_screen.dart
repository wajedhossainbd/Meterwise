import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/data/settings_repository.dart';
import '../data/tenant_repository.dart';

/// Landlord-side invite: shows the meter code and its QR, and approves a join
/// request. On a real deployment the QR also carries the Drive folder link;
/// here it carries the code, which is enough to drive the local prototype.
class InviteTenantScreen extends ConsumerWidget {
  const InviteTenantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final codeAsync = ref.watch(meterCodeProvider);
    final settings = ref.watch(appSettingsProvider).value;
    final tenants = ref.watch(tenantListProvider).value ?? const [];

    return Scaffold(
      appBar: AppBar(title: Text(l.tenantInviteTitle)),
      body: codeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l.commonSomethingWrong)),
        data: (code) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: QrImageView(
                        data: code,
                        version: QrVersions.auto,
                        size: 200,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(l.tenantMeterCode,
                        style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    SelectableText(
                      code,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(l.tenantInviteHint,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: l.tenantJoinRequest,
              child: settings?.joinedMeterCode == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(l.tenantInviteHint,
                          style: theme.textTheme.bodyMedium),
                    )
                  : ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.person_add_alt_1_outlined),
                      title: Text(settings?.tenantName ?? '—'),
                      subtitle: Text(settings?.tenantApproved == true
                          ? l.tenantJoined
                          : l.tenantJoinRequest),
                      trailing: settings?.tenantApproved == true
                          ? const Icon(Icons.check_circle,
                              color: Colors.green)
                          : FilledButton(
                              onPressed: () => ref
                                  .read(settingsRepositoryProvider)
                                  .approveTenant(),
                              child: Text(l.tenantApprove),
                            ),
                    ),
            ),
            if (tenants.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l.tenantChooseName,
                    style: theme.textTheme.bodySmall),
              ),
          ],
        ),
      ),
    );
  }
}
