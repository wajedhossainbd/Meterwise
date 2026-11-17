import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../settings/data/settings_repository.dart';
import '../../tenants/presentation/tenant_home_screen.dart';
import 'dashboard_screen.dart';

/// Makes the first tab the tenant's own home once they have joined a meter,
/// so they never land on the landlord's dashboard by accident.
class DashboardGate extends ConsumerWidget {
  const DashboardGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(appRoleProvider);
    return role == 'tenant' ? const TenantHomeScreen() : const DashboardScreen();
  }
}
