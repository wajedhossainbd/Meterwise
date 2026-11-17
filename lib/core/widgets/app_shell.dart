import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';

/// Persistent navigation chrome wrapping the five top-level destinations.
///
/// Driven by GoRouter's [StatefulNavigationShell] so each branch keeps its own
/// navigation stack and state across tab switches. Uses a [NavigationBar] on
/// compact widths and a [NavigationRail] on wider screens (tablets / landscape)
/// to satisfy the adaptive-layout requirement.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const List<_Destination> _destinations = [
    _Destination(Icons.dashboard_outlined, Icons.dashboard),
    _Destination(Icons.speed_outlined, Icons.speed),
    _Destination(Icons.bolt_outlined, Icons.bolt),
    _Destination(Icons.receipt_long_outlined, Icons.receipt_long),
    _Destination(Icons.settings_outlined, Icons.settings),
  ];

  void _onTap(int index) {
    // initialLocation: re-tap on the active tab pops to its branch root.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 720;
    final l = AppLocalizations.of(context);
    final labels = [
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
                for (var i = 0; i < _destinations.length; i++)
                  NavigationRailDestination(
                    icon: Icon(_destinations[i].icon),
                    selectedIcon: Icon(_destinations[i].selectedIcon),
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
          for (var i = 0; i < _destinations.length; i++)
            NavigationDestination(
              icon: Icon(_destinations[i].icon),
              selectedIcon: Icon(_destinations[i].selectedIcon),
              label: labels[i],
            ),
        ],
      ),
    );
  }
}

class _Destination {
  const _Destination(this.icon, this.selectedIcon);
  final IconData icon;
  final IconData selectedIcon;
}
