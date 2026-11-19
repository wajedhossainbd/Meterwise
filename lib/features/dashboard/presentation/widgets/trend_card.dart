// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

class _TrendCard extends ConsumerStatefulWidget {
  const _TrendCard();

  @override
  ConsumerState<_TrendCard> createState() => _TrendCardState();
}

enum _Series { usage, recharge, bill, rate }

class _TrendCardState extends ConsumerState<_TrendCard> {
  _Series _series = _Series.usage;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(monthlyHistoryProvider());
    final currency = ref.watch(currencyCodeProvider);
    final l = AppLocalizations.of(context);

    return SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.dashMonthlyOverview,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            // Horizontally scrollable so labels never wrap on narrow screens
            // (especially with the longer Bengali labels).
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<_Series>(
                style: SegmentedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w600),
                  visualDensity: VisualDensity.compact,
                ),
                segments: [
                  ButtonSegment(
                      value: _Series.usage, label: Text(l.dashUsage)),
                  ButtonSegment(
                      value: _Series.recharge, label: Text(l.dashRecharge)),
                  ButtonSegment(value: _Series.bill, label: Text(l.dashBill)),
                  ButtonSegment(
                      value: _Series.rate, label: Text(l.effectiveRateLabel)),
                ],
                selected: {_series},
                showSelectedIcon: false,
                onSelectionChanged: (s) => setState(() => _series = s.first),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: history.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('$e')),
                data: (months) {
                  if (months.every((m) => _value(m) == 0)) {
                    return Center(
                      child: Text(l.dashNoData,
                          style: Theme.of(context).textTheme.bodyMedium),
                    );
                  }
                  return MiniBarChart(
                    values: [for (final m in months) _value(m)],
                    labels: [
                      for (final m in months) Formatters.monthShort(m.month)
                    ],
                    color: _color,
                    tooltipFormatter: (v) => switch (_series) {
                          _Series.usage => '${Formatters.units(v)} kWh',
                          _Series.rate => l.chartRateValue(
                              Formatters.money(v, currencyCode: currency)),
                          _ => Formatters.money(v, currencyCode: currency),
                        },
                  );
                },
              ),
            ),
            const SizedBox(height: 4),
            Text(
              switch (_series) {
                _Series.usage => l.chartUnitsPerMonth,
                _Series.rate => l.chartRateCaption,
                _ => l.chartAmountPerMonth(
                    Formatters.currencySymbol(currency).trim()),
              },
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  double _value(MonthlySummary m) => switch (_series) {
        _Series.usage => m.units,
        _Series.recharge => m.recharge,
        _Series.bill => m.billed,
        _Series.rate => m.rate,
      };

  Color get _color => switch (_series) {
        _Series.usage => AppColors.lightBlue,
        _Series.recharge => AppColors.powerYellow,
        _Series.bill => AppColors.seed,
        _Series.rate => AppColors.accentOrange,
      };
}
