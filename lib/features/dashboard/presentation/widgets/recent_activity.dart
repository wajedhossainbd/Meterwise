// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

class _RecentActivity extends ConsumerWidget {
  const _RecentActivity();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(readingSessionsProvider);
    final recharges = ref.watch(rechargeListProvider).value ?? const [];
    final currency = ref.watch(currencyCodeProvider);

    final lastReading = sessions.isEmpty ? null : sessions.first;
    final lastRecharge = recharges.isEmpty ? null : recharges.first;
    final l = AppLocalizations.of(context);

    return SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.dashRecentActivity,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.speed_outlined),
              title: Text(l.dashLastReading),
              subtitle: Text(
                lastReading == null
                    ? l.dashNone
                    : '${Formatters.date(lastReading.date)} • '
                        '${lastReading.mainReading == null ? '' : '${Formatters.units(lastReading.mainReading!)} kWh'}',
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.bolt_outlined),
              title: Text(l.dashLastRecharge),
              subtitle: Text(
                lastRecharge == null
                    ? l.dashNone
                    : '${Formatters.date(lastRecharge.rechargeDate)} • '
                        '${Formatters.money(lastRecharge.amount, currencyCode: currency)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
