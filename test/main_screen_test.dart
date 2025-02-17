import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm/models/forex_model.dart';
import 'package:fxtm/pages/history_screen.dart';
import 'package:fxtm/pages/main_screen.dart';
import 'package:fxtm/presentation/widgets/shimmer_list_widget.dart';
import 'package:fxtm/provider/forex_symbol_provider.dart';
import 'package:fxtm/provider/forex_websocket_provider.dart';
import 'package:fxtm/models/forex_symbol.dart';

void main() {
  testWidgets('MainScreen UI Test', (WidgetTester tester) async {
  // Mock Forex Symbols
  final mockForexSymbols = [
    const ForexSymbol(symbol: 'EURUSD', displaySymbol: 'EUR/USD', description: 'Euro to USD'),
    const ForexSymbol(symbol: 'GBPUSD', displaySymbol: 'GBP/USD', description: 'British Pound to USD'),
  ];

  // Mock Forex Prices
  final mockForexPrices = {
    'EURUSD': const ForexModel(symbol: 'EURUSD', price: 1.2345, change: 10, isUp: true, timestamp: 1200),
    'GBPUSD': const ForexModel(symbol: 'GBPUSD', price: 1.5432, change: -10, isUp: false, timestamp: 1200),
  };

  // Create a ProviderContainer with mocked providers
  final container = ProviderContainer(overrides: [
    forexSymbolProvider.overrideWith((ref) async => mockForexSymbols),
    forexWebSocketNotifierProvider.overrideWith(
      () => ForexWebSocketNotifier()..state = AsyncData(mockForexPrices),
    ),
  ]);

  // Pump the widget inside a ProviderScope
  await tester.pumpWidget(
    ProviderScope(
      parent: container,
      child: const MaterialApp(home: MainScreen()),
    ),
  );

  // Allow UI to rebuild after loading
  await tester.pump(const Duration(seconds: 30));
  await tester.pumpAndSettle(); // Ensures all animations complete

  // Verify App Bar title
  expect(find.text('FXTM Forex Tracker'), findsOneWidget);

  // Verify Forex symbols are displayed
  expect(find.text('EUR/USD'), findsOneWidget);
  expect(find.text('GBP/USD'), findsOneWidget);

  // Verify Prices are displayed
  expect(find.text('1.23'), findsOneWidget); // Rounded to 2 decimal places
  expect(find.text('1.54'), findsOneWidget);

  // Tap on the first Forex symbol
  await tester.tap(find.text('EUR/USD'));
  await tester.pumpAndSettle();

  // Verify that tapping navigates to HistoryScreen
  expect(find.byType(HistoryScreen), findsOneWidget);
});


  testWidgets('Error state test', (WidgetTester tester) async {
    // Simulate an error response
    final container = ProviderContainer(overrides: [
      forexSymbolProvider.overrideWith((ref) async => throw Exception('Failed to load data')),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    // Wait for error state
    await tester.pumpAndSettle();

    // Verify Error Widget appears
    expect(find.text('Failed to load data'), findsOneWidget);
  });

  testWidgets('Loading state test', (WidgetTester tester) async {
    final container = ProviderContainer(overrides: [
      forexSymbolProvider.overrideWith((ref) async {
        await Future.delayed(const Duration(seconds: 2));
        return [];
      }),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        parent: container,
        child: const MaterialApp(home: MainScreen()),
      ),
    );

    // Verify shimmer loader appears while loading
    expect(find.byType(ShimmerListWidget), findsOneWidget);
  });
}
