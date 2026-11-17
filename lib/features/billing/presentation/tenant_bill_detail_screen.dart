import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart' show PdfPageFormat;
import 'package:printing/printing.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../main_meter/data/main_meter_repository.dart';
import '../../properties/data/property_repository.dart';
import '../../tariff/data/tariff_version_repository.dart';
import '../../tenants/data/tenant_repository.dart';
import '../application/invoice_html.dart';
import '../application/invoice_pdf.dart';
import '../data/billing_period_repository.dart';
import '../domain/models/billing_result.dart';

/// Full invoice for one tenant for one month, with share / print actions.
class TenantBillDetailScreen extends ConsumerWidget {
  const TenantBillDetailScreen({
    required this.bill,
    required this.month,
    super.key,
  });

  final TenantBill bill;
  final DateTime month;

  /// The plugin's WebView converter can hang forever on some devices (its
  /// Android impl holds no strong reference to the WebView and has no error
  /// path if `onPageFinished` never fires). Once it fails or times out we
  /// skip it for the rest of the session instead of stalling every share.
  static bool _htmlConverterBroken = false;

  String get _monthLabel => Formatters.monthYear(month);

  Future<InvoiceMeta> _meta(WidgetRef ref, AppLocalizations l) async {
    final property = await ref.read(propertyRepositoryProvider).getFirst();
    final period = property == null
        ? null
        : await ref
            .read(billingPeriodRepositoryProvider)
            .find(property.id, month.year, month.month);

    final versionRepo = ref.read(tariffVersionRepositoryProvider);
    String? versionLabel;
    if (period?.tariffVersionId != null) {
      versionLabel = (await versionRepo.getAll())
          .firstWhereOrNull((v) => v.id == period!.tariffVersionId)
          ?.label;
    } else {
      versionLabel = (await versionRepo
              .activeVersionForDate(DateTime(month.year, month.month, 1)))
          ?.label;
    }

    final tenants = ref.read(tenantListProvider).value ?? const [];
    final providerName =
        await ref.read(mainMeterRepositoryProvider).providerName();
    return InvoiceMeta(
      propertyName: property?.name ?? 'My Property',
      propertyAddress: property?.address,
      tenantPhone:
          tenants.firstWhereOrNull((t) => t.id == bill.tenantId)?.phone,
      currency: period?.currencySnapshot ?? ref.read(currencyCodeProvider),
      finalized: period?.status == 'finalized',
      finalizedAt: period?.finalizedAt,
      tariffVersionLabel: versionLabel,
      billingMethodLabel: bill.billingMode == 'fixed'
          ? l.tenantModeFixed
          : l.tenantModeShared,
      providerName: providerName,
    );
  }

  Future<Uint8List> _buildPdf(WidgetRef ref, AppLocalizations l) async {
    // Primary path: HTML → PDF via the platform WebView, whose text engine
    // performs full complex-script shaping — so Bengali labels AND
    // user-entered Bangla names render correctly (the pure-Dart PDF engine
    // cannot shape Indic scripts). The converter can hang (see
    // [_htmlConverterBroken]), so it runs under a hard timeout; on ANY
    // failure the English vector invoice is generated instead, so sharing
    // always produces a document.
    if (!_htmlConverterBroken) {
      try {
        final meta = await _meta(ref, l);
        final html = InvoiceHtml.build(
          bill: bill,
          monthLabel: _monthLabel,
          meta: meta,
          l: l,
        );
        // Deprecated upstream, but it is the only engine that shapes Bengali
        // correctly (platform WebView). Guarded by timeout + vector fallback.
        // ignore: deprecated_member_use
        final bytes = await Printing.convertHtml(
          format: PdfPageFormat.a4,
          html: html,
        ).timeout(const Duration(seconds: 10));
        // Sanity check: a real PDF is never this small.
        if (bytes.length > 500) return bytes;
        _htmlConverterBroken = true;
      } catch (_) {
        _htmlConverterBroken = true;
      }
    }
    final pdfL = lookupAppLocalizations(const Locale('en'));
    final meta = await _meta(ref, pdfL);
    return InvoicePdf.build(
      bill: bill,
      monthLabel: _monthLabel,
      meta: meta,
      l: pdfL,
    );
  }

  String get _fileName =>
      'MeterWise_${bill.tenantName}_$_monthLabel.pdf'.replaceAll(' ', '_');

