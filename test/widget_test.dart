import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm/models/forex_symbol.dart';
import 'package:fxtm/pages/main_screen.dart';
import 'package:fxtm/provider/forex_websocket_provider.dart';
import 'package:fxtm/provider/forex_symbol_provider.dart';

// Mocking Providers
class MockForexSymbolNotifier extends Notifier<List<ForexSymbol>> {
  @override
  List<ForexSymbol> build() => [];
}

class MockForexPriceNotifier extends ForexWebSocketNotifier {
  MockForexPriceNotifier() : super();

  @override
  void connectWebSocket(List<String> symbols) {
  //  state = {
  //    "EURUSD": const ForexModel(symbol: 'EURUSD', price: 1.12, change: 10, isUp: true, timestamp: 1200),
  //    "GBPUSD": const ForexModel(symbol: 'EURUSD', price: 1.15, change: -10, isUp: false, timestamp: 1300),
      //'USD/JPY': const ForexModel(symbol: 'USD/JPY', price: 0.00, change: 0, isUp: false, timestamp: 1400),
  //  };
  }
}


void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(overrides: [
  forexSymbolProvider.overrideWith((ref) async => [
    const ForexSymbol(symbol: "EURUSD", displaySymbol: "EUR/USD", description: "Euro to USD"),
    const ForexSymbol(symbol: "GBPUSD", displaySymbol: "GBP/USD", description: "British Pound to USD"),
  ]),
  //forexPriceProvider.overrideWith((ref) => MockForexPriceNotifier()),
]);

  });

  testWidgets('MainScreen displays loading when forex data is empty', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Bottom navigation updates the selected index', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    await tester.tap(find.byIcon(Icons.newspaper));
    await tester.pump();
    expect(find.text('This menu item is disabled'), findsOneWidget);
  });

  testWidgets('Displays correct price color and arrow for up/down/neutral prices', (WidgetTester tester) async {
    // final mockPrices = {
    //   'EUR/USD': const ForexModel(symbol: 'EUR/USD', price: 1.25, change: 10, isUp: true, timestamp: 1200),
    //   'GBP/USD': const ForexModel(symbol: 'GBP/USD', price: 1.30, change: -10, isUp: false, timestamp: 1300),
    //   'USD/JPY': const ForexModel(symbol: 'USD/JPY', price: 0.00, change: 0, isUp: false, timestamp: 1400),
    // };

    container = ProviderContainer(overrides: [
      //forexPriceProvider.overrideWith((ref) => MockForexPriceNotifier()),
    ]);

    await tester.pumpWidget(
      ProviderScope(parent: container, child: const MaterialApp(home: MainScreen())),
    );

    expect(find.byIcon(Icons.arrow_upward_rounded), findsOneWidget); // Green
    expect(find.byIcon(Icons.arrow_downward_rounded), findsOneWidget); // Red
    expect(find.text('0.00'), findsOneWidget); // BlueGrey for zero
  });
}
