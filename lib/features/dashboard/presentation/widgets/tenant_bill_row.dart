// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// A colorful tenant row: palette avatar, usage-share bar, bill + balance.
class _TenantBillRow extends StatelessWidget {
  const _TenantBillRow({
    required this.bill,
    required this.color,
    required this.usageFraction,
    required this.money,
  });

  final TenantBill bill;
  final Color color;
  final double usageFraction;
  final String Function(num) money;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final initial = bill.tenantName.trim().isEmpty
        ? '?'
        : bill.tenantName.trim()[0].toUpperCase();

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.18),
                  foregroundColor: color,
                  child: Text(initial,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bill.tenantName,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text(
                        '${Formatters.units(bill.billedUnits)} kWh • '
                        '${l.effectiveRateLabel} '
                        '${l.effectiveRateValue(money(bill.effectiveRate))}'
                        '${bill.billingMode == 'fixed' ? ' • ${l.tenantModeFixed}' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(money(bill.totalBill),
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(
                      '${bill.isCredit ? l.dashInCredit : l.dashDue}'
                      ' ${money(bill.balance.abs())}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                            bill.isCredit ? AppColors.credit : AppColors.due,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Usage share of the whole meter, animated.
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: usageFraction.clamp(0.0, 1.0)),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, v, _) => LinearProgressIndicator(
                  value: v,
                  minHeight: 7,
                  color: color,
                  backgroundColor: color.withValues(alpha: 0.12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