  /// Builds the PDF behind a blocking "preparing…" dialog. The dialog is
  /// dismissed BEFORE the native share/print sheet opens. Returns null (after
  /// showing a snackbar) if even the fallback failed — never fails silently.
  Future<Uint8List?> _preparePdf(
      BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context, rootNavigator: true);
    var dialogOpen = true;
    unawaited(showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(child: Text(l.invoicePreparing)),
            ],
          ),
        ),
      ),
    ).whenComplete(() => dialogOpen = false));

    try {
      return await _buildPdf(ref, l);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.invoiceShareFailed)));
      return null;
    } finally {
      if (dialogOpen) navigator.pop();
    }
  }

  Future<void> _share(
      BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final messenger = ScaffoldMessenger.of(context);
    final bytes = await _preparePdf(context, ref, l);
    if (bytes == null) return;
    try {
      await Printing.sharePdf(bytes: bytes, filename: _fileName);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.invoiceShareFailed)));
    }
  }

  Future<void> _print(
      BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final messenger = ScaffoldMessenger.of(context);
    final bytes = await _preparePdf(context, ref, l);
    if (bytes == null) return;
    try {
      await Printing.layoutPdf(onLayout: (_) async => bytes);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.invoiceShareFailed)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currency = ref.watch(currencyCodeProvider);
    String money(num v) => Formatters.money(v, currencyCode: currency);
    final isCredit = bill.isCredit;
    final balanceColor = isCredit ? AppColors.credit : AppColors.due;

    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(bill.tenantName),
        actions: [
          IconButton(
            icon: const Icon(Icons.print_outlined),
            tooltip: l.actionPrint,
            onPressed: () => _print(context, ref, l),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _share(context, ref, l),
        icon: const Icon(Icons.share),
        label: Text(l.actionShare),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(_monthLabel,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  bill.billingMode == 'fixed'
                      ? l.tenantModeFixed
                      : l.tenantModeShared,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${l.invoiceEffectiveRate}: '
            '${l.effectiveRateValue(money(bill.effectiveRate))}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          SectionCard(
            title: l.invoiceReadings,
            child: Column(
              children: [
                LabelValueRow(l.invoicePrevReading,
                    Formatters.units(bill.previousReading)),
                LabelValueRow(l.invoiceCurrentReading,
                    Formatters.units(bill.currentReading)),
                LabelValueRow(l.invoiceOwnConsumption,
                    '${Formatters.units(bill.ownUnits)} kWh'),
                LabelValueRow(l.invoiceCommonShare,
                    '${Formatters.units(bill.commonUnits)} kWh'),
                const Divider(),
                LabelValueRow(
                  l.invoiceBilledUnits,
                  '${Formatters.units(bill.billedUnits)} kWh',
                  emphasize: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: l.invoiceTariffBreakdown,
            child: Column(
              children: [
                for (final s in bill.slabBreakdown)
                  LabelValueRow(
                    s.toUnit == null
                        ? '${s.fromUnit}+  @ ${Formatters.units(s.rate)}'
                        : '${s.fromUnit}-${s.toUnit}  @ ${Formatters.units(s.rate)}',
                    '${Formatters.units(s.units)} kWh  =  ${money(s.amount)}',
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: l.invoiceCharges,
            child: Column(
              children: [
                LabelValueRow(l.invoiceEnergyCost, money(bill.energyCost)),
                LabelValueRow(l.rechargeDemand, money(bill.demandCharge)),
                LabelValueRow(l.rechargeMeterRent, money(bill.meterRent)),
                LabelValueRow(l.rechargeVat, money(bill.vat)),
                LabelValueRow(l.rechargeRebate, '- ${money(bill.rebate)}'),
                if (bill.expenseShare > 0)
                  LabelValueRow(
                      l.invoiceExpenseShare, money(bill.expenseShare)),
                if (bill.sharedAdjustment.abs() > 0.005)
                  LabelValueRow(
                    l.invoiceSharedAdjustment,
                    '${bill.sharedAdjustment >= 0 ? '+ ' : '- '}'
                    '${money(bill.sharedAdjustment.abs())}',
                  ),
                const Divider(),
                LabelValueRow(l.invoiceTotalBill, money(bill.totalBill),
                    emphasize: true),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: l.invoicePayment,
            child: Column(
              children: [
                LabelValueRow(
                    l.invoicePreviousBalance, money(bill.previousBalance)),
                LabelValueRow(l.invoiceRechargePaid,
                    money(bill.rechargeEnergyCredit)),
                if (bill.rechargeFeesPaid > 0)
                  LabelValueRow(
                      l.invoiceRechargeFees, money(bill.rechargeFeesPaid)),
                if (bill.settlementsPaid > 0)
                  LabelValueRow(
                      l.settlementPaid, '+ ${money(bill.settlementsPaid)}'),
                if (bill.settlementsReceived > 0)
                  LabelValueRow(l.settlementReceived,
                      '- ${money(bill.settlementsReceived)}'),
                LabelValueRow(
                    l.invoiceAvailableBalance, money(bill.availableBalance)),
                LabelValueRow(l.invoiceTotalBill, '- ${money(bill.totalBill)}'),
                const Divider(),
                LabelValueRow(
                  isCredit ? l.invoiceCarryForward : l.invoiceAmountDue,
                  money(bill.balance.abs()),
                  emphasize: true,
                  valueColor: balanceColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
