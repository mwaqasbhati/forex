// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forex_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForexModelImpl _$$ForexModelImplFromJson(Map<String, dynamic> json) =>
    _$ForexModelImpl(
      symbol: json['symbol'] as String,
      price: (json['price'] as num).toDouble(),
      oldPrice: (json['oldPrice'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      isUp: json['isUp'] as bool,
      timestamp: (json['timestamp'] as num).toDouble(),
    );

Map<String, dynamic> _$$ForexModelImplToJson(_$ForexModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'price': instance.price,
      'oldPrice': instance.oldPrice,
      'change': instance.change,
      'isUp': instance.isUp,
      'timestamp': instance.timestamp,
    };
