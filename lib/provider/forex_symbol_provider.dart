import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fxtm/models/forex_symbol.dart';
import 'package:fxtm/repositories/forex_repository.dart';

part 'forex_symbol_provider.g.dart';

@riverpod
Future<List<ForexSymbol>> forexSymbol(Ref ref) async {
  ref.keepAlive();
  return ref.read(forexRepoProvider).getForexPairs();
}
