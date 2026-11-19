// Extracted dashboard section; shares the library imports.
part of '../dashboard_screen.dart';

/// Owner-facing monthly summary. Its content adapts to the calculation mode:
/// Shared-Slab shows the Owner Benefit/Loss; the reconciled modes show that
/// tenant collections exactly match the meter bill. NEVER shown on invoices.
class _OwnerSummaryCard extends StatelessWidget {
  const _OwnerSummaryCard({required this.bill, required this.currency});

  final MonthlyBill bill;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    String money(num v) => Formatters.money(v, currencyCode: currency);
    final isSharedSlab = bill.calcMode == 'sharedSlab';
    final benefit = bill.ownerBenefit;
    final isLoss = benefit < 0;

    Widget row(String label, String value, {Color? color, bool bold = false}) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              Text(value,
                  style: (bold
                          ? theme.textTheme.titleMedium
                          : theme.textTheme.bodyMedium)
                      ?.copyWith(
                          fontWeight: FontWeight.w600, color: color)),
            ],
          ),
        );

    return SoftCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.account_balance_outlined,
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(l.ownerSummaryTitle,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 10),
            row(l.ownerMainBill, money(bill.buildingBill)),
            if (bill.calcMode == 'fixedRate') ...[
              row(l.ownerCollectedFixed, money(bill.fixedCollections)),
              row(l.ownerRemainingShared, money(bill.sharedCollections)),
            ],
            row(l.ownerTenantTotal, money(bill.totalBilled)),
            const Divider(height: 18),
            if (isSharedSlab)
              row(
                isLoss ? l.ownerLoss : l.ownerBenefit,
                money(benefit.abs()),
                color: isLoss ? AppColors.due : AppColors.credit,
                bold: true,
              )
            else
              row(l.ownerDifference, money(0), bold: true),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _miniStat(theme, l.ownerCollectionPct,
                    '${bill.collectionPercent.toStringAsFixed(0)}%'),
                _miniStat(theme, l.ownerAvgCost, money(bill.averageUnitCost)),
                _miniStat(
                    theme, l.ownerAvgSell, money(bill.averageSellingRate)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(ThemeData theme, String label, String value) => SoftInset(
        radius: AppTokens.radiusChip,
        padding: const EdgeInsets.symmetric(horizontal: AppTokens.s3, vertical: AppTokens.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
            Text(value,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
