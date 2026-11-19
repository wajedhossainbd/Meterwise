// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

class _SetupChecklist extends StatelessWidget {
  const _SetupChecklist({
    required this.hasProperty,
    required this.hasMeter,
    required this.tenantCount,
  });

  final bool hasProperty;
  final bool hasMeter;
  final int tenantCount;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(l.welcomeTitle(AppConstants.appName),
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(l.setupSubtitle,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        _step(context, l.stepProperty, hasProperty,
            '${AppRoutes.settings}/${AppRoutes.property}'),
        _step(context, l.stepMeter, hasMeter,
            '${AppRoutes.settings}/${AppRoutes.mainMeter}'),
        _step(context, l.stepTenants, tenantCount > 0,
            '${AppRoutes.settings}/${AppRoutes.tenants}'),
      ],
    );
  }

  Widget _step(BuildContext context, String title, bool done, String path) {
    return SoftCard(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          done ? Icons.check_circle : Icons.radio_button_unchecked,
          color: done ? AppColors.credit : null,
        ),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.go(path),
      ),
    );
  }
}
