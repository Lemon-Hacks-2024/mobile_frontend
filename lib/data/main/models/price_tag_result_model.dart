import 'package:json_annotation/json_annotation.dart';

part 'price_tag_result_model.g.dart';

@JsonSerializable()
class PriceTagResultModel {
  PriceTagResultModel({
    required this.productName,
    required this.productPrice,
    required this.confidencePercent,
  });

  @JsonKey(name: 'itemName')
  final String productName;
  @JsonKey(name: 'itemPrice')
  final double productPrice;
  final double confidencePercent;

  factory PriceTagResultModel.fromJson(Map<String, dynamic> json) =>
      _$PriceTagResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceTagResultModelToJson(this);
}
