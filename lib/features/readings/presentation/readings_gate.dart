import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/data/settings_repository.dart';
import '../../tenants/presentation/tenant_entries_screen.dart';
import 'readings_screen.dart';

/// The second tab is the tenant's own entry history once joined; landlords keep
/// the full readings screen.
class ReadingsGate extends ConsumerWidget {
  const ReadingsGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(appRoleProvider);
    return role == 'tenant'
        ? const TenantEntriesScreen()
        : const ReadingsScreen();
  }
}
