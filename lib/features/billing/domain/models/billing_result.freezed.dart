// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SlabAllocation {

 int get fromUnit; double get rate; double get units; double get amount; int? get toUnit;
/// Create a copy of SlabAllocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlabAllocationCopyWith<SlabAllocation> get copyWith => _$SlabAllocationCopyWithImpl<SlabAllocation>(this as SlabAllocation, _$identity);

  /// Serializes this SlabAllocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlabAllocation&&(identical(other.fromUnit, fromUnit) || other.fromUnit == fromUnit)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.units, units) || other.units == units)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.toUnit, toUnit) || other.toUnit == toUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromUnit,rate,units,amount,toUnit);

@override
String toString() {
  return 'SlabAllocation(fromUnit: $fromUnit, rate: $rate, units: $units, amount: $amount, toUnit: $toUnit)';
}


}

/// @nodoc
abstract mixin class $SlabAllocationCopyWith<$Res>  {
  factory $SlabAllocationCopyWith(SlabAllocation value, $Res Function(SlabAllocation) _then) = _$SlabAllocationCopyWithImpl;
@useResult
$Res call({
 int fromUnit, double rate, double units, double amount, int? toUnit
});




}
/// @nodoc
class _$SlabAllocationCopyWithImpl<$Res>
    implements $SlabAllocationCopyWith<$Res> {
  _$SlabAllocationCopyWithImpl(this._self, this._then);

  final SlabAllocation _self;
  final $Res Function(SlabAllocation) _then;

/// Create a copy of SlabAllocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromUnit = null,Object? rate = null,Object? units = null,Object? amount = null,Object? toUnit = freezed,}) {
  return _then(_self.copyWith(
fromUnit: null == fromUnit ? _self.fromUnit : fromUnit // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,toUnit: freezed == toUnit ? _self.toUnit : toUnit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SlabAllocation].
extension SlabAllocationPatterns on SlabAllocation {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlabAllocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlabAllocation() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlabAllocation value)  $default,){
final _that = this;
switch (_that) {
case _SlabAllocation():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlabAllocation value)?  $default,){
final _that = this;
switch (_that) {
case _SlabAllocation() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fromUnit,  double rate,  double units,  double amount,  int? toUnit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlabAllocation() when $default != null:
return $default(_that.fromUnit,_that.rate,_that.units,_that.amount,_that.toUnit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fromUnit,  double rate,  double units,  double amount,  int? toUnit)  $default,) {final _that = this;
switch (_that) {
case _SlabAllocation():
return $default(_that.fromUnit,_that.rate,_that.units,_that.amount,_that.toUnit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fromUnit,  double rate,  double units,  double amount,  int? toUnit)?  $default,) {final _that = this;
switch (_that) {
case _SlabAllocation() when $default != null:
return $default(_that.fromUnit,_that.rate,_that.units,_that.amount,_that.toUnit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlabAllocation implements SlabAllocation {
  const _SlabAllocation({required this.fromUnit, required this.rate, required this.units, required this.amount, this.toUnit});
  factory _SlabAllocation.fromJson(Map<String, dynamic> json) => _$SlabAllocationFromJson(json);

@override final  int fromUnit;
@override final  double rate;
@override final  double units;
@override final  double amount;
@override final  int? toUnit;

/// Create a copy of SlabAllocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlabAllocationCopyWith<_SlabAllocation> get copyWith => __$SlabAllocationCopyWithImpl<_SlabAllocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlabAllocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlabAllocation&&(identical(other.fromUnit, fromUnit) || other.fromUnit == fromUnit)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.units, units) || other.units == units)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.toUnit, toUnit) || other.toUnit == toUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromUnit,rate,units,amount,toUnit);

@override
String toString() {
  return 'SlabAllocation(fromUnit: $fromUnit, rate: $rate, units: $units, amount: $amount, toUnit: $toUnit)';
}


}

/// @nodoc
abstract mixin class _$SlabAllocationCopyWith<$Res> implements $SlabAllocationCopyWith<$Res> {
  factory _$SlabAllocationCopyWith(_SlabAllocation value, $Res Function(_SlabAllocation) _then) = __$SlabAllocationCopyWithImpl;
@override @useResult
$Res call({
 int fromUnit, double rate, double units, double amount, int? toUnit
});




}
/// @nodoc
class __$SlabAllocationCopyWithImpl<$Res>
    implements _$SlabAllocationCopyWith<$Res> {
  __$SlabAllocationCopyWithImpl(this._self, this._then);

  final _SlabAllocation _self;
  final $Res Function(_SlabAllocation) _then;

/// Create a copy of SlabAllocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromUnit = null,Object? rate = null,Object? units = null,Object? amount = null,Object? toUnit = freezed,}) {
  return _then(_SlabAllocation(
fromUnit: null == fromUnit ? _self.fromUnit : fromUnit // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,units: null == units ? _self.units : units // ignore: cast_nullable_to_non_nullable
as double,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,toUnit: freezed == toUnit ? _self.toUnit : toUnit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TenantBill {

 int get tenantId; String get tenantName; double get previousReading; double get currentReading;/// Units measured directly on the tenant's sub-meter.
 double get ownUnits;/// Common-area units allocated to this tenant (proportional share).
 double get commonUnits;/// [ownUnits] + [commonUnits] — the units this tenant is billed for.
 double get billedUnits; List<SlabAllocation> get slabBreakdown; double get energyCost; double get demandCharge; double get meterRent; double get vat; double get rebate;/// Net amount owed by the tenant before recharge reconciliation.
 double get totalBill;/// Total recharges attributed to this tenant (matched by payer name).
 double get rechargePaid;/// Prepaid balance carried in from previous periods (can be negative for a
/// past-due tenant).
 double get previousBalance;/// Settlements this tenant PAID to other tenants this period (improves
/// their balance — reduces their due).
 double get settlementsPaid;/// Settlements this tenant RECEIVED from other tenants this period (reduces
/// their credit).
 double get settlementsReceived;/// 'shared' or 'fixed' — the contract used for this bill.
 String get billingMode;/// The negotiated per-unit price (fixed-rate tenants only).
 double? get fixedRate;/// This tenant's share of the month's recharge fees / other expenses.
 double get expenseShare;/// Reconciliation between the notional per-tenant slab bill and the
/// building's actual bill: positive means this tenant pays a bit more than
/// their own ladder walk (slab-sharing loss), negative a bit less.
 double get sharedAdjustment;/// Portion of [rechargePaid] that was fees rather than energy credit.
 double get rechargeFeesPaid;
/// Create a copy of TenantBill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantBillCopyWith<TenantBill> get copyWith => _$TenantBillCopyWithImpl<TenantBill>(this as TenantBill, _$identity);

  /// Serializes this TenantBill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantBill&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.previousReading, previousReading) || other.previousReading == previousReading)&&(identical(other.currentReading, currentReading) || other.currentReading == currentReading)&&(identical(other.ownUnits, ownUnits) || other.ownUnits == ownUnits)&&(identical(other.commonUnits, commonUnits) || other.commonUnits == commonUnits)&&(identical(other.billedUnits, billedUnits) || other.billedUnits == billedUnits)&&const DeepCollectionEquality().equals(other.slabBreakdown, slabBreakdown)&&(identical(other.energyCost, energyCost) || other.energyCost == energyCost)&&(identical(other.demandCharge, demandCharge) || other.demandCharge == demandCharge)&&(identical(other.meterRent, meterRent) || other.meterRent == meterRent)&&(identical(other.vat, vat) || other.vat == vat)&&(identical(other.rebate, rebate) || other.rebate == rebate)&&(identical(other.totalBill, totalBill) || other.totalBill == totalBill)&&(identical(other.rechargePaid, rechargePaid) || other.rechargePaid == rechargePaid)&&(identical(other.previousBalance, previousBalance) || other.previousBalance == previousBalance)&&(identical(other.settlementsPaid, settlementsPaid) || other.settlementsPaid == settlementsPaid)&&(identical(other.settlementsReceived, settlementsReceived) || other.settlementsReceived == settlementsReceived)&&(identical(other.billingMode, billingMode) || other.billingMode == billingMode)&&(identical(other.fixedRate, fixedRate) || other.fixedRate == fixedRate)&&(identical(other.expenseShare, expenseShare) || other.expenseShare == expenseShare)&&(identical(other.sharedAdjustment, sharedAdjustment) || other.sharedAdjustment == sharedAdjustment)&&(identical(other.rechargeFeesPaid, rechargeFeesPaid) || other.rechargeFeesPaid == rechargeFeesPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tenantId,tenantName,previousReading,currentReading,ownUnits,commonUnits,billedUnits,const DeepCollectionEquality().hash(slabBreakdown),energyCost,demandCharge,meterRent,vat,rebate,totalBill,rechargePaid,previousBalance,settlementsPaid,settlementsReceived,billingMode,fixedRate,expenseShare,sharedAdjustment,rechargeFeesPaid]);

@override
String toString() {
  return 'TenantBill(tenantId: $tenantId, tenantName: $tenantName, previousReading: $previousReading, currentReading: $currentReading, ownUnits: $ownUnits, commonUnits: $commonUnits, billedUnits: $billedUnits, slabBreakdown: $slabBreakdown, energyCost: $energyCost, demandCharge: $demandCharge, meterRent: $meterRent, vat: $vat, rebate: $rebate, totalBill: $totalBill, rechargePaid: $rechargePaid, previousBalance: $previousBalance, settlementsPaid: $settlementsPaid, settlementsReceived: $settlementsReceived, billingMode: $billingMode, fixedRate: $fixedRate, expenseShare: $expenseShare, sharedAdjustment: $sharedAdjustment, rechargeFeesPaid: $rechargeFeesPaid)';
}


}

/// @nodoc
abstract mixin class $TenantBillCopyWith<$Res>  {
  factory $TenantBillCopyWith(TenantBill value, $Res Function(TenantBill) _then) = _$TenantBillCopyWithImpl;
@useResult
$Res call({
 int tenantId, String tenantName, double previousReading, double currentReading, double ownUnits, double commonUnits, double billedUnits, List<SlabAllocation> slabBreakdown, double energyCost, double demandCharge, double meterRent, double vat, double rebate, double totalBill, double rechargePaid, double previousBalance, double settlementsPaid, double settlementsReceived, String billingMode, double? fixedRate, double expenseShare, double sharedAdjustment, double rechargeFeesPaid
});




}
/// @nodoc
class _$TenantBillCopyWithImpl<$Res>
    implements $TenantBillCopyWith<$Res> {
  _$TenantBillCopyWithImpl(this._self, this._then);

  final TenantBill _self;
  final $Res Function(TenantBill) _then;

/// Create a copy of TenantBill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenantId = null,Object? tenantName = null,Object? previousReading = null,Object? currentReading = null,Object? ownUnits = null,Object? commonUnits = null,Object? billedUnits = null,Object? slabBreakdown = null,Object? energyCost = null,Object? demandCharge = null,Object? meterRent = null,Object? vat = null,Object? rebate = null,Object? totalBill = null,Object? rechargePaid = null,Object? previousBalance = null,Object? settlementsPaid = null,Object? settlementsReceived = null,Object? billingMode = null,Object? fixedRate = freezed,Object? expenseShare = null,Object? sharedAdjustment = null,Object? rechargeFeesPaid = null,}) {
  return _then(_self.copyWith(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as int,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,previousReading: null == previousReading ? _self.previousReading : previousReading // ignore: cast_nullable_to_non_nullable
as double,currentReading: null == currentReading ? _self.currentReading : currentReading // ignore: cast_nullable_to_non_nullable
as double,ownUnits: null == ownUnits ? _self.ownUnits : ownUnits // ignore: cast_nullable_to_non_nullable
as double,commonUnits: null == commonUnits ? _self.commonUnits : commonUnits // ignore: cast_nullable_to_non_nullable
as double,billedUnits: null == billedUnits ? _self.billedUnits : billedUnits // ignore: cast_nullable_to_non_nullable
as double,slabBreakdown: null == slabBreakdown ? _self.slabBreakdown : slabBreakdown // ignore: cast_nullable_to_non_nullable
as List<SlabAllocation>,energyCost: null == energyCost ? _self.energyCost : energyCost // ignore: cast_nullable_to_non_nullable
as double,demandCharge: null == demandCharge ? _self.demandCharge : demandCharge // ignore: cast_nullable_to_non_nullable
as double,meterRent: null == meterRent ? _self.meterRent : meterRent // ignore: cast_nullable_to_non_nullable
as double,vat: null == vat ? _self.vat : vat // ignore: cast_nullable_to_non_nullable
as double,rebate: null == rebate ? _self.rebate : rebate // ignore: cast_nullable_to_non_nullable
as double,totalBill: null == totalBill ? _self.totalBill : totalBill // ignore: cast_nullable_to_non_nullable
as double,rechargePaid: null == rechargePaid ? _self.rechargePaid : rechargePaid // ignore: cast_nullable_to_non_nullable
as double,previousBalance: null == previousBalance ? _self.previousBalance : previousBalance // ignore: cast_nullable_to_non_nullable
as double,settlementsPaid: null == settlementsPaid ? _self.settlementsPaid : settlementsPaid // ignore: cast_nullable_to_non_nullable
as double,settlementsReceived: null == settlementsReceived ? _self.settlementsReceived : settlementsReceived // ignore: cast_nullable_to_non_nullable
as double,billingMode: null == billingMode ? _self.billingMode : billingMode // ignore: cast_nullable_to_non_nullable
as String,fixedRate: freezed == fixedRate ? _self.fixedRate : fixedRate // ignore: cast_nullable_to_non_nullable
as double?,expenseShare: null == expenseShare ? _self.expenseShare : expenseShare // ignore: cast_nullable_to_non_nullable
as double,sharedAdjustment: null == sharedAdjustment ? _self.sharedAdjustment : sharedAdjustment // ignore: cast_nullable_to_non_nullable
as double,rechargeFeesPaid: null == rechargeFeesPaid ? _self.rechargeFeesPaid : rechargeFeesPaid // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantBill].
extension TenantBillPatterns on TenantBill {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantBill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantBill() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantBill value)  $default,){
final _that = this;
switch (_that) {
case _TenantBill():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantBill value)?  $default,){
final _that = this;
switch (_that) {
case _TenantBill() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tenantId,  String tenantName,  double previousReading,  double currentReading,  double ownUnits,  double commonUnits,  double billedUnits,  List<SlabAllocation> slabBreakdown,  double energyCost,  double demandCharge,  double meterRent,  double vat,  double rebate,  double totalBill,  double rechargePaid,  double previousBalance,  double settlementsPaid,  double settlementsReceived,  String billingMode,  double? fixedRate,  double expenseShare,  double sharedAdjustment,  double rechargeFeesPaid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantBill() when $default != null:
return $default(_that.tenantId,_that.tenantName,_that.previousReading,_that.currentReading,_that.ownUnits,_that.commonUnits,_that.billedUnits,_that.slabBreakdown,_that.energyCost,_that.demandCharge,_that.meterRent,_that.vat,_that.rebate,_that.totalBill,_that.rechargePaid,_that.previousBalance,_that.settlementsPaid,_that.settlementsReceived,_that.billingMode,_that.fixedRate,_that.expenseShare,_that.sharedAdjustment,_that.rechargeFeesPaid);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tenantId,  String tenantName,  double previousReading,  double currentReading,  double ownUnits,  double commonUnits,  double billedUnits,  List<SlabAllocation> slabBreakdown,  double energyCost,  double demandCharge,  double meterRent,  double vat,  double rebate,  double totalBill,  double rechargePaid,  double previousBalance,  double settlementsPaid,  double settlementsReceived,  String billingMode,  double? fixedRate,  double expenseShare,  double sharedAdjustment,  double rechargeFeesPaid)  $default,) {final _that = this;
switch (_that) {
case _TenantBill():
return $default(_that.tenantId,_that.tenantName,_that.previousReading,_that.currentReading,_that.ownUnits,_that.commonUnits,_that.billedUnits,_that.slabBreakdown,_that.energyCost,_that.demandCharge,_that.meterRent,_that.vat,_that.rebate,_that.totalBill,_that.rechargePaid,_that.previousBalance,_that.settlementsPaid,_that.settlementsReceived,_that.billingMode,_that.fixedRate,_that.expenseShare,_that.sharedAdjustment,_that.rechargeFeesPaid);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tenantId,  String tenantName,  double previousReading,  double currentReading,  double ownUnits,  double commonUnits,  double billedUnits,  List<SlabAllocation> slabBreakdown,  double energyCost,  double demandCharge,  double meterRent,  double vat,  double rebate,  double totalBill,  double rechargePaid,  double previousBalance,  double settlementsPaid,  double settlementsReceived,  String billingMode,  double? fixedRate,  double expenseShare,  double sharedAdjustment,  double rechargeFeesPaid)?  $default,) {final _that = this;
switch (_that) {
case _TenantBill() when $default != null:
return $default(_that.tenantId,_that.tenantName,_that.previousReading,_that.currentReading,_that.ownUnits,_that.commonUnits,_that.billedUnits,_that.slabBreakdown,_that.energyCost,_that.demandCharge,_that.meterRent,_that.vat,_that.rebate,_that.totalBill,_that.rechargePaid,_that.previousBalance,_that.settlementsPaid,_that.settlementsReceived,_that.billingMode,_that.fixedRate,_that.expenseShare,_that.sharedAdjustment,_that.rechargeFeesPaid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantBill extends TenantBill {
  const _TenantBill({required this.tenantId, required this.tenantName, required this.previousReading, required this.currentReading, required this.ownUnits, required this.commonUnits, required this.billedUnits, required final  List<SlabAllocation> slabBreakdown, required this.energyCost, required this.demandCharge, required this.meterRent, required this.vat, required this.rebate, required this.totalBill, required this.rechargePaid, this.previousBalance = 0, this.settlementsPaid = 0, this.settlementsReceived = 0, this.billingMode = 'shared', this.fixedRate, this.expenseShare = 0, this.sharedAdjustment = 0, this.rechargeFeesPaid = 0}): _slabBreakdown = slabBreakdown,super._();
  factory _TenantBill.fromJson(Map<String, dynamic> json) => _$TenantBillFromJson(json);

@override final  int tenantId;
@override final  String tenantName;
@override final  double previousReading;
@override final  double currentReading;
/// Units measured directly on the tenant's sub-meter.
@override final  double ownUnits;
/// Common-area units allocated to this tenant (proportional share).
@override final  double commonUnits;
/// [ownUnits] + [commonUnits] — the units this tenant is billed for.
@override final  double billedUnits;
 final  List<SlabAllocation> _slabBreakdown;
@override List<SlabAllocation> get slabBreakdown {
  if (_slabBreakdown is EqualUnmodifiableListView) return _slabBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slabBreakdown);
}

@override final  double energyCost;
@override final  double demandCharge;
@override final  double meterRent;
@override final  double vat;
@override final  double rebate;
/// Net amount owed by the tenant before recharge reconciliation.
@override final  double totalBill;
/// Total recharges attributed to this tenant (matched by payer name).
@override final  double rechargePaid;
/// Prepaid balance carried in from previous periods (can be negative for a
/// past-due tenant).
@override@JsonKey() final  double previousBalance;
/// Settlements this tenant PAID to other tenants this period (improves
/// their balance — reduces their due).
@override@JsonKey() final  double settlementsPaid;
/// Settlements this tenant RECEIVED from other tenants this period (reduces
/// their credit).
@override@JsonKey() final  double settlementsReceived;
/// 'shared' or 'fixed' — the contract used for this bill.
@override@JsonKey() final  String billingMode;
/// The negotiated per-unit price (fixed-rate tenants only).
@override final  double? fixedRate;
/// This tenant's share of the month's recharge fees / other expenses.
@override@JsonKey() final  double expenseShare;
/// Reconciliation between the notional per-tenant slab bill and the
/// building's actual bill: positive means this tenant pays a bit more than
/// their own ladder walk (slab-sharing loss), negative a bit less.
@override@JsonKey() final  double sharedAdjustment;
/// Portion of [rechargePaid] that was fees rather than energy credit.
@override@JsonKey() final  double rechargeFeesPaid;

/// Create a copy of TenantBill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantBillCopyWith<_TenantBill> get copyWith => __$TenantBillCopyWithImpl<_TenantBill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantBillToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantBill&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.previousReading, previousReading) || other.previousReading == previousReading)&&(identical(other.currentReading, currentReading) || other.currentReading == currentReading)&&(identical(other.ownUnits, ownUnits) || other.ownUnits == ownUnits)&&(identical(other.commonUnits, commonUnits) || other.commonUnits == commonUnits)&&(identical(other.billedUnits, billedUnits) || other.billedUnits == billedUnits)&&const DeepCollectionEquality().equals(other._slabBreakdown, _slabBreakdown)&&(identical(other.energyCost, energyCost) || other.energyCost == energyCost)&&(identical(other.demandCharge, demandCharge) || other.demandCharge == demandCharge)&&(identical(other.meterRent, meterRent) || other.meterRent == meterRent)&&(identical(other.vat, vat) || other.vat == vat)&&(identical(other.rebate, rebate) || other.rebate == rebate)&&(identical(other.totalBill, totalBill) || other.totalBill == totalBill)&&(identical(other.rechargePaid, rechargePaid) || other.rechargePaid == rechargePaid)&&(identical(other.previousBalance, previousBalance) || other.previousBalance == previousBalance)&&(identical(other.settlementsPaid, settlementsPaid) || other.settlementsPaid == settlementsPaid)&&(identical(other.settlementsReceived, settlementsReceived) || other.settlementsReceived == settlementsReceived)&&(identical(other.billingMode, billingMode) || other.billingMode == billingMode)&&(identical(other.fixedRate, fixedRate) || other.fixedRate == fixedRate)&&(identical(other.expenseShare, expenseShare) || other.expenseShare == expenseShare)&&(identical(other.sharedAdjustment, sharedAdjustment) || other.sharedAdjustment == sharedAdjustment)&&(identical(other.rechargeFeesPaid, rechargeFeesPaid) || other.rechargeFeesPaid == rechargeFeesPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tenantId,tenantName,previousReading,currentReading,ownUnits,commonUnits,billedUnits,const DeepCollectionEquality().hash(_slabBreakdown),energyCost,demandCharge,meterRent,vat,rebate,totalBill,rechargePaid,previousBalance,settlementsPaid,settlementsReceived,billingMode,fixedRate,expenseShare,sharedAdjustment,rechargeFeesPaid]);

@override
String toString() {
  return 'TenantBill(tenantId: $tenantId, tenantName: $tenantName, previousReading: $previousReading, currentReading: $currentReading, ownUnits: $ownUnits, commonUnits: $commonUnits, billedUnits: $billedUnits, slabBreakdown: $slabBreakdown, energyCost: $energyCost, demandCharge: $demandCharge, meterRent: $meterRent, vat: $vat, rebate: $rebate, totalBill: $totalBill, rechargePaid: $rechargePaid, previousBalance: $previousBalance, settlementsPaid: $settlementsPaid, settlementsReceived: $settlementsReceived, billingMode: $billingMode, fixedRate: $fixedRate, expenseShare: $expenseShare, sharedAdjustment: $sharedAdjustment, rechargeFeesPaid: $rechargeFeesPaid)';
}


}

/// @nodoc
abstract mixin class _$TenantBillCopyWith<$Res> implements $TenantBillCopyWith<$Res> {
  factory _$TenantBillCopyWith(_TenantBill value, $Res Function(_TenantBill) _then) = __$TenantBillCopyWithImpl;
@override @useResult
$Res call({
 int tenantId, String tenantName, double previousReading, double currentReading, double ownUnits, double commonUnits, double billedUnits, List<SlabAllocation> slabBreakdown, double energyCost, double demandCharge, double meterRent, double vat, double rebate, double totalBill, double rechargePaid, double previousBalance, double settlementsPaid, double settlementsReceived, String billingMode, double? fixedRate, double expenseShare, double sharedAdjustment, double rechargeFeesPaid
});




}
/// @nodoc
class __$TenantBillCopyWithImpl<$Res>
    implements _$TenantBillCopyWith<$Res> {
  __$TenantBillCopyWithImpl(this._self, this._then);

  final _TenantBill _self;
  final $Res Function(_TenantBill) _then;

/// Create a copy of TenantBill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenantId = null,Object? tenantName = null,Object? previousReading = null,Object? currentReading = null,Object? ownUnits = null,Object? commonUnits = null,Object? billedUnits = null,Object? slabBreakdown = null,Object? energyCost = null,Object? demandCharge = null,Object? meterRent = null,Object? vat = null,Object? rebate = null,Object? totalBill = null,Object? rechargePaid = null,Object? previousBalance = null,Object? settlementsPaid = null,Object? settlementsReceived = null,Object? billingMode = null,Object? fixedRate = freezed,Object? expenseShare = null,Object? sharedAdjustment = null,Object? rechargeFeesPaid = null,}) {
  return _then(_TenantBill(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as int,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,previousReading: null == previousReading ? _self.previousReading : previousReading // ignore: cast_nullable_to_non_nullable
as double,currentReading: null == currentReading ? _self.currentReading : currentReading // ignore: cast_nullable_to_non_nullable
as double,ownUnits: null == ownUnits ? _self.ownUnits : ownUnits // ignore: cast_nullable_to_non_nullable
as double,commonUnits: null == commonUnits ? _self.commonUnits : commonUnits // ignore: cast_nullable_to_non_nullable
as double,billedUnits: null == billedUnits ? _self.billedUnits : billedUnits // ignore: cast_nullable_to_non_nullable
as double,slabBreakdown: null == slabBreakdown ? _self._slabBreakdown : slabBreakdown // ignore: cast_nullable_to_non_nullable
as List<SlabAllocation>,energyCost: null == energyCost ? _self.energyCost : energyCost // ignore: cast_nullable_to_non_nullable
as double,demandCharge: null == demandCharge ? _self.demandCharge : demandCharge // ignore: cast_nullable_to_non_nullable
as double,meterRent: null == meterRent ? _self.meterRent : meterRent // ignore: cast_nullable_to_non_nullable
as double,vat: null == vat ? _self.vat : vat // ignore: cast_nullable_to_non_nullable
as double,rebate: null == rebate ? _self.rebate : rebate // ignore: cast_nullable_to_non_nullable
as double,totalBill: null == totalBill ? _self.totalBill : totalBill // ignore: cast_nullable_to_non_nullable
as double,rechargePaid: null == rechargePaid ? _self.rechargePaid : rechargePaid // ignore: cast_nullable_to_non_nullable
as double,previousBalance: null == previousBalance ? _self.previousBalance : previousBalance // ignore: cast_nullable_to_non_nullable
as double,settlementsPaid: null == settlementsPaid ? _self.settlementsPaid : settlementsPaid // ignore: cast_nullable_to_non_nullable
as double,settlementsReceived: null == settlementsReceived ? _self.settlementsReceived : settlementsReceived // ignore: cast_nullable_to_non_nullable
as double,billingMode: null == billingMode ? _self.billingMode : billingMode // ignore: cast_nullable_to_non_nullable
as String,fixedRate: freezed == fixedRate ? _self.fixedRate : fixedRate // ignore: cast_nullable_to_non_nullable
as double?,expenseShare: null == expenseShare ? _self.expenseShare : expenseShare // ignore: cast_nullable_to_non_nullable
as double,sharedAdjustment: null == sharedAdjustment ? _self.sharedAdjustment : sharedAdjustment // ignore: cast_nullable_to_non_nullable
as double,rechargeFeesPaid: null == rechargeFeesPaid ? _self.rechargeFeesPaid : rechargeFeesPaid // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MonthlyBill {

 double get mainMeterUnits; double get totalTenantUnits; double get commonAreaUnits; List<TenantBill> get tenantBills; double get totalRecharge;/// The building's actual utility bill (energy + fixed charges + VAT −
/// rebate + expenses).
 double get buildingBill;/// Recharge fees + other expenses recorded this month.
 double get totalExpenses;/// Calculation mode this bill was computed with ('sharedSlab' |
/// 'reconciled' | 'fixedRate'). Snapshotted on finalize so historical
/// months render under their original rules.
 String get calcMode;/// Shared-Slab (Landlord) mode only: Σ tenant bills − actual main-meter
/// bill. Positive = Owner Benefit, negative = Owner Loss. Always 0 in the
/// reconciled modes. Owner-facing ONLY — never shown on tenant invoices.
 double get ownerBenefit;
/// Create a copy of MonthlyBill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlyBillCopyWith<MonthlyBill> get copyWith => _$MonthlyBillCopyWithImpl<MonthlyBill>(this as MonthlyBill, _$identity);

  /// Serializes this MonthlyBill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlyBill&&(identical(other.mainMeterUnits, mainMeterUnits) || other.mainMeterUnits == mainMeterUnits)&&(identical(other.totalTenantUnits, totalTenantUnits) || other.totalTenantUnits == totalTenantUnits)&&(identical(other.commonAreaUnits, commonAreaUnits) || other.commonAreaUnits == commonAreaUnits)&&const DeepCollectionEquality().equals(other.tenantBills, tenantBills)&&(identical(other.totalRecharge, totalRecharge) || other.totalRecharge == totalRecharge)&&(identical(other.buildingBill, buildingBill) || other.buildingBill == buildingBill)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.calcMode, calcMode) || other.calcMode == calcMode)&&(identical(other.ownerBenefit, ownerBenefit) || other.ownerBenefit == ownerBenefit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mainMeterUnits,totalTenantUnits,commonAreaUnits,const DeepCollectionEquality().hash(tenantBills),totalRecharge,buildingBill,totalExpenses,calcMode,ownerBenefit);

@override
String toString() {
  return 'MonthlyBill(mainMeterUnits: $mainMeterUnits, totalTenantUnits: $totalTenantUnits, commonAreaUnits: $commonAreaUnits, tenantBills: $tenantBills, totalRecharge: $totalRecharge, buildingBill: $buildingBill, totalExpenses: $totalExpenses, calcMode: $calcMode, ownerBenefit: $ownerBenefit)';
}


}

/// @nodoc
abstract mixin class $MonthlyBillCopyWith<$Res>  {
  factory $MonthlyBillCopyWith(MonthlyBill value, $Res Function(MonthlyBill) _then) = _$MonthlyBillCopyWithImpl;
@useResult
$Res call({
 double mainMeterUnits, double totalTenantUnits, double commonAreaUnits, List<TenantBill> tenantBills, double totalRecharge, double buildingBill, double totalExpenses, String calcMode, double ownerBenefit
});




}
/// @nodoc
class _$MonthlyBillCopyWithImpl<$Res>
    implements $MonthlyBillCopyWith<$Res> {
  _$MonthlyBillCopyWithImpl(this._self, this._then);

  final MonthlyBill _self;
  final $Res Function(MonthlyBill) _then;

/// Create a copy of MonthlyBill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainMeterUnits = null,Object? totalTenantUnits = null,Object? commonAreaUnits = null,Object? tenantBills = null,Object? totalRecharge = null,Object? buildingBill = null,Object? totalExpenses = null,Object? calcMode = null,Object? ownerBenefit = null,}) {
  return _then(_self.copyWith(
mainMeterUnits: null == mainMeterUnits ? _self.mainMeterUnits : mainMeterUnits // ignore: cast_nullable_to_non_nullable
as double,totalTenantUnits: null == totalTenantUnits ? _self.totalTenantUnits : totalTenantUnits // ignore: cast_nullable_to_non_nullable
as double,commonAreaUnits: null == commonAreaUnits ? _self.commonAreaUnits : commonAreaUnits // ignore: cast_nullable_to_non_nullable
as double,tenantBills: null == tenantBills ? _self.tenantBills : tenantBills // ignore: cast_nullable_to_non_nullable
as List<TenantBill>,totalRecharge: null == totalRecharge ? _self.totalRecharge : totalRecharge // ignore: cast_nullable_to_non_nullable
as double,buildingBill: null == buildingBill ? _self.buildingBill : buildingBill // ignore: cast_nullable_to_non_nullable
as double,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as double,calcMode: null == calcMode ? _self.calcMode : calcMode // ignore: cast_nullable_to_non_nullable
as String,ownerBenefit: null == ownerBenefit ? _self.ownerBenefit : ownerBenefit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlyBill].
extension MonthlyBillPatterns on MonthlyBill {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlyBill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlyBill() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlyBill value)  $default,){
final _that = this;
switch (_that) {
case _MonthlyBill():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlyBill value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlyBill() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double mainMeterUnits,  double totalTenantUnits,  double commonAreaUnits,  List<TenantBill> tenantBills,  double totalRecharge,  double buildingBill,  double totalExpenses,  String calcMode,  double ownerBenefit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlyBill() when $default != null:
return $default(_that.mainMeterUnits,_that.totalTenantUnits,_that.commonAreaUnits,_that.tenantBills,_that.totalRecharge,_that.buildingBill,_that.totalExpenses,_that.calcMode,_that.ownerBenefit);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double mainMeterUnits,  double totalTenantUnits,  double commonAreaUnits,  List<TenantBill> tenantBills,  double totalRecharge,  double buildingBill,  double totalExpenses,  String calcMode,  double ownerBenefit)  $default,) {final _that = this;
switch (_that) {
case _MonthlyBill():
return $default(_that.mainMeterUnits,_that.totalTenantUnits,_that.commonAreaUnits,_that.tenantBills,_that.totalRecharge,_that.buildingBill,_that.totalExpenses,_that.calcMode,_that.ownerBenefit);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double mainMeterUnits,  double totalTenantUnits,  double commonAreaUnits,  List<TenantBill> tenantBills,  double totalRecharge,  double buildingBill,  double totalExpenses,  String calcMode,  double ownerBenefit)?  $default,) {final _that = this;
switch (_that) {
case _MonthlyBill() when $default != null:
return $default(_that.mainMeterUnits,_that.totalTenantUnits,_that.commonAreaUnits,_that.tenantBills,_that.totalRecharge,_that.buildingBill,_that.totalExpenses,_that.calcMode,_that.ownerBenefit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlyBill extends MonthlyBill {
  const _MonthlyBill({required this.mainMeterUnits, required this.totalTenantUnits, required this.commonAreaUnits, required final  List<TenantBill> tenantBills, required this.totalRecharge, this.buildingBill = 0, this.totalExpenses = 0, this.calcMode = 'sharedSlab', this.ownerBenefit = 0}): _tenantBills = tenantBills,super._();
  factory _MonthlyBill.fromJson(Map<String, dynamic> json) => _$MonthlyBillFromJson(json);

@override final  double mainMeterUnits;
@override final  double totalTenantUnits;
@override final  double commonAreaUnits;
 final  List<TenantBill> _tenantBills;
@override List<TenantBill> get tenantBills {
  if (_tenantBills is EqualUnmodifiableListView) return _tenantBills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tenantBills);
}

@override final  double totalRecharge;
/// The building's actual utility bill (energy + fixed charges + VAT −
/// rebate + expenses).
@override@JsonKey() final  double buildingBill;
/// Recharge fees + other expenses recorded this month.
@override@JsonKey() final  double totalExpenses;
/// Calculation mode this bill was computed with ('sharedSlab' |
/// 'reconciled' | 'fixedRate'). Snapshotted on finalize so historical
/// months render under their original rules.
@override@JsonKey() final  String calcMode;
/// Shared-Slab (Landlord) mode only: Σ tenant bills − actual main-meter
/// bill. Positive = Owner Benefit, negative = Owner Loss. Always 0 in the
/// reconciled modes. Owner-facing ONLY — never shown on tenant invoices.
@override@JsonKey() final  double ownerBenefit;

/// Create a copy of MonthlyBill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlyBillCopyWith<_MonthlyBill> get copyWith => __$MonthlyBillCopyWithImpl<_MonthlyBill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlyBillToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlyBill&&(identical(other.mainMeterUnits, mainMeterUnits) || other.mainMeterUnits == mainMeterUnits)&&(identical(other.totalTenantUnits, totalTenantUnits) || other.totalTenantUnits == totalTenantUnits)&&(identical(other.commonAreaUnits, commonAreaUnits) || other.commonAreaUnits == commonAreaUnits)&&const DeepCollectionEquality().equals(other._tenantBills, _tenantBills)&&(identical(other.totalRecharge, totalRecharge) || other.totalRecharge == totalRecharge)&&(identical(other.buildingBill, buildingBill) || other.buildingBill == buildingBill)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.calcMode, calcMode) || other.calcMode == calcMode)&&(identical(other.ownerBenefit, ownerBenefit) || other.ownerBenefit == ownerBenefit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mainMeterUnits,totalTenantUnits,commonAreaUnits,const DeepCollectionEquality().hash(_tenantBills),totalRecharge,buildingBill,totalExpenses,calcMode,ownerBenefit);

@override
String toString() {
  return 'MonthlyBill(mainMeterUnits: $mainMeterUnits, totalTenantUnits: $totalTenantUnits, commonAreaUnits: $commonAreaUnits, tenantBills: $tenantBills, totalRecharge: $totalRecharge, buildingBill: $buildingBill, totalExpenses: $totalExpenses, calcMode: $calcMode, ownerBenefit: $ownerBenefit)';
}


}

/// @nodoc
abstract mixin class _$MonthlyBillCopyWith<$Res> implements $MonthlyBillCopyWith<$Res> {
  factory _$MonthlyBillCopyWith(_MonthlyBill value, $Res Function(_MonthlyBill) _then) = __$MonthlyBillCopyWithImpl;
@override @useResult
$Res call({
 double mainMeterUnits, double totalTenantUnits, double commonAreaUnits, List<TenantBill> tenantBills, double totalRecharge, double buildingBill, double totalExpenses, String calcMode, double ownerBenefit
});




}
/// @nodoc
class __$MonthlyBillCopyWithImpl<$Res>
    implements _$MonthlyBillCopyWith<$Res> {
  __$MonthlyBillCopyWithImpl(this._self, this._then);

  final _MonthlyBill _self;
  final $Res Function(_MonthlyBill) _then;

/// Create a copy of MonthlyBill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainMeterUnits = null,Object? totalTenantUnits = null,Object? commonAreaUnits = null,Object? tenantBills = null,Object? totalRecharge = null,Object? buildingBill = null,Object? totalExpenses = null,Object? calcMode = null,Object? ownerBenefit = null,}) {
  return _then(_MonthlyBill(
mainMeterUnits: null == mainMeterUnits ? _self.mainMeterUnits : mainMeterUnits // ignore: cast_nullable_to_non_nullable
as double,totalTenantUnits: null == totalTenantUnits ? _self.totalTenantUnits : totalTenantUnits // ignore: cast_nullable_to_non_nullable
as double,commonAreaUnits: null == commonAreaUnits ? _self.commonAreaUnits : commonAreaUnits // ignore: cast_nullable_to_non_nullable
as double,tenantBills: null == tenantBills ? _self._tenantBills : tenantBills // ignore: cast_nullable_to_non_nullable
as List<TenantBill>,totalRecharge: null == totalRecharge ? _self.totalRecharge : totalRecharge // ignore: cast_nullable_to_non_nullable
as double,buildingBill: null == buildingBill ? _self.buildingBill : buildingBill // ignore: cast_nullable_to_non_nullable
as double,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as double,calcMode: null == calcMode ? _self.calcMode : calcMode // ignore: cast_nullable_to_non_nullable
as String,ownerBenefit: null == ownerBenefit ? _self.ownerBenefit : ownerBenefit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
