import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm/models/trade_model.dart';
import 'package:fxtm/provider/forex_websocket_provider.dart';
import 'package:fxtm/services/forex_websocket_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'dart:async';

@GenerateMocks([Box])
import 'forex_websocket_test.mocks.dart';

// Create mock classes
class MockWebSocketSink extends Mock implements WebSocketSink {
  void add(dynamic data) {}
  Future close([int? code, String? reason]) async {}
}

class MockWebSocketChannel extends Mock implements WebSocketChannel {
  final MockWebSocketSink _sink = MockWebSocketSink();
  final StreamController<dynamic> _controller = StreamController<dynamic>();

  @override
  WebSocketSink get sink => _sink;

  @override
  Stream<dynamic> get stream => _controller.stream;

  void addMessage(dynamic message) {
    _controller.add(message);
  }

  void close() {
    _controller.close();
  }
}


void main() {
  late ForexWebSocketService service;
  late MockWebSocketChannel mockWebSocket;
  late MockBox<TradeModel> mockBox;

  setUp(() {
    mockWebSocket = MockWebSocketChannel();
    mockBox = MockBox();
    service = ForexWebSocketService();

    // Set up mock behavior for WebSocket sink
    when(mockWebSocket.sink.add(any)).thenAnswer((_) {});
    when(mockWebSocket.sink.close(any, any)).thenAnswer((_) async {});
  });

  tearDown(() {
    service.close();
  });

  group('ForexWebSocketService Tests', () {
    test('connects to WebSocket successfully', () async {
      final symbols = ['EURUSD', 'GBPUSD'];
      
      when(mockBox.add(any)).thenAnswer((_) async => 1);
      
      await service.connectWebSocket(symbols);
      
      expect(service.getIsConnected(), true);
      expect(service.subscribedSymbols(), containsAll(symbols));
    });

    test('handles incoming trade data correctly', () async {
      final testData = {
        'type': 'trade',
        'data': [
          {
            's': 'EURUSD',
            'p': 1.2345,
            't': 1234567890
          }
        ]
      };

      var updateCalled = false;
      service.onUpdate = (Map prices) {
        updateCalled = true;
        expect(prices['EURUSD'].price, 1.2345);
        expect(prices['EURUSD'].symbol, 'EURUSD');
      };

      await service.connectWebSocket(['EURUSD']);
      mockWebSocket.addMessage(json.encode(testData));

      expect(updateCalled, true);
    });

    test('calculates price changes correctly', () async {
      final initialTrade = {
        'type': 'trade',
        'data': [
          {
            's': 'EURUSD',
            'p': 1.2000,
            't': 1234567890
          }
        ]
      };

      final nextTrade = {
        'type': 'trade',
        'data': [
          {
            's': 'EURUSD',
            'p': 1.2100,
            't': 1234567891
          }
        ]
      };

      await service.connectWebSocket(['EURUSD']);
      
      mockWebSocket.addMessage(json.encode(initialTrade));
      mockWebSocket.addMessage(json.encode(nextTrade));

      expect(service.getLatestPrices()['EURUSD']?.change, closeTo(0.833, 0.001)); // (1.21 - 1.20) / 1.20 * 100
      expect(service.getLatestPrices()['EURUSD']?.isUp, true);
    });

    test('saves trade history to Hive', () async {
      when(mockBox.add(any)).thenAnswer((_) async => 1);
      
      service.tradeBox = mockBox;
      service.saveTrade('EURUSD', 1.2345, 1234567890);

      verify(mockBox.add(any)).called(1);
    });

    test('handles unsubscribe from symbol', () async {
      final symbol = 'EURUSD';
      await service.connectWebSocket([symbol]);
      
      service.unsubscribeFromSymbol(symbol);
      expect(service.subscribedSymbols().contains(symbol), false);
    });
  });

  group('ForexWebSocketNotifier Tests', () {
    late ForexWebSocketNotifier notifier;
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
      notifier = ForexWebSocketNotifier();
    });

    tearDown(() {
      container.dispose();
    });

    test('initializes with empty state', () async {
      final state = await notifier.build();
      expect(state, isEmpty);
    });

    test('connects and updates state', () async {
      final symbols = ['EURUSD'];
      
      await notifier.connect(symbols);
      
      expect(notifier.getIsConnected(), true);
      expect(notifier.state, isA<AsyncData<Map>>());
    });

    test('manages lifecycle state changes', () async {
      final symbols = ['EURUSD'];
      await notifier.connect(symbols);
      
      notifier.didChangeAppLifecycleState(AppLifecycleState.paused);
      expect(notifier.getIsConnected(), false);
      
      notifier.didChangeAppLifecycleState(AppLifecycleState.resumed);
      // Would need to mock forexSymbolProvider to test full resume behavior
    });
  });
}