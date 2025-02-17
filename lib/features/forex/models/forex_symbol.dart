import 'package:freezed_annotation/freezed_annotation.dart';

part 'forex_symbol.freezed.dart';
part 'forex_symbol.g.dart';

@freezed
class ForexSymbol with _$ForexSymbol {
  const factory ForexSymbol({
    required String description,
    required String displaySymbol,
    required String symbol,
  }) = _ForexSymbol;

  factory ForexSymbol.fromJson(Map<String, dynamic> json) => _$ForexSymbolFromJson(json);
}