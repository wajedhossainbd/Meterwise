// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tariff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TariffSlabRange {

 int get fromUnit; double get rate; int? get toUnit;
/// Create a copy of TariffSlabRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TariffSlabRangeCopyWith<TariffSlabRange> get copyWith => _$TariffSlabRangeCopyWithImpl<TariffSlabRange>(this as TariffSlabRange, _$identity);

  /// Serializes this TariffSlabRange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TariffSlabRange&&(identical(other.fromUnit, fromUnit) || other.fromUnit == fromUnit)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.toUnit, toUnit) || other.toUnit == toUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromUnit,rate,toUnit);

@override
String toString() {
  return 'TariffSlabRange(fromUnit: $fromUnit, rate: $rate, toUnit: $toUnit)';
}


}

/// @nodoc
abstract mixin class $TariffSlabRangeCopyWith<$Res>  {
  factory $TariffSlabRangeCopyWith(TariffSlabRange value, $Res Function(TariffSlabRange) _then) = _$TariffSlabRangeCopyWithImpl;
@useResult
$Res call({
 int fromUnit, double rate, int? toUnit
});




}
/// @nodoc
class _$TariffSlabRangeCopyWithImpl<$Res>
    implements $TariffSlabRangeCopyWith<$Res> {
  _$TariffSlabRangeCopyWithImpl(this._self, this._then);

  final TariffSlabRange _self;
  final $Res Function(TariffSlabRange) _then;

/// Create a copy of TariffSlabRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromUnit = null,Object? rate = null,Object? toUnit = freezed,}) {
  return _then(_self.copyWith(
fromUnit: null == fromUnit ? _self.fromUnit : fromUnit // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,toUnit: freezed == toUnit ? _self.toUnit : toUnit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TariffSlabRange].
extension TariffSlabRangePatterns on TariffSlabRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TariffSlabRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TariffSlabRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TariffSlabRange value)  $default,){
final _that = this;
switch (_that) {
case _TariffSlabRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TariffSlabRange value)?  $default,){
final _that = this;
switch (_that) {
case _TariffSlabRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fromUnit,  double rate,  int? toUnit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TariffSlabRange() when $default != null:
return $default(_that.fromUnit,_that.rate,_that.toUnit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fromUnit,  double rate,  int? toUnit)  $default,) {final _that = this;
switch (_that) {
case _TariffSlabRange():
return $default(_that.fromUnit,_that.rate,_that.toUnit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fromUnit,  double rate,  int? toUnit)?  $default,) {final _that = this;
switch (_that) {
case _TariffSlabRange() when $default != null:
return $default(_that.fromUnit,_that.rate,_that.toUnit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TariffSlabRange implements TariffSlabRange {
  const _TariffSlabRange({required this.fromUnit, required this.rate, this.toUnit});
  factory _TariffSlabRange.fromJson(Map<String, dynamic> json) => _$TariffSlabRangeFromJson(json);

@override final  int fromUnit;
@override final  double rate;
@override final  int? toUnit;

/// Create a copy of TariffSlabRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TariffSlabRangeCopyWith<_TariffSlabRange> get copyWith => __$TariffSlabRangeCopyWithImpl<_TariffSlabRange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TariffSlabRangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TariffSlabRange&&(identical(other.fromUnit, fromUnit) || other.fromUnit == fromUnit)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.toUnit, toUnit) || other.toUnit == toUnit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromUnit,rate,toUnit);

@override
String toString() {
  return 'TariffSlabRange(fromUnit: $fromUnit, rate: $rate, toUnit: $toUnit)';
}


}

/// @nodoc
abstract mixin class _$TariffSlabRangeCopyWith<$Res> implements $TariffSlabRangeCopyWith<$Res> {
  factory _$TariffSlabRangeCopyWith(_TariffSlabRange value, $Res Function(_TariffSlabRange) _then) = __$TariffSlabRangeCopyWithImpl;
@override @useResult
$Res call({
 int fromUnit, double rate, int? toUnit
});




}
/// @nodoc
class __$TariffSlabRangeCopyWithImpl<$Res>
    implements _$TariffSlabRangeCopyWith<$Res> {
  __$TariffSlabRangeCopyWithImpl(this._self, this._then);

  final _TariffSlabRange _self;
  final $Res Function(_TariffSlabRange) _then;

/// Create a copy of TariffSlabRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromUnit = null,Object? rate = null,Object? toUnit = freezed,}) {
  return _then(_TariffSlabRange(
fromUnit: null == fromUnit ? _self.fromUnit : fromUnit // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,toUnit: freezed == toUnit ? _self.toUnit : toUnit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Tariff {

 List<TariffSlabRange> get slabs; double get demandCharge; double get meterRent; double get vatPercent; double get rebatePercent; String get currencyCode;/// Optional lifeline block (official BD structure): when total consumption
/// is ≤ [lifelineUpTo] units, the *entire* consumption is charged at
/// [lifelineRate] instead of walking the slab ladder.
 int? get lifelineUpTo; double? get lifelineRate;
/// Create a copy of Tariff
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TariffCopyWith<Tariff> get copyWith => _$TariffCopyWithImpl<Tariff>(this as Tariff, _$identity);

  /// Serializes this Tariff to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tariff&&const DeepCollectionEquality().equals(other.slabs, slabs)&&(identical(other.demandCharge, demandCharge) || other.demandCharge == demandCharge)&&(identical(other.meterRent, meterRent) || other.meterRent == meterRent)&&(identical(other.vatPercent, vatPercent) || other.vatPercent == vatPercent)&&(identical(other.rebatePercent, rebatePercent) || other.rebatePercent == rebatePercent)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.lifelineUpTo, lifelineUpTo) || other.lifelineUpTo == lifelineUpTo)&&(identical(other.lifelineRate, lifelineRate) || other.lifelineRate == lifelineRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(slabs),demandCharge,meterRent,vatPercent,rebatePercent,currencyCode,lifelineUpTo,lifelineRate);

@override
String toString() {
  return 'Tariff(slabs: $slabs, demandCharge: $demandCharge, meterRent: $meterRent, vatPercent: $vatPercent, rebatePercent: $rebatePercent, currencyCode: $currencyCode, lifelineUpTo: $lifelineUpTo, lifelineRate: $lifelineRate)';
}


}

/// @nodoc
abstract mixin class $TariffCopyWith<$Res>  {
  factory $TariffCopyWith(Tariff value, $Res Function(Tariff) _then) = _$TariffCopyWithImpl;
@useResult
$Res call({
 List<TariffSlabRange> slabs, double demandCharge, double meterRent, double vatPercent, double rebatePercent, String currencyCode, int? lifelineUpTo, double? lifelineRate
});




}
/// @nodoc
class _$TariffCopyWithImpl<$Res>
    implements $TariffCopyWith<$Res> {
  _$TariffCopyWithImpl(this._self, this._then);

  final Tariff _self;
  final $Res Function(Tariff) _then;

/// Create a copy of Tariff
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slabs = null,Object? demandCharge = null,Object? meterRent = null,Object? vatPercent = null,Object? rebatePercent = null,Object? currencyCode = null,Object? lifelineUpTo = freezed,Object? lifelineRate = freezed,}) {
  return _then(_self.copyWith(
slabs: null == slabs ? _self.slabs : slabs // ignore: cast_nullable_to_non_nullable
as List<TariffSlabRange>,demandCharge: null == demandCharge ? _self.demandCharge : demandCharge // ignore: cast_nullable_to_non_nullable
as double,meterRent: null == meterRent ? _self.meterRent : meterRent // ignore: cast_nullable_to_non_nullable
as double,vatPercent: null == vatPercent ? _self.vatPercent : vatPercent // ignore: cast_nullable_to_non_nullable
as double,rebatePercent: null == rebatePercent ? _self.rebatePercent : rebatePercent // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,lifelineUpTo: freezed == lifelineUpTo ? _self.lifelineUpTo : lifelineUpTo // ignore: cast_nullable_to_non_nullable
as int?,lifelineRate: freezed == lifelineRate ? _self.lifelineRate : lifelineRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Tariff].
extension TariffPatterns on Tariff {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tariff value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tariff() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tariff value)  $default,){
final _that = this;
switch (_that) {
case _Tariff():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tariff value)?  $default,){
final _that = this;
switch (_that) {
case _Tariff() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TariffSlabRange> slabs,  double demandCharge,  double meterRent,  double vatPercent,  double rebatePercent,  String currencyCode,  int? lifelineUpTo,  double? lifelineRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tariff() when $default != null:
return $default(_that.slabs,_that.demandCharge,_that.meterRent,_that.vatPercent,_that.rebatePercent,_that.currencyCode,_that.lifelineUpTo,_that.lifelineRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TariffSlabRange> slabs,  double demandCharge,  double meterRent,  double vatPercent,  double rebatePercent,  String currencyCode,  int? lifelineUpTo,  double? lifelineRate)  $default,) {final _that = this;
switch (_that) {
case _Tariff():
return $default(_that.slabs,_that.demandCharge,_that.meterRent,_that.vatPercent,_that.rebatePercent,_that.currencyCode,_that.lifelineUpTo,_that.lifelineRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TariffSlabRange> slabs,  double demandCharge,  double meterRent,  double vatPercent,  double rebatePercent,  String currencyCode,  int? lifelineUpTo,  double? lifelineRate)?  $default,) {final _that = this;
switch (_that) {
case _Tariff() when $default != null:
return $default(_that.slabs,_that.demandCharge,_that.meterRent,_that.vatPercent,_that.rebatePercent,_that.currencyCode,_that.lifelineUpTo,_that.lifelineRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Tariff implements Tariff {
  const _Tariff({required final  List<TariffSlabRange> slabs, required this.demandCharge, required this.meterRent, required this.vatPercent, required this.rebatePercent, this.currencyCode = 'BDT', this.lifelineUpTo, this.lifelineRate}): _slabs = slabs;
  factory _Tariff.fromJson(Map<String, dynamic> json) => _$TariffFromJson(json);

 final  List<TariffSlabRange> _slabs;
@override List<TariffSlabRange> get slabs {
  if (_slabs is EqualUnmodifiableListView) return _slabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slabs);
}

@override final  double demandCharge;
@override final  double meterRent;
@override final  double vatPercent;
@override final  double rebatePercent;
@override@JsonKey() final  String currencyCode;
/// Optional lifeline block (official BD structure): when total consumption
/// is ≤ [lifelineUpTo] units, the *entire* consumption is charged at
/// [lifelineRate] instead of walking the slab ladder.
@override final  int? lifelineUpTo;
@override final  double? lifelineRate;

/// Create a copy of Tariff
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TariffCopyWith<_Tariff> get copyWith => __$TariffCopyWithImpl<_Tariff>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TariffToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tariff&&const DeepCollectionEquality().equals(other._slabs, _slabs)&&(identical(other.demandCharge, demandCharge) || other.demandCharge == demandCharge)&&(identical(other.meterRent, meterRent) || other.meterRent == meterRent)&&(identical(other.vatPercent, vatPercent) || other.vatPercent == vatPercent)&&(identical(other.rebatePercent, rebatePercent) || other.rebatePercent == rebatePercent)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.lifelineUpTo, lifelineUpTo) || other.lifelineUpTo == lifelineUpTo)&&(identical(other.lifelineRate, lifelineRate) || other.lifelineRate == lifelineRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_slabs),demandCharge,meterRent,vatPercent,rebatePercent,currencyCode,lifelineUpTo,lifelineRate);

@override
String toString() {
  return 'Tariff(slabs: $slabs, demandCharge: $demandCharge, meterRent: $meterRent, vatPercent: $vatPercent, rebatePercent: $rebatePercent, currencyCode: $currencyCode, lifelineUpTo: $lifelineUpTo, lifelineRate: $lifelineRate)';
}


}

/// @nodoc
abstract mixin class _$TariffCopyWith<$Res> implements $TariffCopyWith<$Res> {
  factory _$TariffCopyWith(_Tariff value, $Res Function(_Tariff) _then) = __$TariffCopyWithImpl;
@override @useResult
$Res call({
 List<TariffSlabRange> slabs, double demandCharge, double meterRent, double vatPercent, double rebatePercent, String currencyCode, int? lifelineUpTo, double? lifelineRate
});




}
/// @nodoc
class __$TariffCopyWithImpl<$Res>
    implements _$TariffCopyWith<$Res> {
  __$TariffCopyWithImpl(this._self, this._then);

  final _Tariff _self;
  final $Res Function(_Tariff) _then;

/// Create a copy of Tariff
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slabs = null,Object? demandCharge = null,Object? meterRent = null,Object? vatPercent = null,Object? rebatePercent = null,Object? currencyCode = null,Object? lifelineUpTo = freezed,Object? lifelineRate = freezed,}) {
  return _then(_Tariff(
slabs: null == slabs ? _self._slabs : slabs // ignore: cast_nullable_to_non_nullable
as List<TariffSlabRange>,demandCharge: null == demandCharge ? _self.demandCharge : demandCharge // ignore: cast_nullable_to_non_nullable
as double,meterRent: null == meterRent ? _self.meterRent : meterRent // ignore: cast_nullable_to_non_nullable
as double,vatPercent: null == vatPercent ? _self.vatPercent : vatPercent // ignore: cast_nullable_to_non_nullable
as double,rebatePercent: null == rebatePercent ? _self.rebatePercent : rebatePercent // ignore: cast_nullable_to_non_nullable
as double,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,lifelineUpTo: freezed == lifelineUpTo ? _self.lifelineUpTo : lifelineUpTo // ignore: cast_nullable_to_non_nullable
as int?,lifelineRate: freezed == lifelineRate ? _self.lifelineRate : lifelineRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
