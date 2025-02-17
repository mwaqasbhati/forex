import 'package:hive/hive.dart';

part 'trade_model.g.dart';  // Generated file

@HiveType(typeId: 0)
class TradeModel {
  @HiveField(0)
  final double price;

  @HiveField(1)
  final String symbol;

  @HiveField(2)
  final int timestamp;

  TradeModel({
    required this.price,
    required this.symbol,
    required this.timestamp,
  });
}
