import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/core/dio/dio_service.dart';
import 'package:fxtm/features/forex/models/forex_symbol.dart';

final forexServiceProvider = Provider.autoDispose<FinnhubService>((ref) {
  return FinnhubServiceImpl(ref.read(diosServiceProvider));
},);

abstract class FinnhubService {
  Future<List<ForexSymbol>> fetchForexPairs();
}

class FinnhubServiceImpl implements FinnhubService {
 // Ref ref;
  final String _apiKey = 'cuop0khr01qve8puksi0cuop0khr01qve8puksig';
  final Dio _dio;

  FinnhubServiceImpl(this._dio);

  @override
  Future<List<ForexSymbol>> fetchForexPairs() async {
    // For now, returning mock data
    final response = await _dio.get('/forex/symbol?exchange=fxpig&token=$_apiKey');
  if (response.statusCode == 200) {
    try {
              final List data = response.data;
        return data.take(5).map((item) => ForexSymbol.fromJson(item)).toList();

    } catch(e, stacktrace) {
        throw Exception('Failed to load forex symbols');
    }
  } else {
    throw Exception('Failed to load forex symbols');
  }
  }

}
