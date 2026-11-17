/// Centralized route paths and names.
///
/// Using named constants (rather than string literals scattered across the app)
/// gives us compile-time safety for navigation and a single place to evolve the
/// URL structure as features are added.
class AppRoutes {
  const AppRoutes._();

  // ---- Bottom-navigation branches ----
  static const String dashboard = '/dashboard';
  static const String readings = '/readings';
  static const String recharge = '/recharge';
  static const String bills = '/bills';
  static const String settings = '/settings';

  static const String dashboardName = 'dashboard';
  static const String readingsName = 'readings';
  static const String rechargeName = 'recharge';
  static const String billsName = 'bills';
  static const String settingsName = 'settings';

  // ---- Readings ----
  static const String addReading = 'add'; // -> /readings/add
  static const String addReadingName = 'addReading';

  // ---- Recharge ----
  static const String addRecharge = 'add'; // -> /recharge/add
  static const String addRechargeName = 'addRecharge';
  static const String editRecharge = 'edit'; // -> /recharge/edit
  static const String editRechargeName = 'editRecharge';

  // ---- Settings sub-pages ----
  static const String property = 'property';
  static const String propertyName = 'property';
  static const String mainMeter = 'main-meter';
  static const String mainMeterName = 'mainMeter';
  static const String tenants = 'tenants';
  static const String tenantsName = 'tenants';
  static const String addTenant = 'add'; // -> /settings/tenants/add
  static const String addTenantName = 'addTenant';
  static const String editTenant = 'edit'; // -> /settings/tenants/edit
  static const String editTenantName = 'editTenant';
  static const String tariff = 'tariff';
  static const String tariffName = 'tariff';
  static const String billing = 'billing';
  static const String billingName = 'billingSettings';
  static const String backup = 'backup';
  static const String backupName = 'backup';
  static const String settlements = 'settlements';
  static const String settlementsName = 'settlements';
  static const String inviteTenant = 'invite-tenant';
  static const String inviteTenantName = 'inviteTenant';
  static const String joinMeter = 'join-meter';
  static const String joinMeterName = 'joinMeter';
  static const String tenantHome = 'tenant-home';
  static const String tenantHomeName = 'tenantHome';
  static const String tenantEntry = 'tenant-entry';
  static const String tenantEntryName = 'tenantEntry';
}
