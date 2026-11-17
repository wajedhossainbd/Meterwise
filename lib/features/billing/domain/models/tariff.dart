import 'package:freezed_annotation/freezed_annotation.dart';

part 'tariff.freezed.dart';
part 'tariff.g.dart';

/// A single price tier: every unit consumed between [fromUnit] and [toUnit]
/// (inclusive, cumulative) is charged at [rate].
///
/// [toUnit] of `null` marks the final open-ended slab (e.g. `601+`).
@freezed
abstract class TariffSlabRange with _$TariffSlabRange {
  const factory TariffSlabRange({
    required int fromUnit,
    required double rate,
    int? toUnit,
  }) = _TariffSlabRange;

  factory TariffSlabRange.fromJson(Map<String, dynamic> json) =>
      _$TariffSlabRangeFromJson(json);
}

/// The complete tariff used by the billing engine: slabs plus the flat charges
/// and tax/discount percentages. This is a pure value object — it has no
/// knowledge of the database or any provider entity.
@freezed
abstract class Tariff with _$Tariff {
  const factory Tariff({
    required List<TariffSlabRange> slabs,
    required double demandCharge,
    required double meterRent,
    required double vatPercent,
    required double rebatePercent,
    @Default('BDT') String currencyCode,

    /// Optional lifeline block (official BD structure): when total consumption
    /// is ≤ [lifelineUpTo] units, the *entire* consumption is charged at
    /// [lifelineRate] instead of walking the slab ladder.
    int? lifelineUpTo,
    double? lifelineRate,
  }) = _Tariff;

  factory Tariff.fromJson(Map<String, dynamic> json) => _$TariffFromJson(json);
}
