import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/data/main/models/price_tag_model.dart';
import 'package:lemon/data/main/models/price_tag_result_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PhotoSendingApi {
  Future<PriceTagModel> photoSendingApiPost(String photoPath) async {
    var headers = {
      'x-access-token':
          'bd90d3568c2f320246035475910aef708445f20d59afe3b6670d9650368a6033',
    };

    FormData data = FormData.fromMap({
      "price_tag": await MultipartFile.fromFile(photoPath),
    });

    try {
      var response = await GetIt.I<Dio>().request(
        '$urlApi/recognise',
        options: Options(method: 'POST', headers: headers),
        data: data,
      );

      final apiData = response.data as Map<String, dynamic>;
      GetIt.I<Talker>().good(apiData);

      final PriceTagModel priceTagData = PriceTagModel(
        result: PriceTagResultModel.fromJson(apiData['result']),
        link: apiData['priceTagHref'],
      );

      return priceTagData;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return PriceTagModel(
        result: PriceTagResultModel(
          productName: '',
          productPrice: 0.0,
          confidencePercent: 0.0,
        ),
        link: '',
      );
    }
  }
}
