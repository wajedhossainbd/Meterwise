import 'package:flutter/material.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:meterwise/features/billing/application/invoice_html.dart';
import 'package:meterwise/features/billing/application/invoice_pdf.dart';
import 'package:meterwise/features/billing/domain/models/billing_result.dart';
import 'package:meterwise/l10n/app_localizations.dart';

void main() {
  const bill = TenantBill(
    tenantId: 1,
    tenantName: 'নোমান', // Bangla user input must survive intact
    previousReading: 1000,
    currentReading: 1204,
    ownUnits: 204,
    commonUnits: 0,
    billedUnits: 204,
    slabBreakdown: [
      SlabAllocation(fromUnit: 0, toUnit: 75, rate: 5.26, units: 37, amount: 194.62),
      SlabAllocation(fromUnit: 76, toUnit: 200, rate: 8.5, units: 63, amount: 535.5),
      SlabAllocation(fromUnit: 201, toUnit: null, rate: 9.1, units: 104, amount: 946.4),
    ],
    energyCost: 1676.52,
    demandCharge: 42,
    meterRent: 20,
    vat: 88.926,
    rebate: 8.8926,
    totalBill: 1858.5534,
    rechargePaid: 2020,
    rechargeFeesPaid: 20,
    expenseShare: 40,
  );

  InvoiceMeta meta({bool finalized = true}) => InvoiceMeta(
        propertyName: 'রহমান ভিলা',
        propertyAddress: 'ঢাকা',
        tenantPhone: '01700000000',
        currency: 'BDT',
        finalized: finalized,
        finalizedAt: finalized ? DateTime(2026, 7, 1) : null,
        tariffVersionLabel: 'DPDC Jun 2026',
        billingMethodLabel: 'শেয়ারড স্ল্যাব',
        providerName: 'DPDC',
      );

  test('Bengali invoice HTML carries Bangla labels and user input intact', () {
    final l = lookupAppLocalizations(const Locale('bn'));
    final html = InvoiceHtml.build(
      bill: bill,
      monthLabel: 'জুন ২০২৬',
      meta: meta(),
      l: l,
    );

    expect(html, contains('নোমান')); // tenant name
    expect(html, contains('রহমান ভিলা')); // property
    expect(html, contains(l.invoiceCharges)); // bn label from ARB
    expect(html, contains(l.invoiceCarryForward)); // in credit → carry forward
    expect(html, contains(l.invoiceTitle)); // localized invoice title
    expect(html, contains(l.invoiceBilledTo)); // localized section captions
    expect(html, contains(l.invoiceFooter));
    expect(html, isNot(contains('Electricity Invoice'))); // no English title
    expect(html, contains('Noto Sans Bengali')); // shaping-capable font stack
    expect(html, contains('204')); // figures present
    expect(html, isNot(contains('DRAFT —'))); // finalized: no draft banner
  });

  test('draft banner + HTML escaping of user input', () {
    final l = lookupAppLocalizations(const Locale('en'));
    final html = InvoiceHtml.build(
      bill: bill,
      monthLabel: 'June 2026',
      meta: InvoiceMeta(
        propertyName: 'A<B> & "C"', // hostile input must be escaped
        currency: 'BDT',
        finalized: false,
        billingMethodLabel: 'Shared slab',
      ),
      l: l,
    );
    expect(html, contains('DRAFT —'));
    expect(html, contains('A&lt;B&gt; &amp; &quot;C&quot;'));
    expect(html, isNot(contains('A<B>')));
  });
}
