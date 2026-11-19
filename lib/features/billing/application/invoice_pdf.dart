import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/models/billing_result.dart';

/// Invoice metadata that makes a generated PDF traceable years later.
class InvoiceMeta {
  const InvoiceMeta({
    required this.propertyName,
    this.propertyAddress,
    this.tenantPhone,
    required this.currency,
    required this.finalized,
    this.finalizedAt,
    this.tariffVersionLabel,
    required this.billingMethodLabel,
    this.providerName,
  });

  final String propertyName;
  final String? propertyAddress;
  final String? tenantPhone;
  final String currency;
  final bool finalized;
  final DateTime? finalizedAt;
  final String? tariffVersionLabel;
  final String billingMethodLabel;
  final String? providerName;
}

/// Builds a print-ready invoice that mirrors the app's "Soft Modern" language:
/// a warm orange gradient hero, clean white/neutral cards and distinct accents.
///
/// Pure with respect to Flutter widgets — plain data in, bytes out — so it can
/// be unit-tested and reused for share / print / save without change.
class InvoicePdf {
  const InvoicePdf._();

  // ---- palette: matches the app's theme ------------------------------------
  static const _orangeLight = PdfColor.fromInt(0xFFFFB85C);
  static const _orange = PdfColor.fromInt(0xFFF78837);
  static const _orangeDeep = PdfColor.fromInt(0xFFE8622E);
  static const _ink = PdfColor.fromInt(0xFF253247);
  static const _muted = PdfColor.fromInt(0xFF5C6B80);
  static const _tintOrange = PdfColor.fromInt(0xFFFFF3E4);
  static const _tintGrey = PdfColor.fromInt(0xFFEDF1F7);
  static const _zebra = PdfColor.fromInt(0xFFF8FAFD);
  static const _line = PdfColor.fromInt(0xFFD8DEEC);
  static const _green = PdfColor.fromInt(0xFF2F8A5E);
  static const _tintGreen = PdfColor.fromInt(0xFFE7F5EE);
  static const _red = PdfColor.fromInt(0xFFC85A48);
  static const _tintRed = PdfColor.fromInt(0xFFFCEDEA);
  static const _amber = PdfColor.fromInt(0xFF8A6D00);
  static const _tintAmber = PdfColor.fromInt(0xFFFFF3CD);

  static pw.LinearGradient get _heroGradient => pw.LinearGradient(
        colors: [_orangeLight, _orange, _orangeDeep],
        begin: pw.Alignment.topLeft,
        end: pw.Alignment.bottomRight,
      );

  // Cached Unicode fonts so currency symbols (৳ € £ $) and Bengali text render.
  static pw.Font? _regular;
  static pw.Font? _bold;
  static pw.Font? _bengali;

