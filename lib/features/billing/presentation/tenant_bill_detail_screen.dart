import 'dart:async';
import 'dart:developer' as developer;
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
import '../application/native_invoice_pdf.dart';
import '../data/billing_period_repository.dart';
import '../domain/models/billing_result.dart';
import '../../settings/data/settings_repository.dart';

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

  /// The native channel is tried first; if it fails on a device we stop using
  /// it for the session and fall through to the plugin (then the vector PDF).
  static bool _nativeConverterBroken = false;

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

  /// The result of an export attempt. [usedFallback] is true when Bangla was
  /// requested but the device produced an English invoice instead — the UI
  /// must say so instead of silently changing the language.
  ({Uint8List bytes, bool usedFallback}) _pdfResult(Uint8List bytes,
          {required bool usedFallback}) =>
      (bytes: bytes, usedFallback: usedFallback);

  Future<({Uint8List bytes, bool usedFallback})> _buildPdf(
    WidgetRef ref,
    AppLocalizations l, {
    required bool bangla,
  }) async {
    // Primary path: HTML → PDF via the platform WebView, whose text engine
    // performs full complex-script shaping — so Bengali labels AND
    // user-entered Bangla names render correctly (the pure-Dart PDF engine
    // cannot shape Indic scripts). The converter can hang (see
    // [_htmlConverterBroken]), so it runs under a hard timeout; on ANY
    // failure the English vector invoice is generated instead, and the caller
    // shows an explicit notice.
    final meta = bangla ? await _meta(ref, l) : null;
    final html = meta == null
        ? null
        : InvoiceHtml.build(
            bill: bill,
            monthLabel: _monthLabel,
            meta: meta,
            l: l,
          );

    // Preferred path: our Android channel owns the WebView for the job, so
    // there is no dangling reference to hang the conversion.
    if (html != null && !_nativeConverterBroken) {
      try {
        final bytes = await NativeInvoicePdf.convert(html);
        if (bytes != null) return _pdfResult(bytes, usedFallback: false);
        _nativeConverterBroken = true;
        developer.log('Native invoice PDF failed; trying plugin fallback',
            name: 'MeterWise');
      } catch (e, stack) {
        _nativeConverterBroken = true;
        developer.log('Native invoice PDF threw',
            name: 'MeterWise', error: e, stackTrace: stack);
      }
    }

    // Second path: the plugin's deprecated converter, still useful on devices
    // where our channel is unavailable, under a hard timeout.
    if (html != null && !_htmlConverterBroken) {
      try {
        // Deprecated upstream, but it is the only other engine that shapes
        // Bengali correctly (platform WebView). Guarded by timeout + fallback.
        // ignore: deprecated_member_use
        final bytes = await Printing.convertHtml(
          format: PdfPageFormat.a4,
          html: html,
        ).timeout(const Duration(seconds: 10));
        // Sanity check: a real PDF is never this small.
        if (bytes.length > 500) return _pdfResult(bytes, usedFallback: false);
        _htmlConverterBroken = true;
        developer.log('HTML invoice too small (${bytes.length} bytes)',
            name: 'MeterWise');
      } catch (e, stack) {
        _htmlConverterBroken = true;
        developer.log('Bangla invoice conversion failed',
            name: 'MeterWise', error: e, stackTrace: stack);
      }
    }
    final pdfL = lookupAppLocalizations(const Locale('en'));
    final pdfMeta = await _meta(ref, pdfL);
    return _pdfResult(
      await InvoicePdf.build(
        bill: bill,
        monthLabel: _monthLabel,
        meta: pdfMeta,
        l: pdfL,
      ),
      usedFallback: bangla,
    );
  }

  /// True when the invoice should be rendered in Bangla: an explicit 'bn'
  /// preference, or 'auto' while the app UI is Bengali.
  bool _wantsBangla(WidgetRef ref, BuildContext context) {
    final pref = ref.read(appSettingsProvider).value?.invoiceLanguage ?? 'auto';
    if (pref == 'en') return false;
    if (pref == 'bn') return true;
    return Localizations.localeOf(context).languageCode == 'bn';
  }

  String get _fileName =>
      'MeterWise_${bill.tenantName}_$_monthLabel.pdf'.replaceAll(' ', '_');

  /// Builds the PDF behind a blocking "preparing…" dialog. The dialog is
  /// dismissed BEFORE the native share/print sheet opens. Returns null (after
  /// showing a snackbar) if even the fallback failed — never fails silently.
  Future<({Uint8List bytes, bool usedFallback})?> _preparePdf(
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
      final result = await _buildPdf(
        ref,
        l,
        bangla: _wantsBangla(ref, context),
      );
      if (result.usedFallback) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(l.invoiceFallbackNotice),
            action: SnackBarAction(
              label: l.invoiceRetryBangla,
              onPressed: () {
                _nativeConverterBroken = false;
                _htmlConverterBroken = false;
                if (context.mounted) _share(context, ref, l);
              },
            ),
          ),
        );
      }
      return result;
    } catch (e, stack) {
      developer.log('Invoice PDF build failed',
          name: 'MeterWise', error: e, stackTrace: stack);
      messenger.showSnackBar(SnackBar(content: Text(l.invoiceShareFailed)));
      return null;
    } finally {
      if (dialogOpen) navigator.pop();
    }
  }

  Future<void> _share(
      BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await _preparePdf(context, ref, l);
    if (result == null) return;
    try {
      await Printing.sharePdf(bytes: result.bytes, filename: _fileName);
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.invoiceShareFailed)));
    }
  }

  Future<void> _print(
      BuildContext context, WidgetRef ref, AppLocalizations l) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = await _preparePdf(context, ref, l);
    if (result == null) return;
    try {
      await Printing.layoutPdf(onLayout: (_) async => result.bytes);
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
