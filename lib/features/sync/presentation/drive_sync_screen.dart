import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../readings/data/reading_repository.dart';
import '../../recharge/data/recharge_repository.dart';
import '../../settings/data/settings_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../data/sync_providers.dart';

/// Google Drive transport UI. Landlord backs up; tenant pulls the packet.
class DriveSyncScreen extends ConsumerStatefulWidget {
  const DriveSyncScreen({super.key});

  @override
  ConsumerState<DriveSyncScreen> createState() => _DriveSyncScreenState();
}

class _DriveSyncScreenState extends ConsumerState<DriveSyncScreen> {
  String? _email;
  String? _message;
  bool _busy = false;

  Future<void> _signIn() async {
    setState(() => _busy = true);
    try {
      final email = await ref.read(driveSyncProvider).signInEmail();
      if (mounted) setState(() => _email = email);
    } catch (e) {
      if (mounted) setState(() => _message = 'Sign-in: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _backup() async {
    final l = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final code = await ref.read(meterCodeProvider.future);
      final property = await ref.read(propertyRepositoryProvider).getFirst();
      final providerName =
          await ref.read(mainMeterRepositoryProvider).providerName();
      final tenants = await ref.read(tenantRepositoryProvider).getAll();
      final readings = await ref.read(readingRepositoryProvider).getAll();
      final recharges = await ref.read(rechargeRepositoryProvider).getAll();

      final packet = ref.read(driveSyncProvider).buildPacket(
            meterCode: code,
            propertyName: property?.name ?? 'MeterWise',
            propertyAddress: property?.address,
            currency: property?.currencyCode ?? 'BDT',
            providerName: providerName ?? 'DPDC',
            tenants: tenants,
            readings: readings,
            recharges: recharges,
          );
      await ref
          .read(driveSyncProvider)
          .uploadPacket(meterCode: code, packet: packet);
      if (mounted) setState(() => _message = l.driveBackupDone);
    } catch (e) {
      if (mounted) setState(() => _message = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _sync() async {
    final l = AppLocalizations.of(context);
    setState(() => _busy = true);
    try {
      final identity = ref.read(tenantIdentityProvider);
      String code = identity.code ?? '';
      if (code.isEmpty) code = await ref.read(meterCodeProvider.future);
      code = code.trim();
      final packet = await ref.read(driveSyncProvider).downloadPacket(code);
      if (packet == null) {
        if (mounted) setState(() => _message = l.driveNoPacket);
        return;
      }
      final count = await ref.read(packetImportProvider).import(packet);
      if (mounted) {
        setState(() => _message = l.driveSyncDone(count));
      }
    } catch (e) {
      if (mounted) setState(() => _message = '$e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isTenant = ref.watch(appRoleProvider) == 'tenant';

    return Scaffold(
      appBar: AppBar(title: Text(l.driveSyncTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.driveSyncTitle,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(
                    _email == null
                        ? l.driveSignIn
                        : '${l.driveSignedInAs}: $_email',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  if (_email == null)
                    FilledButton.icon(
                      onPressed: _busy ? null : _signIn,
                      icon: const Icon(Icons.login),
                      label: Text(l.driveSignIn),
                    )
                  else ...[
                    FilledButton.icon(
                      onPressed: _busy ? null : (isTenant ? _sync : _backup),
                      icon: Icon(isTenant ? Icons.sync : Icons.cloud_upload),
                      label: Text(isTenant ? l.driveSyncNow : l.driveBackup),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _busy
                          ? null
                          : () async {
                              await ref.read(driveSyncProvider).signOut();
                              if (mounted) setState(() => _email = null);
                            },
                      icon: const Icon(Icons.logout),
                      label: Text(l.driveSignOut),
                    ),
                  ],
                  if (_busy)
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: LinearProgressIndicator(),
                    ),
                  if (_message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(_message!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary)),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
