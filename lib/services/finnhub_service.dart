import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/dio/dio_service.dart';
import 'package:fxtm/models/forex_symbol.dart';

final forexServiceProvider = Provider.autoDispose<FinnhubService>((ref) {
  return FinnhubServiceImpl(ref);
},);

abstract class FinnhubService {
  Future<List<ForexSymbol>> fetchForexPairs();
}

class FinnhubServiceImpl implements FinnhubService {
  Ref ref;
  final String _apiKey = 'cuop0khr01qve8puksi0cuop0khr01qve8puksig';

  FinnhubServiceImpl(this.ref);

  @override
  Future<List<ForexSymbol>> fetchForexPairs() async {
    // For now, returning mock data
    final response = await ref.read(diosServiceProvider).get('/forex/symbol?exchange=fxpig&token=$_apiKey');
  if (response.statusCode == 200) {
    final List data = response.data;
    return data.take(5).map((item) => ForexSymbol.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load forex symbols');
  }
  }

}
