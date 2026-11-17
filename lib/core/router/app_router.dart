import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/database/app_database.dart';
import '../../features/billing/presentation/bills_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/main_meter/presentation/main_meter_edit_screen.dart';
import '../../features/properties/presentation/property_edit_screen.dart';
import '../../features/readings/presentation/add_reading_screen.dart';
import '../../features/readings/presentation/readings_screen.dart';
import '../../features/recharge/presentation/recharge_edit_screen.dart';
import '../../features/recharge/presentation/recharge_screen.dart';
import '../../features/settings/presentation/backup_screen.dart';
import '../../features/settings/presentation/billing_settings_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settlements/presentation/settlements_screen.dart';
import '../../features/tariff/presentation/tariff_manager_screen.dart';
import '../../features/tenants/presentation/invite_tenant_screen.dart';
import '../../features/tenants/presentation/join_meter_screen.dart';
import '../../features/tenants/presentation/tenant_home_screen.dart';
import '../../features/tenants/presentation/tenant_edit_screen.dart';
import '../../features/tenants/presentation/tenants_screen.dart';
import '../widgets/app_shell.dart';
import 'app_routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// A page placed on the root navigator (covers the bottom navigation), used for
/// data-entry forms and detail screens.
GoRoute _fullScreen({
  required String path,
  required String name,
  required Widget Function(BuildContext, GoRouterState) builder,
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    path: path,
    name: name,
    parentNavigatorKey: _rootNavigatorKey,
    builder: builder,
    routes: routes,
  );
}

/// The application's GoRouter configuration.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.dashboard,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        // 1. Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              name: AppRoutes.dashboardName,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        // 2. Readings
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.readings,
              name: AppRoutes.readingsName,
              builder: (context, state) => const ReadingsScreen(),
              routes: [
                _fullScreen(
                  path: AppRoutes.addReading,
                  name: AppRoutes.addReadingName,
                  builder: (context, state) => const AddReadingScreen(),
                ),
              ],
            ),
          ],
        ),
        // 3. Recharge
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.recharge,
              name: AppRoutes.rechargeName,
              builder: (context, state) => const RechargeScreen(),
              routes: [
                _fullScreen(
                  path: AppRoutes.addRecharge,
                  name: AppRoutes.addRechargeName,
                  builder: (context, state) => const RechargeEditScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.editRecharge,
                  name: AppRoutes.editRechargeName,
                  builder: (context, state) =>
                      RechargeEditScreen(recharge: state.extra as Recharge?),
                ),
              ],
            ),
          ],
        ),
        // 4. Bills
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.bills,
              name: AppRoutes.billsName,
              builder: (context, state) => const BillsScreen(),
            ),
          ],
        ),
        // 5. Settings (+ setup sub-pages)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              name: AppRoutes.settingsName,
              builder: (context, state) => const SettingsScreen(),
              routes: [
                _fullScreen(
                  path: AppRoutes.property,
                  name: AppRoutes.propertyName,
                  builder: (context, state) => const PropertyEditScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.mainMeter,
                  name: AppRoutes.mainMeterName,
                  builder: (context, state) => const MainMeterEditScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.tariff,
                  name: AppRoutes.tariffName,
                  builder: (context, state) => const TariffManagerScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.billing,
                  name: AppRoutes.billingName,
                  builder: (context, state) => const BillingSettingsScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.backup,
                  name: AppRoutes.backupName,
                  builder: (context, state) => const BackupScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.settlements,
                  name: AppRoutes.settlementsName,
                  builder: (context, state) => const SettlementsScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.inviteTenant,
                  name: AppRoutes.inviteTenantName,
                  builder: (context, state) => const InviteTenantScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.joinMeter,
                  name: AppRoutes.joinMeterName,
                  builder: (context, state) => const JoinMeterScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.tenantHome,
                  name: AppRoutes.tenantHomeName,
                  builder: (context, state) => const TenantHomeScreen(),
                ),
                _fullScreen(
                  path: AppRoutes.tenants,
                  name: AppRoutes.tenantsName,
                  builder: (context, state) => const TenantsScreen(),
                  routes: [
                    _fullScreen(
                      path: AppRoutes.addTenant,
                      name: AppRoutes.addTenantName,
                      builder: (context, state) => const TenantEditScreen(),
                    ),
                    _fullScreen(
                      path: AppRoutes.editTenant,
                      name: AppRoutes.editTenantName,
                      builder: (context, state) =>
                          TenantEditScreen(tenant: state.extra as Tenant?),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
