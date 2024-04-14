// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_tag_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceTagResultModel _$PriceTagResultModelFromJson(Map<String, dynamic> json) =>
    PriceTagResultModel(
      productName: json['itemName'] as String,
      productPrice: (json['itemPrice'] as num).toDouble(),
      confidencePercent: (json['confidencePercent'] as num).toDouble(),
    );

Map<String, dynamic> _$PriceTagResultModelToJson(
        PriceTagResultModel instance) =>
    <String, dynamic>{
      'itemName': instance.productName,
      'itemPrice': instance.productPrice,
      'confidencePercent': instance.confidencePercent,
    };
