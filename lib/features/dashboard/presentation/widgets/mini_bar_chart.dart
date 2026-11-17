import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A compact, interactive monthly-trend chart: gradient bars on soft track
/// backgrounds, tap/hold tooltips with the exact value, and smooth animation
/// when the data or series changes.
class MiniBarChart extends StatelessWidget {
  const MiniBarChart({
    required this.values,
    required this.labels,
    required this.color,
    this.tooltipFormatter,
    super.key,
  });

  final List<double> values;
  final List<String> labels;
  final Color color;

  /// Formats the tooltip value (defaults to 1-decimal number).
  final String Function(double value)? tooltipFormatter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxVal = values.isEmpty ? 0.0 : values.reduce((a, b) => a > b ? a : b);
    final maxY = maxVal <= 0 ? 1.0 : maxVal * 1.25;
    final format = tooltipFormatter ?? (v) => v.toStringAsFixed(1);

    return BarChart(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => theme.colorScheme.inverseSurface,
            tooltipBorderRadius: BorderRadius.circular(10),
            fitInsideHorizontally: true,
            fitInsideVertically: true,
            getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                BarTooltipItem(
              '${labels[group.x]}\n${format(rod.toY)}',
              TextStyle(
                color: theme.colorScheme.onInverseSurface,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= labels.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(labels[i], style: theme.textTheme.labelSmall),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < values.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i],
                  width: 18,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(7),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [color.withValues(alpha: 0.65), color],
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxY,
                    color: color.withValues(alpha: 0.08),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
