// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ForexModel _$ForexModelFromJson(Map<String, dynamic> json) {
  return _ForexModel.fromJson(json);
}

/// @nodoc
mixin _$ForexModel {
  String get symbol => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get oldPrice => throw _privateConstructorUsedError;
  double get change => throw _privateConstructorUsedError;
  bool get isUp => throw _privateConstructorUsedError;
  double get timestamp => throw _privateConstructorUsedError;

  /// Serializes this ForexModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForexModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForexModelCopyWith<ForexModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForexModelCopyWith<$Res> {
  factory $ForexModelCopyWith(
          ForexModel value, $Res Function(ForexModel) then) =
      _$ForexModelCopyWithImpl<$Res, ForexModel>;
  @useResult
  $Res call(
      {String symbol,
      double price,
      double oldPrice,
      double change,
      bool isUp,
      double timestamp});
}

/// @nodoc
class _$ForexModelCopyWithImpl<$Res, $Val extends ForexModel>
    implements $ForexModelCopyWith<$Res> {
  _$ForexModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForexModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? price = null,
    Object? oldPrice = null,
    Object? change = null,
    Object? isUp = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      oldPrice: null == oldPrice
          ? _value.oldPrice
          : oldPrice // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      isUp: null == isUp
          ? _value.isUp
          : isUp // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForexModelImplCopyWith<$Res>
    implements $ForexModelCopyWith<$Res> {
  factory _$$ForexModelImplCopyWith(
          _$ForexModelImpl value, $Res Function(_$ForexModelImpl) then) =
      __$$ForexModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      double price,
      double oldPrice,
      double change,
      bool isUp,
      double timestamp});
}

/// @nodoc
class __$$ForexModelImplCopyWithImpl<$Res>
    extends _$ForexModelCopyWithImpl<$Res, _$ForexModelImpl>
    implements _$$ForexModelImplCopyWith<$Res> {
  __$$ForexModelImplCopyWithImpl(
      _$ForexModelImpl _value, $Res Function(_$ForexModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForexModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? price = null,
    Object? oldPrice = null,
    Object? change = null,
    Object? isUp = null,
    Object? timestamp = null,
  }) {
    return _then(_$ForexModelImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      oldPrice: null == oldPrice
          ? _value.oldPrice
          : oldPrice // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      isUp: null == isUp
          ? _value.isUp
          : isUp // ignore: cast_nullable_to_non_nullable
              as bool,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForexModelImpl implements _ForexModel {
  const _$ForexModelImpl(
      {required this.symbol,
      required this.price,
      required this.oldPrice,
      required this.change,
      required this.isUp,
      required this.timestamp});

  factory _$ForexModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForexModelImplFromJson(json);

  @override
  final String symbol;
  @override
  final double price;
  @override
  final double oldPrice;
  @override
  final double change;
  @override
  final bool isUp;
  @override
  final double timestamp;

  @override
  String toString() {
    return 'ForexModel(symbol: $symbol, price: $price, oldPrice: $oldPrice, change: $change, isUp: $isUp, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForexModelImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.oldPrice, oldPrice) ||
                other.oldPrice == oldPrice) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.isUp, isUp) || other.isUp == isUp) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, symbol, price, oldPrice, change, isUp, timestamp);

  /// Create a copy of ForexModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForexModelImplCopyWith<_$ForexModelImpl> get copyWith =>
      __$$ForexModelImplCopyWithImpl<_$ForexModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForexModelImplToJson(
      this,
    );
  }
}

abstract class _ForexModel implements ForexModel {
  const factory _ForexModel(
      {required final String symbol,
      required final double price,
      required final double oldPrice,
      required final double change,
      required final bool isUp,
      required final double timestamp}) = _$ForexModelImpl;

  factory _ForexModel.fromJson(Map<String, dynamic> json) =
      _$ForexModelImpl.fromJson;

  @override
  String get symbol;
  @override
  double get price;
  @override
  double get oldPrice;
  @override
  double get change;
  @override
  bool get isUp;
  @override
  double get timestamp;

  /// Create a copy of ForexModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForexModelImplCopyWith<_$ForexModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
