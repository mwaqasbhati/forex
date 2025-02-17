import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:hive/hive.dart';
import '../models/forex_model.dart';
import '../models/trade_model.dart';

final forexWebSocketServiceProvider = Provider.autoDispose<ForexWebSocketService>((ref) {
    return ForexWebSocketService();
});

class ForexWebSocketService {
  WebSocketChannel? _channel;
  final String _apiKey = 'cuop0khr01qve8puksi0cuop0khr01qve8puksig';
  final Set<String> _subscribedSymbols = {};
  Box<TradeModel>? tradeBox;
  Function(Map<String, ForexModel>)? onUpdate;
  Function(dynamic error)? onError;
  bool _isConnected = false;

  final Map<String, ForexModel> _latestPrices = {}; // Persist forex prices
  final int _reconnectDelay = 3000; // 3 seconds before reconnect

  /// Connect to WebSocket and subscribe to given symbols
  Future<void> connectWebSocket(List<String> symbols) async {
    if (_isConnected) return; // Prevent duplicate connections

    tradeBox = await Hive.openBox<TradeModel>('trade_history');
    _channel = WebSocketChannel.connect(Uri.parse('wss://ws.finnhub.io?token=$_apiKey'));

    _channel?.stream.listen(
      _onDataReceived,
      onDone: _onDone,
      onError: _onError,
    );

    for (var symbol in symbols) {
      subscribeToSymbol(symbol);
    }

    _isConnected = true;
  }

  /// Handle incoming WebSocket messages
  void _onDataReceived(dynamic data) {
    final jsonData = json.decode(data);
    if (jsonData['type'] == 'trade') {
      final trades = jsonData['data'] as List;

      for (var trade in trades) {
        final price = trade['p'] as double;
        final symbol = trade['s'] as String;
        final timestamp = trade['t'] as int;

        print('old trade symbol ${_latestPrices[symbol]}');
        print('new trade price $price symbol $symbol');


        saveTrade(symbol, price, timestamp);

        final oldPrice = _latestPrices[symbol];
        final change = oldPrice != null ? price - oldPrice.price : 0.0;
        final isUp = change > 0;

        final percentageChange = oldPrice != null
                 ? (price - oldPrice.price).abs() / oldPrice.price * 100
              : 0.0;

        _latestPrices[symbol] = ForexModel(
          symbol: symbol,
          price: price,
          oldPrice: oldPrice?.price ?? price,
          change: percentageChange,
          isUp: isUp,
          timestamp: timestamp.toDouble(),
        );
      }

      onUpdate?.call(_latestPrices);
    }
  }

  /// Reconnect on WebSocket failure
  void _onDone() async {
    _isConnected = false;
    _channel?.sink.close();
    await Future.delayed(Duration(milliseconds: _reconnectDelay));
    connectWebSocket(_subscribedSymbols.toList()); // Attempt to reconnect
  }

  /// Handle WebSocket errors
  void _onError(error) {
    _isConnected = false;
    onError?.call(error);
    close();
    _onDone(); // Trigger reconnection logic
  }

  /// Subscribe to a forex symbol
  void subscribeToSymbol(String symbol) {
    if (!_subscribedSymbols.contains(symbol)) {
      _channel?.sink.add(json.encode({'type': 'subscribe', 'symbol': symbol}));
      _subscribedSymbols.add(symbol);
    }
  }

  /// Unsubscribe from a forex symbol
  void unsubscribeFromSymbol(String symbol) {
    if (_subscribedSymbols.contains(symbol)) {
      _channel?.sink.add(json.encode({'type': 'unsubscribe', 'symbol': symbol}));
      _subscribedSymbols.remove(symbol);
    }
  }

  /// Save trade history locally using Hive
  void saveTrade(String symbol, double price, int timestamp) {
    final newTrade = TradeModel(price: price, symbol: symbol, timestamp: timestamp);
    tradeBox?.add(newTrade);
  }

  /// Retrieve trade history for a given symbol
  List<TradeModel> getTradeHistory(String symbol) {
    return tradeBox?.values.where((trade) => trade.symbol == symbol).toList() ?? [];
  }

  /// Properly close WebSocket connection
  void close() {
    _subscribedSymbols.clear();
    _isConnected = false;
    _channel?.sink.close();
  }
}
