import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/pages/auth/auth.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TownsList {
  TownsList({
    required this.id,
    required this.town,
  });

  final int id;
  final String town;
}

class RegistrationApi {
  Future<List<TownsList>> citySearching(String cityValue) async {
    try {
      var response = await GetIt.I<Dio>().request(
        'https://t-app.ru/api/cities/?query=$cityValue',
        options: Options(method: 'GET'),
      );

      final data = response.data['details'] as Map<String, dynamic>;
      List<TownsList> towns = [];

      for (int i = 0; i < data.length; i++) {
        towns.add(
          TownsList(
            id: data[i]['id'],
            town: data[i]['name'],
          ),
        );
      }

      return towns;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return [];
    }
  }

  Future<bool> getVerificationCode(String mail) async {
    try {
      await GetIt.I<Dio>().request(
        'https://t-app.ru/api/verify-code/email/$mail',
        options: Options(method: 'GET'),
      );

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return false;
    }
  }

  Future<bool> checkVerificationCodePost(String email, String pin) async {
    var data = {
      'email': email,
      'email_code': pin,
    };
    try {
      await GetIt.I<Dio>().request(
        'https://t-app.ru/api/verify-code/email',
        options: Options(method: 'POST'),
        data: data,
      );

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return false;
    }
  }

  Future<bool> registrationAccountPost(RegistrationInformation regInfo) async {
    var data = {
      "name": regInfo.name,
      "surname": regInfo.lastName,
      "city_id": 4,
      "email": regInfo.mail,
      "email_code": regInfo.emailCode,
      "phone_number": regInfo.phone,
      "phone_number_code": "0000",
      "password": regInfo.password,
      "imei_id": "12345678"
    };

    try {
      await GetIt.I<Dio>().request(
        'https://t-app.ru/api/registration',
        options: Options(method: 'POST'),
        data: data,
      );

      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return false;
    }
  }
}
