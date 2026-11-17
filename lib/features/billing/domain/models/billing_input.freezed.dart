// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeterReadingPair {

 double get previous; double get current;
/// Create a copy of MeterReadingPair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterReadingPairCopyWith<MeterReadingPair> get copyWith => _$MeterReadingPairCopyWithImpl<MeterReadingPair>(this as MeterReadingPair, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterReadingPair&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current));
}


@override
int get hashCode => Object.hash(runtimeType,previous,current);

@override
String toString() {
  return 'MeterReadingPair(previous: $previous, current: $current)';
}


}

/// @nodoc
abstract mixin class $MeterReadingPairCopyWith<$Res>  {
  factory $MeterReadingPairCopyWith(MeterReadingPair value, $Res Function(MeterReadingPair) _then) = _$MeterReadingPairCopyWithImpl;
@useResult
$Res call({
 double previous, double current
});




}
/// @nodoc
class _$MeterReadingPairCopyWithImpl<$Res>
    implements $MeterReadingPairCopyWith<$Res> {
  _$MeterReadingPairCopyWithImpl(this._self, this._then);

  final MeterReadingPair _self;
  final $Res Function(MeterReadingPair) _then;

/// Create a copy of MeterReadingPair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? previous = null,Object? current = null,}) {
  return _then(_self.copyWith(
previous: null == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as double,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MeterReadingPair].
extension MeterReadingPairPatterns on MeterReadingPair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterReadingPair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterReadingPair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterReadingPair value)  $default,){
final _that = this;
switch (_that) {
case _MeterReadingPair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterReadingPair value)?  $default,){
final _that = this;
switch (_that) {
case _MeterReadingPair() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double previous,  double current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterReadingPair() when $default != null:
return $default(_that.previous,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double previous,  double current)  $default,) {final _that = this;
switch (_that) {
case _MeterReadingPair():
return $default(_that.previous,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double previous,  double current)?  $default,) {final _that = this;
switch (_that) {
case _MeterReadingPair() when $default != null:
return $default(_that.previous,_that.current);case _:
  return null;

}
}

}

/// @nodoc


class _MeterReadingPair extends MeterReadingPair {
  const _MeterReadingPair({required this.previous, required this.current}): super._();
  

@override final  double previous;
@override final  double current;

/// Create a copy of MeterReadingPair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterReadingPairCopyWith<_MeterReadingPair> get copyWith => __$MeterReadingPairCopyWithImpl<_MeterReadingPair>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterReadingPair&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current));
}


@override
int get hashCode => Object.hash(runtimeType,previous,current);

@override
String toString() {
  return 'MeterReadingPair(previous: $previous, current: $current)';
}


}

