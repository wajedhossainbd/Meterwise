import '../../../core/constants/app_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/models/billing_result.dart';
import 'invoice_pdf.dart' show InvoiceMeta;

/// Builds the invoice as an HTML document, converted to PDF by the platform
/// WebView (`Printing.convertHtml`).
///
/// Why HTML: the platform text engine performs full complex-script shaping,
/// so Bengali labels AND user-entered Bangla names render correctly — which
/// the pure-Dart PDF engine cannot do. The layout mirrors the vector invoice.
class InvoiceHtml {
  const InvoiceHtml._();

  static String _esc(String s) => s
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;');

  static String build({
    required TenantBill bill,
    required String monthLabel,
    required InvoiceMeta meta,
    required AppLocalizations l,
  }) {
    String money(num v) => Formatters.money(v, currencyCode: meta.currency);

    String chip(String label, String value, [String color = '#1D2433']) => '''
      <span class="chip"><span class="chip-l">${_esc(label)}</span>
      <b style="color:$color">${_esc(value)}</b></span>''';

    String kv(String label, String value,
            {bool bold = false, String? color}) =>
        '''
      <div class="kv${bold ? ' kv-b' : ''}">
        <span>${_esc(label)}</span>
        <span${color != null ? ' style="color:$color"' : ''}>${_esc(value)}</span>
      </div>''';

    final slabRows = StringBuffer();
    for (final (i, s) in bill.slabBreakdown.indexed) {
      final range = s.toUnit == null ? '${s.fromUnit}+' : '${s.fromUnit}–${s.toUnit}';
      slabRows.write('''
        <tr${i.isOdd ? ' class="zebra"' : ''}>
          <td>$range</td>
          <td class="r">${Formatters.units(s.rate)}</td>
          <td class="r">${Formatters.units(s.units)}</td>
          <td class="r${s.units > 0 ? ' b' : ''}">${_esc(money(s.amount))}</td>
        </tr>''');
    }

    final isCredit = bill.isCredit;
    final totalColor = isCredit ? '#2E9E5B' : '#E8553C';
    final totalBg = isCredit ? '#EAF6EF' : '#FDEEEA';

    return '''
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  @page { size: A4; margin: 14mm 12mm; }
  * { -webkit-print-color-adjust: exact; print-color-adjust: exact;
      box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'Noto Sans Bengali','Noto Sans',Roboto,sans-serif;
         color: #1D2433; font-size: 11px; }
  .banner { background: linear-gradient(90deg,#2962FF,#7C4DFF); color: #fff;
            border-radius: 12px; padding: 14px 16px; display: flex;
            align-items: center; }
  .logo { width: 38px; height: 38px; background: #fff; color: #2962FF;
          border-radius: 50%; font-weight: 800; font-size: 19px;
          display: flex; align-items: center; justify-content: center; }
  .app { margin-left: 11px; }
  .app b { font-size: 18px; display: block; }
  .app span { font-size: 9px; opacity: .85; }
  .prop { margin-left: auto; text-align: right; }
  .prop b { font-size: 12px; display: block; }
  .prop .addr { font-size: 9px; opacity: .85; }
  .month { display: inline-block; background: rgba(255,255,255,.22);
           border-radius: 7px; padding: 2px 8px; font-weight: 700;
           font-size: 10px; margin-top: 4px; }
  .draft { background:#FFF3CD; color:#8A6D00; font-weight:700; font-size:10px;
           border-radius: 8px; padding: 6px 12px; margin-top: 9px; }
  .chips { margin-top: 10px; }
  .chip { display: inline-block; background: #F5F6FA; border-radius: 7px;
          padding: 3px 8px; font-size: 8.5px; margin: 0 4px 4px 0; }
  .chip-l { color: #6B7280; margin-right: 4px; }
  .billed { background: #EEF3FF; border-radius: 10px; padding: 11px 13px;
            margin-top: 9px; display: flex; align-items: center; }
  .billed .who .cap { font-size: 8px; color: #6B7280; }
  .billed .who b { font-size: 14px; display: block; }
  .billed .who .ph { font-size: 9px; color: #6B7280; }
  .rate { margin-left: auto; text-align: right; }
  .rate .cap { font-size: 8px; color: #6B7280; }
  .rate b { color: #2962FF; font-size: 12px; }
  .boxes { display: flex; gap: 7px; margin-top: 9px; }
  .box { flex: 1; background: #F5F6FA; border-radius: 8px; padding: 8px 9px; }
  .box .cap { font-size: 7.5px; color: #6B7280; }
  .box b { font-size: 11px; display: block; margin-top: 2px; }
  table { width: 100%; border-collapse: collapse; margin-top: 10px;
          border: 1px solid #E3E8F4; border-radius: 9px; overflow: hidden; }
  th { background: #2962FF; color: #fff; text-align: left; font-size: 9px;
       padding: 6px 8px; }
  th.r, td.r { text-align: right; }
  td { font-size: 9px; padding: 5px 8px; }
  td.b { font-weight: 700; }
  tr.zebra td { background: #F8FAFF; }
  .cols { display: flex; gap: 10px; margin-top: 10px; }
  .panel { flex: 1; background: #F5F6FA; border-radius: 9px; padding: 10px 11px; }
  .panel h4 { font-size: 10.5px; margin-bottom: 5px; }
  .kv { display: flex; justify-content: space-between; font-size: 9px;
        padding: 1.5px 0; color: #1D2433; }
  .kv span:first-child { color: #6B7280; }
  .kv-b { font-weight: 700; font-size: 10px; border-top: 1px solid #D8DEEC;
          margin-top: 4px; padding-top: 4px; }
  .kv-b span:first-child { color: #1D2433; }
  .total { display: flex; align-items: center; background: $totalBg;
           color: $totalColor; border-radius: 9px; padding: 10px 13px;
           margin-top: 10px; font-weight: 800; }
  .total .amt { margin-left: auto; font-size: 16px; }
  .foot { display: flex; align-items: flex-end; margin-top: 26px; }
  .qr { width: 48px; height: 48px; border: 1px solid #CBD2E0; color:#6B7280;
        border-radius: 7px; display: flex; align-items: center;
        justify-content: center; font-size: 9px; }
  .sig { margin-left: auto; text-align: center; font-size: 9px; color:#6B7280; }
  .sig .line { width: 150px; border-top: 1px solid #9AA3B5;
               margin-bottom: 4px; }
  .gen { text-align: center; color: #6B7280; font-size: 8.5px;
         margin-top: 12px; }
</style>
</head>
<body>
  <div class="banner">
    <div class="logo">M</div>
    <div class="app"><b>${_esc(AppConstants.appName)}</b>
      <span>Electricity Invoice</span></div>
    <div class="prop"><b>${_esc(meta.propertyName)}</b>
      ${meta.propertyAddress != null && meta.propertyAddress!.isNotEmpty ? '<span class="addr">${_esc(meta.propertyAddress!)}</span><br>' : ''}
      <span class="month">${_esc(monthLabel)}</span></div>
  </div>

  ${meta.finalized ? '' : '<div class="draft">DRAFT — ${_esc(l.statusDraft)}</div>'}

  <div class="chips">
    ${chip('Status', meta.finalized ? l.statusFinalized : l.statusDraft, meta.finalized ? '#2E9E5B' : '#8A6D00')}
    ${meta.providerName != null ? chip('Provider', meta.providerName!) : ''}
    ${meta.tariffVersionLabel != null ? chip('Tariff', meta.tariffVersionLabel!) : ''}
    ${chip(l.invoiceBillingMode, meta.billingMethodLabel)}
    ${chip('Generated', Formatters.date(DateTime.now()))}
    ${meta.finalizedAt != null ? chip(l.statusFinalized, Formatters.date(meta.finalizedAt!)) : ''}
  </div>

  <div class="billed">
    <div class="who">
      <div class="cap">BILLED TO</div>
      <b>${_esc(bill.tenantName)}</b>
      ${meta.tenantPhone != null && meta.tenantPhone!.isNotEmpty ? '<span class="ph">${_esc(meta.tenantPhone!)}</span>' : ''}
    </div>
    <div class="rate">
      <div class="cap">${_esc(l.invoiceEffectiveRate)}</div>
      <b>${bill.billedUnits > 0 ? '${_esc(money(bill.effectiveRate))} / kWh' : '—'}</b>
    </div>
  </div>

  <div class="boxes">
    <div class="box"><span class="cap">${_esc(l.invoicePrevReading)}</span>
      <b>${Formatters.units(bill.previousReading)}</b></div>
    <div class="box"><span class="cap">${_esc(l.invoiceCurrentReading)}</span>
      <b>${Formatters.units(bill.currentReading)}</b></div>
    <div class="box"><span class="cap">${_esc(l.invoiceOwnConsumption)}</span>
      <b>${Formatters.units(bill.ownUnits)} kWh</b></div>
    <div class="box"><span class="cap">${_esc(l.invoiceCommonShare)}</span>
      <b>${Formatters.units(bill.commonUnits)} kWh</b></div>
    <div class="box"><span class="cap">${_esc(l.invoiceBilledUnits)}</span>
      <b>${Formatters.units(bill.billedUnits)} kWh</b></div>
  </div>

  <table>
    <tr>
      <th>${_esc(l.invoiceTariffBreakdown)}</th>
      <th class="r">${_esc(l.tariffSlabRate)}</th>
      <th class="r">kWh</th>
      <th class="r">${_esc(l.dashBill)}</th>
    </tr>
    $slabRows
  </table>

  <div class="cols">
    <div class="panel">
      <h4>${_esc(l.invoiceCharges)}</h4>
      ${kv(l.invoiceEnergyCost, money(bill.energyCost))}
      ${kv(l.rechargeDemand, money(bill.demandCharge))}
      ${kv(l.rechargeMeterRent, money(bill.meterRent))}
      ${kv(l.rechargeVat, money(bill.vat))}
      ${kv(l.rechargeRebate, '- ${money(bill.rebate)}')}
      ${bill.expenseShare > 0 ? kv(l.invoiceExpenseShare, money(bill.expenseShare)) : ''}
      ${bill.sharedAdjustment.abs() > 0.005 ? kv(l.invoiceSharedAdjustment, '${bill.sharedAdjustment >= 0 ? '+ ' : '- '}${money(bill.sharedAdjustment.abs())}') : ''}
      ${kv(l.invoiceTotalBill, money(bill.totalBill), bold: true, color: '#2962FF')}
    </div>
    <div class="panel">
      <h4>${_esc(l.invoicePayment)}</h4>
      ${kv(l.invoicePreviousBalance, money(bill.previousBalance))}
      ${kv(l.invoiceRechargePaid, money(bill.rechargeEnergyCredit))}
      ${bill.rechargeFeesPaid > 0 ? kv(l.invoiceRechargeFees, money(bill.rechargeFeesPaid)) : ''}
      ${bill.settlementsPaid > 0 ? kv(l.settlementPaid, '+ ${money(bill.settlementsPaid)}') : ''}
      ${bill.settlementsReceived > 0 ? kv(l.settlementReceived, '- ${money(bill.settlementsReceived)}') : ''}
      ${kv(l.invoiceAvailableBalance, money(bill.availableBalance), bold: true)}
    </div>
  </div>

  <div class="total">
    <span>${_esc(isCredit ? l.invoiceCarryForward : l.invoiceAmountDue)}</span>
    <span class="amt">${_esc(money(bill.balance.abs()))}</span>
  </div>

  <div class="foot">
    <div class="qr">QR</div>
    <div class="sig"><div class="line"></div>${_esc(l.invoiceSignature)}</div>
  </div>
  <div class="gen">${_esc(AppConstants.defaultPdfFooter)}</div>
</body>
</html>''';
  }
}
