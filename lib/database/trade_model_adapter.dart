import 'package:fxtm/models/trade_model.dart';
import 'package:hive/hive.dart';

class TradeModelAdapter extends TypeAdapter<TradeModel> {
  @override
  final int typeId = 0;

  @override
  TradeModel read(BinaryReader reader) {
    final price = reader.readDouble();
    final symbol = reader.readString();
    final timestamp = reader.readInt();
    return TradeModel(price: price, symbol: symbol, timestamp: timestamp);
  }

  @override
  void write(BinaryWriter writer, TradeModel obj) {
    writer.writeDouble(obj.price);
    writer.writeString(obj.symbol);
    writer.writeInt(obj.timestamp);
  }
}
