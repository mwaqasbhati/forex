import 'package:flutter/material.dart';
import 'package:fxtm/core/utils/datetimeUtil.dart';
import 'package:fxtm/features/forex/models/trade_model.dart';

class TradeListItem extends StatelessWidget {
  final TradeModel trade;
  final double? previousPrice;

  const TradeListItem({
    Key? key,
    required this.trade,
    this.previousPrice,
  }): super(key: key);

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
          DateTimeUtil.formatTimestamp(trade.timestamp),
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