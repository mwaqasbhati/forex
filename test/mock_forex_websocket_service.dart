import 'package:fxtm/models/trade_model.dart';
import 'package:fxtm/services/forex_websocket_service.dart';
import 'package:fxtm/models/forex_model.dart';
import 'package:hive/hive.dart';

class FakeForexWebSocketService implements ForexWebSocketService {
  Function(Map<String, ForexModel>)? onUpdate;
  Function(dynamic)? onError;
  
  bool isConnected = false;
  final Map<String, ForexModel> _prices = {};

  @override
  Future<void> connectWebSocket(List<String> symbols) async {
    isConnected = true;
    // Simulate fetching prices
    Future.delayed(const Duration(seconds: 1), () {
      final prices = {
        for (var symbol in symbols)
          symbol: ForexModel(symbol: symbol, price: 1.1234, change: 10, isUp: true, timestamp: 100),
      };
      _prices.addAll(prices);
      onUpdate?.call(prices);
    });
  }

  @override
  void subscribeToSymbol(String symbol) {
    _prices[symbol] = ForexModel(symbol: symbol, price: 1.5678, change: -10, isUp: false, timestamp: 100);
    onUpdate?.call(_prices);
  }

  @override
  void unsubscribeFromSymbol(String symbol) {
    _prices.remove(symbol);
    onUpdate?.call(_prices);
  }

  @override
  List<TradeModel> getTradeHistory(String symbol) {
    return [TradeModel(symbol: symbol, price: 1.1111, timestamp: 100)];
  }

  @override
  void close() {
    isConnected = false;
  }

  @override
  Box<TradeModel>? tradeBox;

  @override
  void saveTrade(String symbol, double price, int timestamp) {
    // TODO: implement saveTrade
  }
}
