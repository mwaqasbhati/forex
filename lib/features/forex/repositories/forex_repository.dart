import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/features/forex/models/forex_symbol.dart';
import '../services/finnhub_service.dart';


final forexRepoProvider = Provider.autoDispose<ForexRepository>((ref) {
  return ForexRepository(ref.read(forexServiceProvider));
},);

class ForexRepository {
  final FinnhubService _service;
//  Ref ref;

  ForexRepository(this._service);

  Future<List<ForexSymbol>> getForexPairs() {
    return _service.fetchForexPairs();
  }
}
