import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/features/forex/models/trade_model.dart';
import 'package:fxtm/features/forex/presentation/widgets/price_card_widget.dart';
import 'package:fxtm/features/forex/presentation/widgets/price_chart_widget.dart';
import 'package:fxtm/features/forex/presentation/widgets/trade_list_item_widget.dart';
import 'package:fxtm/features/forex/provider/forex_websocket_provider.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  final String symbol;
  
  const HistoryScreen({super.key, required this.symbol});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends ConsumerState<HistoryScreen> {

  List<TradeModel> _trades = [];
  
  @override
  Widget build(BuildContext context) {
    // Listen to WebSocket updates
    ref.watch(forexWebSocketNotifierProvider).whenData((data) {
      final items = data.values.where((trade) => trade.symbol == widget.symbol);
          if (items.isNotEmpty) {
            final trades = ref
                .read(forexWebSocketNotifierProvider.notifier)
                .getTradeHistory(widget.symbol);
            setState(() => _trades = trades);
          }
    });
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trade History for ${widget.symbol}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: _trades.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Price Overview
                SliverToBoxAdapter(
                  child: PriceCard(
                    symbol: widget.symbol,
                    lastTrade: _trades.last,
                  ),
                ),

                // Chart
                SliverToBoxAdapter(
                  child: PriceChart(trades: _trades),
                ),

                // Trade List Header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Trade History",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Trade List
                SliverList.builder(
                  itemCount: _trades.length,
                  itemBuilder: (context, index) {
                    final trade = _trades[index];
                    final previousPrice = index > 0 ? _trades[index - 1].price : null;
                    return TradeListItem(
                      trade: trade,
                      previousPrice: previousPrice,
                    );
                  },
                ),
              ],
            ),
    );
  }
}