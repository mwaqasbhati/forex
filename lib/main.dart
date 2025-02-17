import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/models/trade_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/main_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TradeModelAdapter()); // Register the adapter
  runApp(const FXTMApp());
}

class FXTMApp extends StatelessWidget {
  const FXTMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child:MaterialApp(
      title: 'FXTM Forex Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    ));
  }
}
