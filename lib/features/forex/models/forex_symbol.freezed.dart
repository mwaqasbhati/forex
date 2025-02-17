// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forex_symbol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ForexSymbol _$ForexSymbolFromJson(Map<String, dynamic> json) {
  return _ForexSymbol.fromJson(json);
}

/// @nodoc
mixin _$ForexSymbol {
  String get description => throw _privateConstructorUsedError;
  String get displaySymbol => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;

  /// Serializes this ForexSymbol to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForexSymbol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForexSymbolCopyWith<ForexSymbol> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForexSymbolCopyWith<$Res> {
  factory $ForexSymbolCopyWith(
          ForexSymbol value, $Res Function(ForexSymbol) then) =
      _$ForexSymbolCopyWithImpl<$Res, ForexSymbol>;
  @useResult
  $Res call({String description, String displaySymbol, String symbol});
}

/// @nodoc
class _$ForexSymbolCopyWithImpl<$Res, $Val extends ForexSymbol>
    implements $ForexSymbolCopyWith<$Res> {
  _$ForexSymbolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForexSymbol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? displaySymbol = null,
    Object? symbol = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      displaySymbol: null == displaySymbol
          ? _value.displaySymbol
          : displaySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForexSymbolImplCopyWith<$Res>
    implements $ForexSymbolCopyWith<$Res> {
  factory _$$ForexSymbolImplCopyWith(
          _$ForexSymbolImpl value, $Res Function(_$ForexSymbolImpl) then) =
      __$$ForexSymbolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String description, String displaySymbol, String symbol});
}

/// @nodoc
class __$$ForexSymbolImplCopyWithImpl<$Res>
    extends _$ForexSymbolCopyWithImpl<$Res, _$ForexSymbolImpl>
    implements _$$ForexSymbolImplCopyWith<$Res> {
  __$$ForexSymbolImplCopyWithImpl(
      _$ForexSymbolImpl _value, $Res Function(_$ForexSymbolImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForexSymbol
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? displaySymbol = null,
    Object? symbol = null,
  }) {
    return _then(_$ForexSymbolImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      displaySymbol: null == displaySymbol
          ? _value.displaySymbol
          : displaySymbol // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForexSymbolImpl implements _ForexSymbol {
  const _$ForexSymbolImpl(
      {required this.description,
      required this.displaySymbol,
      required this.symbol});

  factory _$ForexSymbolImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForexSymbolImplFromJson(json);

  @override
  final String description;
  @override
  final String displaySymbol;
  @override
  final String symbol;

  @override
  String toString() {
    return 'ForexSymbol(description: $description, displaySymbol: $displaySymbol, symbol: $symbol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForexSymbolImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.displaySymbol, displaySymbol) ||
                other.displaySymbol == displaySymbol) &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, displaySymbol, symbol);

  /// Create a copy of ForexSymbol
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForexSymbolImplCopyWith<_$ForexSymbolImpl> get copyWith =>
      __$$ForexSymbolImplCopyWithImpl<_$ForexSymbolImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForexSymbolImplToJson(
      this,
    );
  }
}

abstract class _ForexSymbol implements ForexSymbol {
  const factory _ForexSymbol(
      {required final String description,
      required final String displaySymbol,
      required final String symbol}) = _$ForexSymbolImpl;

  factory _ForexSymbol.fromJson(Map<String, dynamic> json) =
      _$ForexSymbolImpl.fromJson;

  @override
  String get description;
  @override
  String get displaySymbol;
  @override
  String get symbol;

  /// Create a copy of ForexSymbol
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForexSymbolImplCopyWith<_$ForexSymbolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
