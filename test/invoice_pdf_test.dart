import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/features/billing/application/invoice_pdf.dart';
import 'package:meterwise/features/billing/domain/models/billing_result.dart';
import 'package:meterwise/l10n/app_localizations.dart';

/// Renders the redesigned invoice end-to-end (fonts + layout) so layout
/// regressions fail in CI instead of on a phone.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const bill = TenantBill(
    tenantId: 1,
    tenantName: 'Noman',
    previousReading: 1000,
    currentReading: 1377,
    ownUnits: 377,
    commonUnits: 0,
    billedUnits: 377,
    slabBreakdown: [
      SlabAllocation(fromUnit: 0, toUnit: 75, rate: 5.26, units: 37, amount: 194.62),
      SlabAllocation(fromUnit: 76, toUnit: 200, rate: 8.5, units: 63, amount: 535.5),
      SlabAllocation(fromUnit: 201, toUnit: 300, rate: 9.1, units: 50, amount: 455),
      SlabAllocation(fromUnit: 301, toUnit: 400, rate: 9.62, units: 50, amount: 481),
      SlabAllocation(fromUnit: 401, toUnit: 600, rate: 15.01, units: 100, amount: 1501),
      SlabAllocation(fromUnit: 601, toUnit: null, rate: 17.35, units: 77, amount: 1335.95),
    ],
    energyCost: 4503.07,
    demandCharge: 42,
    meterRent: 20,
    vat: 230.2535,
    rebate: 23.02535,
    totalBill: 4812.29815,
    rechargePaid: 2040,
    rechargeFeesPaid: 40,
    expenseShare: 40,
    previousBalance: 150,
  );

  // The invoice always uses English labels: the Dart PDF engine has no
  // complex-script shaping, so Bengali would render with broken conjuncts.
  for (final localeCode in ['en']) {
    test('invoice PDF renders ($localeCode, draft + finalized)', () async {
      final l = lookupAppLocalizations(Locale(localeCode));
      for (final finalized in [true, false]) {
        final bytes = await InvoicePdf.build(
          bill: bill,
          monthLabel: 'June 2026',
          meta: InvoiceMeta(
            propertyName: 'Rahman Villa',
            propertyAddress: 'Dhaka',
            tenantPhone: '01700000000',
            currency: 'BDT',
            finalized: finalized,
            finalizedAt: finalized ? DateTime(2026, 7, 1) : null,
            tariffVersionLabel: 'DPDC Jun 2026',
            billingMethodLabel: 'Shared slab',
            providerName: 'DPDC',
          ),
          l: l,
        );
        expect(bytes.length, greaterThan(5000)); // real document with fonts
      }
    });
  }
}
