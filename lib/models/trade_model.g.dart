// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradeModelAdapter extends TypeAdapter<TradeModel> {
  @override
  final int typeId = 0;

  @override
  TradeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TradeModel(
      price: fields[0] as double,
      symbol: fields[1] as String,
      timestamp: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TradeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
