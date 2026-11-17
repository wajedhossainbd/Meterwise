// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SlabAllocation _$SlabAllocationFromJson(Map<String, dynamic> json) =>
    _SlabAllocation(
      fromUnit: (json['fromUnit'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
      units: (json['units'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
      toUnit: (json['toUnit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SlabAllocationToJson(_SlabAllocation instance) =>
    <String, dynamic>{
      'fromUnit': instance.fromUnit,
      'rate': instance.rate,
      'units': instance.units,
      'amount': instance.amount,
      'toUnit': instance.toUnit,
    };

_TenantBill _$TenantBillFromJson(Map<String, dynamic> json) => _TenantBill(
  tenantId: (json['tenantId'] as num).toInt(),
  tenantName: json['tenantName'] as String,
  previousReading: (json['previousReading'] as num).toDouble(),
  currentReading: (json['currentReading'] as num).toDouble(),
  ownUnits: (json['ownUnits'] as num).toDouble(),
  commonUnits: (json['commonUnits'] as num).toDouble(),
  billedUnits: (json['billedUnits'] as num).toDouble(),
  slabBreakdown: (json['slabBreakdown'] as List<dynamic>)
      .map((e) => SlabAllocation.fromJson(e as Map<String, dynamic>))
      .toList(),
  energyCost: (json['energyCost'] as num).toDouble(),
  demandCharge: (json['demandCharge'] as num).toDouble(),
  meterRent: (json['meterRent'] as num).toDouble(),
  vat: (json['vat'] as num).toDouble(),
  rebate: (json['rebate'] as num).toDouble(),
  totalBill: (json['totalBill'] as num).toDouble(),
  rechargePaid: (json['rechargePaid'] as num).toDouble(),
  previousBalance: (json['previousBalance'] as num?)?.toDouble() ?? 0,
  settlementsPaid: (json['settlementsPaid'] as num?)?.toDouble() ?? 0,
  settlementsReceived: (json['settlementsReceived'] as num?)?.toDouble() ?? 0,
  billingMode: json['billingMode'] as String? ?? 'shared',
  fixedRate: (json['fixedRate'] as num?)?.toDouble(),
  expenseShare: (json['expenseShare'] as num?)?.toDouble() ?? 0,
  sharedAdjustment: (json['sharedAdjustment'] as num?)?.toDouble() ?? 0,
  rechargeFeesPaid: (json['rechargeFeesPaid'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$TenantBillToJson(_TenantBill instance) =>
    <String, dynamic>{
      'tenantId': instance.tenantId,
      'tenantName': instance.tenantName,
      'previousReading': instance.previousReading,
      'currentReading': instance.currentReading,
      'ownUnits': instance.ownUnits,
      'commonUnits': instance.commonUnits,
      'billedUnits': instance.billedUnits,
      'slabBreakdown': instance.slabBreakdown.map((e) => e.toJson()).toList(),
      'energyCost': instance.energyCost,
      'demandCharge': instance.demandCharge,
      'meterRent': instance.meterRent,
      'vat': instance.vat,
      'rebate': instance.rebate,
      'totalBill': instance.totalBill,
      'rechargePaid': instance.rechargePaid,
      'previousBalance': instance.previousBalance,
      'settlementsPaid': instance.settlementsPaid,
      'settlementsReceived': instance.settlementsReceived,
      'billingMode': instance.billingMode,
      'fixedRate': instance.fixedRate,
      'expenseShare': instance.expenseShare,
      'sharedAdjustment': instance.sharedAdjustment,
      'rechargeFeesPaid': instance.rechargeFeesPaid,
    };

_MonthlyBill _$MonthlyBillFromJson(Map<String, dynamic> json) => _MonthlyBill(
  mainMeterUnits: (json['mainMeterUnits'] as num).toDouble(),
  totalTenantUnits: (json['totalTenantUnits'] as num).toDouble(),
  commonAreaUnits: (json['commonAreaUnits'] as num).toDouble(),
  tenantBills: (json['tenantBills'] as List<dynamic>)
      .map((e) => TenantBill.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalRecharge: (json['totalRecharge'] as num).toDouble(),
  buildingBill: (json['buildingBill'] as num?)?.toDouble() ?? 0,
  totalExpenses: (json['totalExpenses'] as num?)?.toDouble() ?? 0,
  calcMode: json['calcMode'] as String? ?? 'sharedSlab',
  ownerBenefit: (json['ownerBenefit'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$MonthlyBillToJson(_MonthlyBill instance) =>
    <String, dynamic>{
      'mainMeterUnits': instance.mainMeterUnits,
      'totalTenantUnits': instance.totalTenantUnits,
      'commonAreaUnits': instance.commonAreaUnits,
      'tenantBills': instance.tenantBills.map((e) => e.toJson()).toList(),
      'totalRecharge': instance.totalRecharge,
      'buildingBill': instance.buildingBill,
      'totalExpenses': instance.totalExpenses,
      'calcMode': instance.calcMode,
      'ownerBenefit': instance.ownerBenefit,
    };
