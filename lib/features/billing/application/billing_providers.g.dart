// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The billing month the user is currently viewing (normalized to the 1st).

@ProviderFor(BillingMonth)
final billingMonthProvider = BillingMonthProvider._();

/// The billing month the user is currently viewing (normalized to the 1st).
final class BillingMonthProvider
    extends $NotifierProvider<BillingMonth, DateTime> {
  /// The billing month the user is currently viewing (normalized to the 1st).
  BillingMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billingMonthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billingMonthHash();

  @$internal
  @override
  BillingMonth create() => BillingMonth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$billingMonthHash() => r'88a8c74e215dfed5c4e38a702830b700560c846b';

/// The billing month the user is currently viewing (normalized to the 1st).

abstract class _$BillingMonth extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Loads all billing inputs once. Null when there's no main meter / readings.

@ProviderFor(billingContext)
final billingContextProvider = BillingContextProvider._();

/// Loads all billing inputs once. Null when there's no main meter / readings.

final class BillingContextProvider
    extends
        $FunctionalProvider<
          AsyncValue<BillingContext?>,
          BillingContext?,
          FutureOr<BillingContext?>
        >
    with $FutureModifier<BillingContext?>, $FutureProvider<BillingContext?> {
  /// Loads all billing inputs once. Null when there's no main meter / readings.
  BillingContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billingContextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billingContextHash();

  @$internal
  @override
  $FutureProviderElement<BillingContext?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BillingContext?> create(Ref ref) {
    return billingContext(ref);
  }
}

String _$billingContextHash() => r'f99fff0f3e942611566717852558fd94964f37c4';

/// Computes the view for the selected month: a finalized period returns its
/// immutable snapshot; a draft period is computed live, opening from the last
/// finalized period's closing balances.

@ProviderFor(periodView)
final periodViewProvider = PeriodViewProvider._();

/// Computes the view for the selected month: a finalized period returns its
/// immutable snapshot; a draft period is computed live, opening from the last
/// finalized period's closing balances.

final class PeriodViewProvider
    extends
        $FunctionalProvider<
          AsyncValue<PeriodView>,
          PeriodView,
          FutureOr<PeriodView>
        >
    with $FutureModifier<PeriodView>, $FutureProvider<PeriodView> {
  /// Computes the view for the selected month: a finalized period returns its
  /// immutable snapshot; a draft period is computed live, opening from the last
  /// finalized period's closing balances.
  PeriodViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'periodViewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$periodViewHash();

  @$internal
  @override
  $FutureProviderElement<PeriodView> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PeriodView> create(Ref ref) {
    return periodView(ref);
  }
}

String _$periodViewHash() => r'cbafd6b639e7cf5e74501365aed82d20a844fc21';

@ProviderFor(billingMonthData)
final billingMonthDataProvider = BillingMonthDataProvider._();

final class BillingMonthDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<BillingMonthData>,
          BillingMonthData,
          FutureOr<BillingMonthData>
        >
    with $FutureModifier<BillingMonthData>, $FutureProvider<BillingMonthData> {
  BillingMonthDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billingMonthDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billingMonthDataHash();

  @$internal
  @override
  $FutureProviderElement<BillingMonthData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BillingMonthData> create(Ref ref) {
    return billingMonthData(ref);
  }
}

String _$billingMonthDataHash() => r'85277a38b9091b9f12059d1b1a40d4021483ab09';

/// The selected month's bill (null when there isn't enough data to bill).

@ProviderFor(monthlyBill)
final monthlyBillProvider = MonthlyBillProvider._();

/// The selected month's bill (null when there isn't enough data to bill).

final class MonthlyBillProvider
    extends
        $FunctionalProvider<
          AsyncValue<MonthlyBill?>,
          MonthlyBill?,
          FutureOr<MonthlyBill?>
        >
    with $FutureModifier<MonthlyBill?>, $FutureProvider<MonthlyBill?> {
  /// The selected month's bill (null when there isn't enough data to bill).
  MonthlyBillProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlyBillProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlyBillHash();

  @$internal
  @override
  $FutureProviderElement<MonthlyBill?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MonthlyBill?> create(Ref ref) {
    return monthlyBill(ref);
  }
}

String _$monthlyBillHash() => r'193ba2391ed968f4774c5ef41b39eba3a86e7ac8';

/// Last [count] months of headline figures (oldest first) for the charts.
/// Finalized months use their snapshot; drafts compute live.

@ProviderFor(monthlyHistory)
final monthlyHistoryProvider = MonthlyHistoryFamily._();

/// Last [count] months of headline figures (oldest first) for the charts.
/// Finalized months use their snapshot; drafts compute live.

final class MonthlyHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MonthlySummary>>,
          List<MonthlySummary>,
          FutureOr<List<MonthlySummary>>
        >
    with
        $FutureModifier<List<MonthlySummary>>,
        $FutureProvider<List<MonthlySummary>> {
  /// Last [count] months of headline figures (oldest first) for the charts.
  /// Finalized months use their snapshot; drafts compute live.
  MonthlyHistoryProvider._({
    required MonthlyHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'monthlyHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$monthlyHistoryHash();

  @override
  String toString() {
    return r'monthlyHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MonthlySummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MonthlySummary>> create(Ref ref) {
    final argument = this.argument as int;
    return monthlyHistory(ref, count: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$monthlyHistoryHash() => r'b0e1b86146d0f766fdddbe6e0b3d9cda74124c13';

/// Last [count] months of headline figures (oldest first) for the charts.
/// Finalized months use their snapshot; drafts compute live.

final class MonthlyHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MonthlySummary>>, int> {
  MonthlyHistoryFamily._()
    : super(
        retry: null,
        name: r'monthlyHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Last [count] months of headline figures (oldest first) for the charts.
  /// Finalized months use their snapshot; drafts compute live.

  MonthlyHistoryProvider call({int count = 6}) =>
      MonthlyHistoryProvider._(argument: count, from: this);

  @override
  String toString() => r'monthlyHistoryProvider';
}