/// @nodoc
abstract mixin class _$MeterReadingPairCopyWith<$Res> implements $MeterReadingPairCopyWith<$Res> {
  factory _$MeterReadingPairCopyWith(_MeterReadingPair value, $Res Function(_MeterReadingPair) _then) = __$MeterReadingPairCopyWithImpl;
@override @useResult
$Res call({
 double previous, double current
});




}
/// @nodoc
class __$MeterReadingPairCopyWithImpl<$Res>
    implements _$MeterReadingPairCopyWith<$Res> {
  __$MeterReadingPairCopyWithImpl(this._self, this._then);

  final _MeterReadingPair _self;
  final $Res Function(_MeterReadingPair) _then;

/// Create a copy of MeterReadingPair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? previous = null,Object? current = null,}) {
  return _then(_MeterReadingPair(
previous: null == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as double,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$TenantReadingInput {

 int get tenantId; String get tenantName; double get previous; double get current; TenantBillingMode get mode;/// Flat per-unit price; required when [mode] is [TenantBillingMode.fixed].
 double? get fixedRate;
/// Create a copy of TenantReadingInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantReadingInputCopyWith<TenantReadingInput> get copyWith => _$TenantReadingInputCopyWithImpl<TenantReadingInput>(this as TenantReadingInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantReadingInput&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.fixedRate, fixedRate) || other.fixedRate == fixedRate));
}


@override
int get hashCode => Object.hash(runtimeType,tenantId,tenantName,previous,current,mode,fixedRate);

@override
String toString() {
  return 'TenantReadingInput(tenantId: $tenantId, tenantName: $tenantName, previous: $previous, current: $current, mode: $mode, fixedRate: $fixedRate)';
}


}

/// @nodoc
abstract mixin class $TenantReadingInputCopyWith<$Res>  {
  factory $TenantReadingInputCopyWith(TenantReadingInput value, $Res Function(TenantReadingInput) _then) = _$TenantReadingInputCopyWithImpl;
@useResult
$Res call({
 int tenantId, String tenantName, double previous, double current, TenantBillingMode mode, double? fixedRate
});




}
/// @nodoc
class _$TenantReadingInputCopyWithImpl<$Res>
    implements $TenantReadingInputCopyWith<$Res> {
  _$TenantReadingInputCopyWithImpl(this._self, this._then);

  final TenantReadingInput _self;
  final $Res Function(TenantReadingInput) _then;

/// Create a copy of TenantReadingInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenantId = null,Object? tenantName = null,Object? previous = null,Object? current = null,Object? mode = null,Object? fixedRate = freezed,}) {
  return _then(_self.copyWith(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as int,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,previous: null == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as double,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TenantBillingMode,fixedRate: freezed == fixedRate ? _self.fixedRate : fixedRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantReadingInput].
extension TenantReadingInputPatterns on TenantReadingInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantReadingInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantReadingInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantReadingInput value)  $default,){
final _that = this;
switch (_that) {
case _TenantReadingInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantReadingInput value)?  $default,){
final _that = this;
switch (_that) {
case _TenantReadingInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tenantId,  String tenantName,  double previous,  double current,  TenantBillingMode mode,  double? fixedRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantReadingInput() when $default != null:
return $default(_that.tenantId,_that.tenantName,_that.previous,_that.current,_that.mode,_that.fixedRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tenantId,  String tenantName,  double previous,  double current,  TenantBillingMode mode,  double? fixedRate)  $default,) {final _that = this;
switch (_that) {
case _TenantReadingInput():
return $default(_that.tenantId,_that.tenantName,_that.previous,_that.current,_that.mode,_that.fixedRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tenantId,  String tenantName,  double previous,  double current,  TenantBillingMode mode,  double? fixedRate)?  $default,) {final _that = this;
switch (_that) {
case _TenantReadingInput() when $default != null:
return $default(_that.tenantId,_that.tenantName,_that.previous,_that.current,_that.mode,_that.fixedRate);case _:
  return null;

}
}

}

/// @nodoc


class _TenantReadingInput extends TenantReadingInput {
  const _TenantReadingInput({required this.tenantId, required this.tenantName, required this.previous, required this.current, this.mode = TenantBillingMode.shared, this.fixedRate}): super._();
  

@override final  int tenantId;
@override final  String tenantName;
@override final  double previous;
@override final  double current;
@override@JsonKey() final  TenantBillingMode mode;
/// Flat per-unit price; required when [mode] is [TenantBillingMode.fixed].
@override final  double? fixedRate;

/// Create a copy of TenantReadingInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantReadingInputCopyWith<_TenantReadingInput> get copyWith => __$TenantReadingInputCopyWithImpl<_TenantReadingInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantReadingInput&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.tenantName, tenantName) || other.tenantName == tenantName)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.fixedRate, fixedRate) || other.fixedRate == fixedRate));
}


@override
int get hashCode => Object.hash(runtimeType,tenantId,tenantName,previous,current,mode,fixedRate);

@override
String toString() {
  return 'TenantReadingInput(tenantId: $tenantId, tenantName: $tenantName, previous: $previous, current: $current, mode: $mode, fixedRate: $fixedRate)';
}


}

/// @nodoc
abstract mixin class _$TenantReadingInputCopyWith<$Res> implements $TenantReadingInputCopyWith<$Res> {
  factory _$TenantReadingInputCopyWith(_TenantReadingInput value, $Res Function(_TenantReadingInput) _then) = __$TenantReadingInputCopyWithImpl;
@override @useResult
$Res call({
 int tenantId, String tenantName, double previous, double current, TenantBillingMode mode, double? fixedRate
});




}
/// @nodoc
class __$TenantReadingInputCopyWithImpl<$Res>
    implements _$TenantReadingInputCopyWith<$Res> {
  __$TenantReadingInputCopyWithImpl(this._self, this._then);

  final _TenantReadingInput _self;
  final $Res Function(_TenantReadingInput) _then;

/// Create a copy of TenantReadingInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenantId = null,Object? tenantName = null,Object? previous = null,Object? current = null,Object? mode = null,Object? fixedRate = freezed,}) {
  return _then(_TenantReadingInput(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as int,tenantName: null == tenantName ? _self.tenantName : tenantName // ignore: cast_nullable_to_non_nullable
as String,previous: null == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as double,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as TenantBillingMode,fixedRate: freezed == fixedRate ? _self.fixedRate : fixedRate // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$RechargeInput {

 double get amount; double get fees; String? get paidBy;
/// Create a copy of RechargeInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RechargeInputCopyWith<RechargeInput> get copyWith => _$RechargeInputCopyWithImpl<RechargeInput>(this as RechargeInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RechargeInput&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy));
}


@override
int get hashCode => Object.hash(runtimeType,amount,fees,paidBy);

@override
String toString() {
  return 'RechargeInput(amount: $amount, fees: $fees, paidBy: $paidBy)';
}


}

/// @nodoc
abstract mixin class $RechargeInputCopyWith<$Res>  {
  factory $RechargeInputCopyWith(RechargeInput value, $Res Function(RechargeInput) _then) = _$RechargeInputCopyWithImpl;
@useResult
$Res call({
 double amount, double fees, String? paidBy
});




}
/// @nodoc
class _$RechargeInputCopyWithImpl<$Res>
    implements $RechargeInputCopyWith<$Res> {
  _$RechargeInputCopyWithImpl(this._self, this._then);

  final RechargeInput _self;
  final $Res Function(RechargeInput) _then;

/// Create a copy of RechargeInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? fees = null,Object? paidBy = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fees: null == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as double,paidBy: freezed == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RechargeInput].
extension RechargeInputPatterns on RechargeInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RechargeInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RechargeInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RechargeInput value)  $default,){
final _that = this;
switch (_that) {
case _RechargeInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RechargeInput value)?  $default,){
final _that = this;
switch (_that) {
case _RechargeInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  double fees,  String? paidBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RechargeInput() when $default != null:
return $default(_that.amount,_that.fees,_that.paidBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  double fees,  String? paidBy)  $default,) {final _that = this;
switch (_that) {
case _RechargeInput():
return $default(_that.amount,_that.fees,_that.paidBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  double fees,  String? paidBy)?  $default,) {final _that = this;
switch (_that) {
case _RechargeInput() when $default != null:
return $default(_that.amount,_that.fees,_that.paidBy);case _:
  return null;

}
}

}

/// @nodoc


class _RechargeInput extends RechargeInput {
  const _RechargeInput({required this.amount, this.fees = 0, this.paidBy}): super._();
  

@override final  double amount;
@override@JsonKey() final  double fees;
@override final  String? paidBy;

/// Create a copy of RechargeInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RechargeInputCopyWith<_RechargeInput> get copyWith => __$RechargeInputCopyWithImpl<_RechargeInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RechargeInput&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.fees, fees) || other.fees == fees)&&(identical(other.paidBy, paidBy) || other.paidBy == paidBy));
}


@override
int get hashCode => Object.hash(runtimeType,amount,fees,paidBy);

@override
String toString() {
  return 'RechargeInput(amount: $amount, fees: $fees, paidBy: $paidBy)';
}


}

/// @nodoc
abstract mixin class _$RechargeInputCopyWith<$Res> implements $RechargeInputCopyWith<$Res> {
  factory _$RechargeInputCopyWith(_RechargeInput value, $Res Function(_RechargeInput) _then) = __$RechargeInputCopyWithImpl;
@override @useResult
$Res call({
 double amount, double fees, String? paidBy
});




}
/// @nodoc
class __$RechargeInputCopyWithImpl<$Res>
    implements _$RechargeInputCopyWith<$Res> {
  __$RechargeInputCopyWithImpl(this._self, this._then);

  final _RechargeInput _self;
  final $Res Function(_RechargeInput) _then;

/// Create a copy of RechargeInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? fees = null,Object? paidBy = freezed,}) {
  return _then(_RechargeInput(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,fees: null == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as double,paidBy: freezed == paidBy ? _self.paidBy : paidBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SettlementInput {

 int get fromTenantId; int get toTenantId; double get amount;
/// Create a copy of SettlementInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementInputCopyWith<SettlementInput> get copyWith => _$SettlementInputCopyWithImpl<SettlementInput>(this as SettlementInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementInput&&(identical(other.fromTenantId, fromTenantId) || other.fromTenantId == fromTenantId)&&(identical(other.toTenantId, toTenantId) || other.toTenantId == toTenantId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,fromTenantId,toTenantId,amount);

@override
String toString() {
  return 'SettlementInput(fromTenantId: $fromTenantId, toTenantId: $toTenantId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $SettlementInputCopyWith<$Res>  {
  factory $SettlementInputCopyWith(SettlementInput value, $Res Function(SettlementInput) _then) = _$SettlementInputCopyWithImpl;
@useResult
$Res call({
 int fromTenantId, int toTenantId, double amount
});




}
/// @nodoc
class _$SettlementInputCopyWithImpl<$Res>
    implements $SettlementInputCopyWith<$Res> {
  _$SettlementInputCopyWithImpl(this._self, this._then);

  final SettlementInput _self;
  final $Res Function(SettlementInput) _then;

/// Create a copy of SettlementInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromTenantId = null,Object? toTenantId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
fromTenantId: null == fromTenantId ? _self.fromTenantId : fromTenantId // ignore: cast_nullable_to_non_nullable
as int,toTenantId: null == toTenantId ? _self.toTenantId : toTenantId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementInput].
extension SettlementInputPatterns on SettlementInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementInput value)  $default,){
final _that = this;
switch (_that) {
case _SettlementInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementInput value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int fromTenantId,  int toTenantId,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementInput() when $default != null:
return $default(_that.fromTenantId,_that.toTenantId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int fromTenantId,  int toTenantId,  double amount)  $default,) {final _that = this;
switch (_that) {
case _SettlementInput():
return $default(_that.fromTenantId,_that.toTenantId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int fromTenantId,  int toTenantId,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _SettlementInput() when $default != null:
return $default(_that.fromTenantId,_that.toTenantId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _SettlementInput implements SettlementInput {
  const _SettlementInput({required this.fromTenantId, required this.toTenantId, required this.amount});
  

@override final  int fromTenantId;
@override final  int toTenantId;
@override final  double amount;

/// Create a copy of SettlementInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementInputCopyWith<_SettlementInput> get copyWith => __$SettlementInputCopyWithImpl<_SettlementInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementInput&&(identical(other.fromTenantId, fromTenantId) || other.fromTenantId == fromTenantId)&&(identical(other.toTenantId, toTenantId) || other.toTenantId == toTenantId)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,fromTenantId,toTenantId,amount);

@override
String toString() {
  return 'SettlementInput(fromTenantId: $fromTenantId, toTenantId: $toTenantId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$SettlementInputCopyWith<$Res> implements $SettlementInputCopyWith<$Res> {
  factory _$SettlementInputCopyWith(_SettlementInput value, $Res Function(_SettlementInput) _then) = __$SettlementInputCopyWithImpl;
@override @useResult
$Res call({
 int fromTenantId, int toTenantId, double amount
});




}
/// @nodoc
class __$SettlementInputCopyWithImpl<$Res>
    implements _$SettlementInputCopyWith<$Res> {
  __$SettlementInputCopyWithImpl(this._self, this._then);

  final _SettlementInput _self;
  final $Res Function(_SettlementInput) _then;

/// Create a copy of SettlementInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromTenantId = null,Object? toTenantId = null,Object? amount = null,}) {
  return _then(_SettlementInput(
fromTenantId: null == fromTenantId ? _self.fromTenantId : fromTenantId // ignore: cast_nullable_to_non_nullable
as int,toTenantId: null == toTenantId ? _self.toTenantId : toTenantId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$BillingInput {

 Tariff get tariff; MeterReadingPair get mainMeter; List<TenantReadingInput> get tenants; List<RechargeInput> get recharges; List<SettlementInput> get settlements;/// How fixed charges + expenses are split among shared tenants.
 FixedChargeDistribution get distribution;/// The property-level calculation mode (see [BillingCalcMode]).
 BillingCalcMode get calcMode;/// Carry-in prepaid balance per tenant (tenantId → amount) from prior
/// periods. Computed by the application layer; the engine just folds it into
/// each tenant's available balance.
 Map<int, double> get openingBalances;/// When true (single-meter mode), every recharge is attributed to the one
/// account regardless of the "paid by" name.
 bool get poolAllRecharges;
/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingInputCopyWith<BillingInput> get copyWith => _$BillingInputCopyWithImpl<BillingInput>(this as BillingInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingInput&&(identical(other.tariff, tariff) || other.tariff == tariff)&&(identical(other.mainMeter, mainMeter) || other.mainMeter == mainMeter)&&const DeepCollectionEquality().equals(other.tenants, tenants)&&const DeepCollectionEquality().equals(other.recharges, recharges)&&const DeepCollectionEquality().equals(other.settlements, settlements)&&(identical(other.distribution, distribution) || other.distribution == distribution)&&(identical(other.calcMode, calcMode) || other.calcMode == calcMode)&&const DeepCollectionEquality().equals(other.openingBalances, openingBalances)&&(identical(other.poolAllRecharges, poolAllRecharges) || other.poolAllRecharges == poolAllRecharges));
}


@override
int get hashCode => Object.hash(runtimeType,tariff,mainMeter,const DeepCollectionEquality().hash(tenants),const DeepCollectionEquality().hash(recharges),const DeepCollectionEquality().hash(settlements),distribution,calcMode,const DeepCollectionEquality().hash(openingBalances),poolAllRecharges);

@override
String toString() {
  return 'BillingInput(tariff: $tariff, mainMeter: $mainMeter, tenants: $tenants, recharges: $recharges, settlements: $settlements, distribution: $distribution, calcMode: $calcMode, openingBalances: $openingBalances, poolAllRecharges: $poolAllRecharges)';
}


}

/// @nodoc
abstract mixin class $BillingInputCopyWith<$Res>  {
  factory $BillingInputCopyWith(BillingInput value, $Res Function(BillingInput) _then) = _$BillingInputCopyWithImpl;
@useResult
$Res call({
 Tariff tariff, MeterReadingPair mainMeter, List<TenantReadingInput> tenants, List<RechargeInput> recharges, List<SettlementInput> settlements, FixedChargeDistribution distribution, BillingCalcMode calcMode, Map<int, double> openingBalances, bool poolAllRecharges
});


$TariffCopyWith<$Res> get tariff;$MeterReadingPairCopyWith<$Res> get mainMeter;

}
/// @nodoc
class _$BillingInputCopyWithImpl<$Res>
    implements $BillingInputCopyWith<$Res> {
  _$BillingInputCopyWithImpl(this._self, this._then);

  final BillingInput _self;
  final $Res Function(BillingInput) _then;

/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tariff = null,Object? mainMeter = null,Object? tenants = null,Object? recharges = null,Object? settlements = null,Object? distribution = null,Object? calcMode = null,Object? openingBalances = null,Object? poolAllRecharges = null,}) {
  return _then(_self.copyWith(
tariff: null == tariff ? _self.tariff : tariff // ignore: cast_nullable_to_non_nullable
as Tariff,mainMeter: null == mainMeter ? _self.mainMeter : mainMeter // ignore: cast_nullable_to_non_nullable
as MeterReadingPair,tenants: null == tenants ? _self.tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<TenantReadingInput>,recharges: null == recharges ? _self.recharges : recharges // ignore: cast_nullable_to_non_nullable
as List<RechargeInput>,settlements: null == settlements ? _self.settlements : settlements // ignore: cast_nullable_to_non_nullable
as List<SettlementInput>,distribution: null == distribution ? _self.distribution : distribution // ignore: cast_nullable_to_non_nullable
as FixedChargeDistribution,calcMode: null == calcMode ? _self.calcMode : calcMode // ignore: cast_nullable_to_non_nullable
as BillingCalcMode,openingBalances: null == openingBalances ? _self.openingBalances : openingBalances // ignore: cast_nullable_to_non_nullable
as Map<int, double>,poolAllRecharges: null == poolAllRecharges ? _self.poolAllRecharges : poolAllRecharges // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TariffCopyWith<$Res> get tariff {
  
  return $TariffCopyWith<$Res>(_self.tariff, (value) {
    return _then(_self.copyWith(tariff: value));
  });
}/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterReadingPairCopyWith<$Res> get mainMeter {
  
  return $MeterReadingPairCopyWith<$Res>(_self.mainMeter, (value) {
    return _then(_self.copyWith(mainMeter: value));
  });
}
}


/// Adds pattern-matching-related methods to [BillingInput].
extension BillingInputPatterns on BillingInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingInput value)  $default,){
final _that = this;
switch (_that) {
case _BillingInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingInput value)?  $default,){
final _that = this;
switch (_that) {
case _BillingInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Tariff tariff,  MeterReadingPair mainMeter,  List<TenantReadingInput> tenants,  List<RechargeInput> recharges,  List<SettlementInput> settlements,  FixedChargeDistribution distribution,  BillingCalcMode calcMode,  Map<int, double> openingBalances,  bool poolAllRecharges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingInput() when $default != null:
return $default(_that.tariff,_that.mainMeter,_that.tenants,_that.recharges,_that.settlements,_that.distribution,_that.calcMode,_that.openingBalances,_that.poolAllRecharges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Tariff tariff,  MeterReadingPair mainMeter,  List<TenantReadingInput> tenants,  List<RechargeInput> recharges,  List<SettlementInput> settlements,  FixedChargeDistribution distribution,  BillingCalcMode calcMode,  Map<int, double> openingBalances,  bool poolAllRecharges)  $default,) {final _that = this;
switch (_that) {
case _BillingInput():
return $default(_that.tariff,_that.mainMeter,_that.tenants,_that.recharges,_that.settlements,_that.distribution,_that.calcMode,_that.openingBalances,_that.poolAllRecharges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Tariff tariff,  MeterReadingPair mainMeter,  List<TenantReadingInput> tenants,  List<RechargeInput> recharges,  List<SettlementInput> settlements,  FixedChargeDistribution distribution,  BillingCalcMode calcMode,  Map<int, double> openingBalances,  bool poolAllRecharges)?  $default,) {final _that = this;
switch (_that) {
case _BillingInput() when $default != null:
return $default(_that.tariff,_that.mainMeter,_that.tenants,_that.recharges,_that.settlements,_that.distribution,_that.calcMode,_that.openingBalances,_that.poolAllRecharges);case _:
  return null;

}
}

}

/// @nodoc


class _BillingInput implements BillingInput {
  const _BillingInput({required this.tariff, required this.mainMeter, required final  List<TenantReadingInput> tenants, final  List<RechargeInput> recharges = const <RechargeInput>[], final  List<SettlementInput> settlements = const <SettlementInput>[], this.distribution = FixedChargeDistribution.equal, this.calcMode = BillingCalcMode.sharedSlab, final  Map<int, double> openingBalances = const <int, double>{}, this.poolAllRecharges = false}): _tenants = tenants,_recharges = recharges,_settlements = settlements,_openingBalances = openingBalances;
  

@override final  Tariff tariff;
@override final  MeterReadingPair mainMeter;
 final  List<TenantReadingInput> _tenants;
@override List<TenantReadingInput> get tenants {
  if (_tenants is EqualUnmodifiableListView) return _tenants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tenants);
}

 final  List<RechargeInput> _recharges;
@override@JsonKey() List<RechargeInput> get recharges {
  if (_recharges is EqualUnmodifiableListView) return _recharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recharges);
}

 final  List<SettlementInput> _settlements;
@override@JsonKey() List<SettlementInput> get settlements {
  if (_settlements is EqualUnmodifiableListView) return _settlements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_settlements);
}

/// How fixed charges + expenses are split among shared tenants.
@override@JsonKey() final  FixedChargeDistribution distribution;
/// The property-level calculation mode (see [BillingCalcMode]).
@override@JsonKey() final  BillingCalcMode calcMode;
/// Carry-in prepaid balance per tenant (tenantId → amount) from prior
/// periods. Computed by the application layer; the engine just folds it into
/// each tenant's available balance.
 final  Map<int, double> _openingBalances;
/// Carry-in prepaid balance per tenant (tenantId → amount) from prior
/// periods. Computed by the application layer; the engine just folds it into
/// each tenant's available balance.
@override@JsonKey() Map<int, double> get openingBalances {
  if (_openingBalances is EqualUnmodifiableMapView) return _openingBalances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_openingBalances);
}

/// When true (single-meter mode), every recharge is attributed to the one
/// account regardless of the "paid by" name.
@override@JsonKey() final  bool poolAllRecharges;

/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingInputCopyWith<_BillingInput> get copyWith => __$BillingInputCopyWithImpl<_BillingInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingInput&&(identical(other.tariff, tariff) || other.tariff == tariff)&&(identical(other.mainMeter, mainMeter) || other.mainMeter == mainMeter)&&const DeepCollectionEquality().equals(other._tenants, _tenants)&&const DeepCollectionEquality().equals(other._recharges, _recharges)&&const DeepCollectionEquality().equals(other._settlements, _settlements)&&(identical(other.distribution, distribution) || other.distribution == distribution)&&(identical(other.calcMode, calcMode) || other.calcMode == calcMode)&&const DeepCollectionEquality().equals(other._openingBalances, _openingBalances)&&(identical(other.poolAllRecharges, poolAllRecharges) || other.poolAllRecharges == poolAllRecharges));
}


@override
int get hashCode => Object.hash(runtimeType,tariff,mainMeter,const DeepCollectionEquality().hash(_tenants),const DeepCollectionEquality().hash(_recharges),const DeepCollectionEquality().hash(_settlements),distribution,calcMode,const DeepCollectionEquality().hash(_openingBalances),poolAllRecharges);

@override
String toString() {
  return 'BillingInput(tariff: $tariff, mainMeter: $mainMeter, tenants: $tenants, recharges: $recharges, settlements: $settlements, distribution: $distribution, calcMode: $calcMode, openingBalances: $openingBalances, poolAllRecharges: $poolAllRecharges)';
}


}

/// @nodoc
abstract mixin class _$BillingInputCopyWith<$Res> implements $BillingInputCopyWith<$Res> {
  factory _$BillingInputCopyWith(_BillingInput value, $Res Function(_BillingInput) _then) = __$BillingInputCopyWithImpl;
@override @useResult
$Res call({
 Tariff tariff, MeterReadingPair mainMeter, List<TenantReadingInput> tenants, List<RechargeInput> recharges, List<SettlementInput> settlements, FixedChargeDistribution distribution, BillingCalcMode calcMode, Map<int, double> openingBalances, bool poolAllRecharges
});


@override $TariffCopyWith<$Res> get tariff;@override $MeterReadingPairCopyWith<$Res> get mainMeter;

}
/// @nodoc
class __$BillingInputCopyWithImpl<$Res>
    implements _$BillingInputCopyWith<$Res> {
  __$BillingInputCopyWithImpl(this._self, this._then);

  final _BillingInput _self;
  final $Res Function(_BillingInput) _then;

/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tariff = null,Object? mainMeter = null,Object? tenants = null,Object? recharges = null,Object? settlements = null,Object? distribution = null,Object? calcMode = null,Object? openingBalances = null,Object? poolAllRecharges = null,}) {
  return _then(_BillingInput(
tariff: null == tariff ? _self.tariff : tariff // ignore: cast_nullable_to_non_nullable
as Tariff,mainMeter: null == mainMeter ? _self.mainMeter : mainMeter // ignore: cast_nullable_to_non_nullable
as MeterReadingPair,tenants: null == tenants ? _self._tenants : tenants // ignore: cast_nullable_to_non_nullable
as List<TenantReadingInput>,recharges: null == recharges ? _self._recharges : recharges // ignore: cast_nullable_to_non_nullable
as List<RechargeInput>,settlements: null == settlements ? _self._settlements : settlements // ignore: cast_nullable_to_non_nullable
as List<SettlementInput>,distribution: null == distribution ? _self.distribution : distribution // ignore: cast_nullable_to_non_nullable
as FixedChargeDistribution,calcMode: null == calcMode ? _self.calcMode : calcMode // ignore: cast_nullable_to_non_nullable
as BillingCalcMode,openingBalances: null == openingBalances ? _self._openingBalances : openingBalances // ignore: cast_nullable_to_non_nullable
as Map<int, double>,poolAllRecharges: null == poolAllRecharges ? _self.poolAllRecharges : poolAllRecharges // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TariffCopyWith<$Res> get tariff {
  
  return $TariffCopyWith<$Res>(_self.tariff, (value) {
    return _then(_self.copyWith(tariff: value));
  });
}/// Create a copy of BillingInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MeterReadingPairCopyWith<$Res> get mainMeter {
  
  return $MeterReadingPairCopyWith<$Res>(_self.mainMeter, (value) {
    return _then(_self.copyWith(mainMeter: value));
  });
}
}

// dart format on
