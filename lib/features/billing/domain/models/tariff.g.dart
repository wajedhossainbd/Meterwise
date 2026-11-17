// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tariff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TariffSlabRange _$TariffSlabRangeFromJson(Map<String, dynamic> json) =>
    _TariffSlabRange(
      fromUnit: (json['fromUnit'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
      toUnit: (json['toUnit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TariffSlabRangeToJson(_TariffSlabRange instance) =>
    <String, dynamic>{
      'fromUnit': instance.fromUnit,
      'rate': instance.rate,
      'toUnit': instance.toUnit,
    };

_Tariff _$TariffFromJson(Map<String, dynamic> json) => _Tariff(
  slabs: (json['slabs'] as List<dynamic>)
      .map((e) => TariffSlabRange.fromJson(e as Map<String, dynamic>))
      .toList(),
  demandCharge: (json['demandCharge'] as num).toDouble(),
  meterRent: (json['meterRent'] as num).toDouble(),
  vatPercent: (json['vatPercent'] as num).toDouble(),
  rebatePercent: (json['rebatePercent'] as num).toDouble(),
  currencyCode: json['currencyCode'] as String? ?? 'BDT',
  lifelineUpTo: (json['lifelineUpTo'] as num?)?.toInt(),
  lifelineRate: (json['lifelineRate'] as num?)?.toDouble(),
);

Map<String, dynamic> _$TariffToJson(_Tariff instance) => <String, dynamic>{
  'slabs': instance.slabs.map((e) => e.toJson()).toList(),
  'demandCharge': instance.demandCharge,
  'meterRent': instance.meterRent,
  'vatPercent': instance.vatPercent,
  'rebatePercent': instance.rebatePercent,
  'currencyCode': instance.currencyCode,
  'lifelineUpTo': instance.lifelineUpTo,
  'lifelineRate': instance.lifelineRate,
};
