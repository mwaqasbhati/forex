import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/features/forex/models/forex_symbol.dart';
import 'package:fxtm/features/forex/presentation/pages/history_screen.dart';
import 'package:fxtm/features/forex/provider/forex_websocket_provider.dart';
import 'package:fxtm/features/forex/provider/forex_symbol_provider.dart';
import 'package:fxtm/features/forex/presentation/widgets/empty_state_widget.dart';
import 'package:fxtm/features/forex/presentation/widgets/error_state_widget.dart';
import 'package:fxtm/features/forex/presentation/widgets/shimmer_list_widget.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;
  List<ForexSymbol>forexSymbols = [];
  String? errorMsg;
  
  @override
  void initState() {
    super.initState();
    _loadForexPairs();
  }

  @override
  void dispose() {
    super.dispose();  
  }

  void _loadForexPairs() async {
    try {
          // Fetch the Forex symbols
    final symbolsAsync = await ref.read(forexSymbolProvider.future);
      final symbolList = symbolsAsync.map((s) => s.symbol).toList();
      // Subscribe to WebSocket for these symbols
    //  ref.read(forexPriceProvider.notifier).connectWebSocket(symbolList);
      ref.read(forexWebSocketNotifierProvider.notifier).connect(symbolList);

      setState(() {
        forexSymbols = symbolsAsync;
        errorMsg = null;
      });

    } catch (e) {
      setState(() {
        errorMsg = e.toString();
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This menu item is disabled')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FXTM Forex Tracker'),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Markets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
  if (errorMsg != null) {
    return const ErrorStateWidget();
  } else if (forexSymbols.isEmpty) {
    return const EmptyStateWidget();
  } else {
    return ref.watch(forexWebSocketNotifierProvider).when(
      data: (forexPrices) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: forexSymbols.length,
        itemBuilder: (context, index) {
          final symbol = forexSymbols[index];
          final priceInfo = forexPrices[symbol.symbol];

         // bool hasPrice = priceInfo != null;
          bool isUp = priceInfo?.isUp ?? false;
          double price = priceInfo?.price ?? 0.00;
          double oldPrice = priceInfo?.oldPrice ?? 0.00;
          double change = priceInfo?.change ?? 0.00;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(symbol: symbol.symbol),
                  ),
                );
                  }, // Add your onTap handler here
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Symbol and Description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    symbol.displaySymbol,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    symbol.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      height: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            // Price Change Indicator
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isUp
                                    ? Colors.green.shade50
                                    : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isUp
                                        ? Icons.trending_up_rounded
                                        : Icons.trending_down_rounded,
                                    size: 16,
                                    color: isUp
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${change.toStringAsFixed(2)}%",
                                    style: TextStyle(
                                      color: isUp
                                          ? Colors.green.shade700
                                          : Colors.red.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Price Information Row
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPriceColumn(
                                "Current",
                                price.toStringAsFixed(4),
                                isUp ? Colors.green.shade700 : Colors.red.shade700,
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              _buildPriceColumn(
                                "Previous",
                                oldPrice.toStringAsFixed(4),
                                Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      error: (e, stacktrace) => const ErrorStateWidget(),
      loading: () => const ShimmerListWidget(),
    );
  }
}

Widget _buildPriceColumn(String label, String value, Color valueColor) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: TextStyle(
          fontSize: 18,
          color: valueColor,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
    ],
  );
}



}