  static Future<void> _ensureFonts() async {
    _regular ??=
        pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
    _bold ??=
        pw.Font.ttf(await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'));
    _bengali ??= pw.Font.ttf(
        await rootBundle.load('assets/fonts/NotoSansBengali-Regular.ttf'));
  }

  static Future<Uint8List> build({
    required TenantBill bill,
    required String monthLabel,
    required InvoiceMeta meta,
    required AppLocalizations l,
  }) async {
    await _ensureFonts();

    final doc = pw.Document(
      title: 'MeterWise Invoice',
      theme: pw.ThemeData.withFont(
        base: _regular!,
        bold: _bold!,
        fontFallback: [_bengali!, _regular!],
      ),
    );
    String money(num v) => Formatters.money(v, currencyCode: meta.currency);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _headerBanner(meta, monthLabel),
            if (!meta.finalized) ...[
              pw.SizedBox(height: 10),
              _draftBanner(l),
            ],
            pw.SizedBox(height: 12),
            _metaChips(meta, monthLabel, l),
            pw.SizedBox(height: 12),
            _billedToCard(bill, meta, l, money),
            pw.SizedBox(height: 12),
            _readingsRow(bill, l),
            pw.SizedBox(height: 12),
            _slabTable(bill, l, money),
            pw.SizedBox(height: 12),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(child: _chargesPanel(bill, l, money)),
                pw.SizedBox(width: 12),
                pw.Expanded(child: _paymentPanel(bill, l, money)),
              ],
            ),
            pw.SizedBox(height: 12),
            _totalBanner(bill, l, money),
            pw.Spacer(),
            _signatureRow(l),
            pw.SizedBox(height: 8),
            _footer(),
          ],
        ),
      ),
    );

    return doc.save();
  }

  // ---- sections ------------------------------------------------------------

  static pw.Widget _headerBanner(InvoiceMeta meta, String monthLabel) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: pw.BoxDecoration(
        gradient: _heroGradient,
        borderRadius: pw.BorderRadius.circular(14),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Container(
            width: 40,
            height: 40,
            alignment: pw.Alignment.center,
            decoration: const pw.BoxDecoration(
              color: PdfColors.white,
              shape: pw.BoxShape.circle,
            ),
            child: pw.Text(
              'M',
              style: pw.TextStyle(
                color: _orangeDeep,
                fontWeight: pw.FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          pw.SizedBox(width: 12),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                AppConstants.appName,
                style: pw.TextStyle(
                  color: PdfColors.white,
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Electricity Invoice',
                style: const pw.TextStyle(
                    color: PdfColor.fromInt(0xEEFFFFFF), fontSize: 10),
              ),
            ],
          ),
          pw.Spacer(),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(meta.propertyName,
                  style: pw.TextStyle(
                      color: PdfColors.white,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12)),
              if (meta.propertyAddress != null &&
                  meta.propertyAddress!.isNotEmpty)
                pw.Text(meta.propertyAddress!,
                    style: const pw.TextStyle(
                        color: PdfColor.fromInt(0xCCFFFFFF), fontSize: 9)),
              pw.SizedBox(height: 4),
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: pw.BoxDecoration(
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Text(monthLabel,
                    style: pw.TextStyle(
                        color: _orangeDeep,
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _draftBanner(AppLocalizations l) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      decoration: pw.BoxDecoration(
        color: _tintAmber,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Text(
        l.invoiceDraftNotice,
        style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold, color: _amber, fontSize: 10),
      ),
    );
  }

  static pw.Widget _metaChips(
      InvoiceMeta meta, String monthLabel, AppLocalizations l) {
    pw.Widget chip(String label, String value, {PdfColor? color}) =>
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: pw.BoxDecoration(
            color: _tintGrey,
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.RichText(
            text: pw.TextSpan(
              children: [
                pw.TextSpan(
                    text: '$label  ',
                    style: const pw.TextStyle(fontSize: 8, color: _muted)),
                pw.TextSpan(
                    text: value,
                    style: pw.TextStyle(
                        fontSize: 8.5,
                        fontWeight: pw.FontWeight.bold,
                        color: color ?? _ink)),
              ],
            ),
          ),
        );

    return pw.Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        chip(l.invoiceStatus, meta.finalized ? l.statusFinalized : l.statusDraft,
            color: meta.finalized ? _green : _amber),
        if (meta.providerName != null) chip(l.invoiceProvider, meta.providerName!),
        if (meta.tariffVersionLabel != null)
          chip(l.invoiceTariff, meta.tariffVersionLabel!),
        chip(l.invoiceBillingMode, meta.billingMethodLabel),
        chip(l.invoiceGenerated, Formatters.date(DateTime.now())),
        if (meta.finalizedAt != null)
          chip(l.statusFinalized, Formatters.date(meta.finalizedAt!)),
      ],
    );
  }

  static pw.Widget _billedToCard(TenantBill bill, InvoiceMeta meta,
      AppLocalizations l, String Function(num) money) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _tintOrange,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(l.invoiceBilledTo,
                  style: const pw.TextStyle(fontSize: 8, color: _muted)),
              pw.SizedBox(height: 2),
              pw.Text(bill.tenantName,
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              if (meta.tenantPhone != null && meta.tenantPhone!.isNotEmpty)
                pw.Text(meta.tenantPhone!,
                    style: const pw.TextStyle(fontSize: 9, color: _muted)),
            ],
          ),
          pw.Spacer(),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(l.invoiceEffectiveRate,
                  style: const pw.TextStyle(fontSize: 8, color: _muted)),
              pw.Text(
                bill.billedUnits > 0
                    ? '${money(bill.effectiveRate)} / kWh'
                    : '—',
                style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    color: _orangeDeep),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _readingsRow(TenantBill bill, AppLocalizations l) {
    pw.Widget box(String label, String value) => pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.only(right: 8),
            padding: const pw.EdgeInsets.all(9),
            decoration: pw.BoxDecoration(
              color: _tintGrey,
              borderRadius: pw.BorderRadius.circular(9),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(label,
                    style: const pw.TextStyle(fontSize: 7.5, color: _muted)),
                pw.SizedBox(height: 3),
                pw.Text(value,
                    style: pw.TextStyle(
                        fontSize: 11, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
        );

    return pw.Row(
      children: [
        box(l.invoicePrevReading, Formatters.units(bill.previousReading)),
        box(l.invoiceCurrentReading, Formatters.units(bill.currentReading)),
        box(l.invoiceOwnConsumption,
            '${Formatters.units(bill.ownUnits)} kWh'),
        box(l.invoiceCommonShare,
            '${Formatters.units(bill.commonUnits)} kWh'),
        box(l.invoiceBilledUnits,
            '${Formatters.units(bill.billedUnits)} kWh'),
      ],
    );
  }

  static pw.Widget _slabTable(
      TenantBill bill, AppLocalizations l, String Function(num) money) {
    pw.Widget cell(String text,
            {bool bold = false,
            bool right = false,
            PdfColor color = _ink}) =>
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: pw.Text(
            text,
            textAlign: right ? pw.TextAlign.right : pw.TextAlign.left,
            style: pw.TextStyle(
              fontSize: 9,
              color: color,
              fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        );

    return pw.Container(
      decoration: pw.BoxDecoration(
        borderRadius: pw.BorderRadius.circular(10),
        border: pw.Border.all(color: _line),
      ),
      child: pw.ClipRRect(
        horizontalRadius: 10,
        verticalRadius: 10,
        child: pw.Table(
          columnWidths: const {
            0: pw.FlexColumnWidth(2),
            1: pw.FlexColumnWidth(1.4),
            2: pw.FlexColumnWidth(1.4),
            3: pw.FlexColumnWidth(1.6),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: _orangeDeep),
              children: [
                cell(l.invoiceTariffBreakdown,
                    bold: true, color: PdfColors.white),
                cell(l.tariffSlabRate,
                    bold: true, right: true, color: PdfColors.white),
                cell('kWh', bold: true, right: true, color: PdfColors.white),
                cell(l.dashBill,
                    bold: true, right: true, color: PdfColors.white),
              ],
            ),
            for (final (i, s) in bill.slabBreakdown.indexed)
              pw.TableRow(
                decoration: pw.BoxDecoration(
                    color: i.isOdd ? _zebra : PdfColors.white),
                children: [
                  cell(s.toUnit == null
                      ? '${s.fromUnit}+'
                      : '${s.fromUnit}–${s.toUnit}'),
                  cell(Formatters.units(s.rate), right: true),
                  cell(Formatters.units(s.units), right: true),
                  cell(money(s.amount), right: true, bold: s.units > 0),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _panel(String title, PdfColor tint, List<pw.Widget> rows) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(11),
      decoration: pw.BoxDecoration(
        color: tint,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title,
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 10.5)),
          pw.SizedBox(height: 6),
          ...rows,
        ],
      ),
    );
  }

  static pw.Widget _kv(String label, String value,
      {bool bold = false, PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1.6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Flexible(
            child: pw.Text(label,
                style: pw.TextStyle(
                    fontSize: bold ? 10 : 9,
                    fontWeight:
                        bold ? pw.FontWeight.bold : pw.FontWeight.normal,
                    color: _muted)),
          ),
          pw.Text(value,
              style: pw.TextStyle(
                  fontSize: bold ? 10.5 : 9,
                  fontWeight:
                      bold ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: color ?? _ink)),
        ],
      ),
    );
  }

  static pw.Widget _chargesPanel(
      TenantBill bill, AppLocalizations l, String Function(num) money) {
    return _panel(l.invoiceCharges, _tintGrey, [
      _kv(l.invoiceEnergyCost, money(bill.energyCost)),
      _kv(l.rechargeDemand, money(bill.demandCharge)),
      _kv(l.rechargeMeterRent, money(bill.meterRent)),
      _kv(l.rechargeVat, money(bill.vat)),
      _kv(l.rechargeRebate, '- ${money(bill.rebate)}'),
      if (bill.expenseShare > 0)
        _kv(l.invoiceExpenseShare, money(bill.expenseShare)),
      if (bill.sharedAdjustment.abs() > 0.005)
        _kv(
          l.invoiceSharedAdjustment,
          '${bill.sharedAdjustment >= 0 ? '+ ' : '- '}'
          '${money(bill.sharedAdjustment.abs())}',
        ),
      pw.Divider(color: _line, height: 8),
      _kv(l.invoiceTotalBill, money(bill.totalBill),
          bold: true, color: _orangeDeep),
    ]);
  }

  static pw.Widget _paymentPanel(
      TenantBill bill, AppLocalizations l, String Function(num) money) {
    return _panel(l.invoicePayment, _tintGrey, [
      _kv(l.invoicePreviousBalance, money(bill.previousBalance)),
      _kv(l.invoiceRechargePaid, money(bill.rechargeEnergyCredit)),
      if (bill.rechargeFeesPaid > 0)
        _kv(l.invoiceRechargeFees, money(bill.rechargeFeesPaid)),
      if (bill.settlementsPaid > 0)
        _kv(l.settlementPaid, '- ${money(bill.settlementsPaid)}'),
      if (bill.settlementsReceived > 0)
        _kv(l.settlementReceived, '+ ${money(bill.settlementsReceived)}'),
      pw.Divider(color: _line, height: 8),
      _kv(l.invoiceAvailableBalance, money(bill.availableBalance), bold: true),
    ]);
  }

  static pw.Widget _totalBanner(
      TenantBill bill, AppLocalizations l, String Function(num) money) {
    final isCredit = bill.isCredit;
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: pw.BoxDecoration(
        color: isCredit ? _tintGreen : _tintRed,
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Row(
        children: [
          pw.Text(
            isCredit ? l.invoiceCarryForward : l.invoiceAmountDue,
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
                color: isCredit ? _green : _red),
          ),
          pw.Spacer(),
          pw.Text(
            money(bill.balance.abs()),
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 16,
                color: isCredit ? _green : _red),
          ),
        ],
      ),
    );
  }

  static pw.Widget _signatureRow(AppLocalizations l) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Container(
          width: 52,
          height: 52,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: _line),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Text('QR',
              style: const pw.TextStyle(fontSize: 9, color: _muted)),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(width: 160, height: 0.7, color: _muted),
            pw.SizedBox(height: 4),
            pw.Text(l.invoiceSignature,
                style: const pw.TextStyle(fontSize: 9, color: _muted)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _footer() {
    return pw.Center(
      child: pw.Text(
        AppConstants.defaultPdfFooter,
        style: const pw.TextStyle(fontSize: 8.5, color: _muted),
      ),
    );
  }
}
