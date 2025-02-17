import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final diosServiceProvider = Provider((ref) {
  return DioService().dio;
});

class DioService {
  final Dio _dio = Dio();

  DioService() {
    _dio.options.baseUrl = "https://finnhub.io/api/v1";
    _dio.interceptors.add(LogInterceptor(
      request: true, 
      requestBody: true, 
      responseBody: true, 
      responseHeader: false, 
      error: true, 
      requestHeader: true,
    ));
  }

  Dio get dio => _dio;
}