import 'package:fxtm/models/trade_model.dart';
import 'package:fxtm/provider/forex_symbol_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';
import '../services/forex_websocket_service.dart';
import '../models/forex_model.dart';

part 'forex_websocket_provider.g.dart';

@Riverpod(keepAlive: true)
class ForexWebSocketNotifier extends _$ForexWebSocketNotifier with WidgetsBindingObserver {
  late ForexWebSocketService _webSocketService;
  bool _isConnected = false;
 // List<String> _subscribedSymbols = [];

  bool getIsConnected() => _isConnected;
  
  @override
  FutureOr<Map<String, ForexModel>> build() async {
    _webSocketService = ref.read(forexWebSocketServiceProvider);
    _webSocketService.onUpdate = _updateState;
    _webSocketService.onError = _handleError;

    // Listen to app lifecycle
    WidgetsBinding.instance.addObserver(this);

  ref.onDispose(() {
    close();
    WidgetsBinding.instance.removeObserver(this);
  });

    return {};
  }

  Future<void> connect(List<String> symbols) async {
    if (!_isConnected) {
      state = const AsyncLoading();
      try {
        await _webSocketService.connectWebSocket(symbols);
        _isConnected = true;
      //  _subscribedSymbols = symbols;
        state = const AsyncData({});
      } catch (e) {
        state = AsyncError(e, StackTrace.current);
      }
    }
  }

  Future<void> connectOnResume(List<String> symbols) async {
    if (!_isConnected) {
            try {
        await _webSocketService.connectWebSocket(symbols);
        _isConnected = true;
       // state = const AsyncData({});
      } catch (e) {
        state = AsyncError(e, StackTrace.current);
      }
    }
  }

  void _updateState(Map<String, ForexModel> updatedPrices) {
    state = AsyncData({...state.value ?? {}, ...updatedPrices});
  }

  void _handleError(dynamic error) {
    _isConnected = false; // Ensure reconnection
    state = AsyncError(error, StackTrace.current);
  }

  void subscribeToSymbol(String symbol) {
    _webSocketService.subscribeToSymbol(symbol);
  }

  void unsubscribeFromSymbol(String symbol) {
    _webSocketService.unsubscribeFromSymbol(symbol);
  }

  List<TradeModel> getTradeHistory(String symbol) {
    return _webSocketService.getTradeHistory(symbol);
  }

  void close() {
    _isConnected = false;
    _webSocketService.close();
  }

  // Handle App Lifecycle (Background & Foreground)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
  if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
    close();
  } else if (state == AppLifecycleState.resumed) {
    if (!_isConnected) {
      final asyncSymbols = ref.watch(forexSymbolProvider);

      asyncSymbols.when(
        data: (symbols) {
          if (symbols.isNotEmpty) {
            connectOnResume(symbols.map((s) => s.symbol).toList());
          }
        },
        loading: () {
          debugPrint("Symbols are still loading...");
        },
        error: (err, stack) {
          debugPrint("Error fetching symbols: $err");
        },
      );
    }
  }
}

}
