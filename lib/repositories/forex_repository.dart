import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fxtm/models/forex_symbol.dart';
import '../services/finnhub_service.dart';


final forexRepoProvider = Provider.autoDispose<ForexRepository>((ref) {
  return ForexRepository(ref);
},);

class ForexRepository {
//  final FinnhubService _service;
  Ref ref;

  ForexRepository(this.ref);

  Future<List<ForexSymbol>> getForexPairs() {
    return ref.read(forexServiceProvider).fetchForexPairs();
  }
}
