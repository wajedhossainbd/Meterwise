import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../../features/settings/data/settings_repository.dart';
import '../../l10n/app_localizations.dart';

/// Persistent navigation chrome wrapping the top-level destinations.
///
/// Driven by GoRouter's [StatefulNavigationShell] so each branch keeps its own
/// navigation stack and state across tab switches. Uses a [NavigationBar] on
/// compact widths and a [NavigationRail] on wider screens (tablets / landscape).
/// Tenants get a smaller, scoped set of destinations — no landlord controls.
class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const List<_Destination> _landlordDestinations = [
    _Destination(Icons.dashboard_outlined, Icons.dashboard, 0, AppColors.accentInk),
    _Destination(Icons.speed_outlined, Icons.speed, 1, AppColors.cyan),
    _Destination(Icons.bolt_outlined, Icons.bolt, 2, AppColors.powerYellow),
    _Destination(Icons.receipt_long_outlined, Icons.receipt_long, 3, AppColors.teal),
    _Destination(Icons.settings_outlined, Icons.settings, 4, AppColors.violet),
  ];

  static const List<_Destination> _tenantDestinations = [
    _Destination(Icons.home_outlined, Icons.home, 0, AppColors.accentInk),
    _Destination(Icons.history_outlined, Icons.history, 1, AppColors.cyan),
  ];

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWide = MediaQuery.sizeOf(context).width >= 720;
    final l = AppLocalizations.of(context);
    final isTenant = ref.watch(appRoleProvider) == 'tenant';
    final destinations = isTenant ? _tenantDestinations : _landlordDestinations;
    final labels = isTenant
        ? [l.tenantHomeTitle, l.tenantSelfEntry]
        : [
            l.navDashboard,
            l.navReadings,
            l.navRecharge,
            l.navBills,
            l.navSettings,
          ];

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _onTap,
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (var i = 0; i < destinations.length; i++)
                  NavigationRailDestination(
                    icon: Icon(destinations[i].icon, color: destinations[i].color),
                    selectedIcon: Icon(destinations[i].selectedIcon,
                        color: destinations[i].color),
                    label: Text(labels[i]),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: [
          for (var i = 0; i < destinations.length; i++)
            NavigationDestination(
              icon: Icon(destinations[i].icon, color: destinations[i].color),
              selectedIcon: Icon(destinations[i].selectedIcon,
                  color: destinations[i].color),
              label: labels[i],
            ),
        ],
      ),
    );
  }
}

class _Destination {
  const _Destination(this.icon, this.selectedIcon, this.index, this.color);
  final IconData icon;
  final IconData selectedIcon;
  final int index;
  final Color color;
}
