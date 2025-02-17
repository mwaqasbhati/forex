import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/features/forex/models/forex_symbol.dart';
import 'package:fxtm/features/forex/models/trade_model.dart';
import 'package:fxtm/features/forex/provider/forex_symbol_provider.dart';
import 'package:fxtm/features/forex/provider/forex_websocket_provider.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  final String symbol;
  
  const HistoryScreen({super.key, required this.symbol});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {

  List<TradeModel> _trades = [];
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         'Trade History for ${widget.symbol}',
  //         style: const TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       backgroundColor: Colors.blueGrey.shade900,
  //       foregroundColor: Colors.white,
  //     ),
  //     body: _buildBody(),
  //   );
  // }

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
                  child: _PriceCard(
                    symbol: widget.symbol,
                    lastTrade: _trades.last,
                  ),
                ),

                // Chart
                SliverToBoxAdapter(
                  child: _PriceChart(trades: _trades),
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
                    return _TradeListItem(
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

class _PriceCard extends StatelessWidget {
  final String symbol;
  final TradeModel lastTrade;

  const _PriceCard({
    required this.symbol,
    required this.lastTrade,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  symbol,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Live',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '\$${lastTrade.price.toStringAsFixed(4)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Updated: ${formatTimestamp(lastTrade.timestamp)}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceChart extends StatelessWidget {
  final List<TradeModel> trades;

  const _PriceChart({required this.trades});

  List<TradeModel> _optimizeDataPoints() {
    if (trades.length <= 50) return trades;
    final step = trades.length ~/ 50;
    return List.generate(50, (i) => trades[i * step]);
  }

  @override
  Widget build(BuildContext context) {
    final optimizedTrades = _optimizeDataPoints();
    
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price Trend",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blue,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '\$${spot.y.toStringAsFixed(4)}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        optimizedTrades.length,
                        (i) => FlSpot(i.toDouble(), optimizedTrades[i].price),
                      ),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade200.withOpacity(0.3),
                            Colors.blue.shade400.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TradeListItem extends StatelessWidget {
  final TradeModel trade;
  final double? previousPrice;

  const _TradeListItem({
    required this.trade,
    this.previousPrice,
  });

  @override
  Widget build(BuildContext context) {
    final isPositiveChange = previousPrice != null && trade.price > previousPrice!;
    final changePercentage = previousPrice != null
        ? ((trade.price - previousPrice!) / previousPrice! * 100)
        : 0.0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isPositiveChange ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isPositiveChange ? Icons.arrow_upward : Icons.arrow_downward,
            color: isPositiveChange ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          '\$${trade.price.toStringAsFixed(4)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          formatTimestamp(trade.timestamp),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: previousPrice != null
            ? Text(
                '${changePercentage.toStringAsFixed(4)}%',
                style: TextStyle(
                  color: isPositiveChange ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
    );
  }
}

String formatTimeShort(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('HH:mm').format(date);
}


String formatTimestamp(int timestamp) {
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return DateFormat('HH:mm').format(dateTime); // e.g., "14:30"
}