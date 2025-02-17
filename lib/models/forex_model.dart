import 'package:freezed_annotation/freezed_annotation.dart';

part 'forex_model.freezed.dart';
part 'forex_model.g.dart';

@freezed
class ForexModel with _$ForexModel {
  const factory ForexModel({
    required String symbol,
    required double price,
    required double oldPrice,
    required double change,
    required bool isUp,
    required double timestamp
  }) = _ForexModel;

  factory ForexModel.fromJson(Map<String, dynamic> json) => _$ForexModelFromJson(json);
}
