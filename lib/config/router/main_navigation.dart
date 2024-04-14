import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/pages/main/main.dart';

// import 'package:get_it/get_it.dart';
import 'package:lemon/pages/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

part 'main_navigation.gr.dart';

//!___________________________________________КОНЕЦ ИМПОРТОВ________________________________________________!\\

class CheckAuth {
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<bool> checkAuth() async {
    var prefs = GetIt.I<SharedPreferences>();
    bool? isEntrance = prefs.getBool('is_entrance');
    if (isEntrance == null) return _isAuth = false;
    if (!isEntrance) {
      return _isAuth = false;
    } else {
      return _isAuth = true;
    }
  }
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: MainCameraRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300,
          reverseDurationInMilliseconds: 150,
        ),
        CustomRoute(
          page: EntranceRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 300,
          reverseDurationInMilliseconds: 150,
        ),
        CustomRoute(
          page: MailRegistrationRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
        CustomRoute(
          page: PhoneRegistrationRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
        CustomRoute(
          page: VerificationCodeRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
        CustomRoute(
          page: PhotoSendingRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
        CustomRoute(
          page: ThanksRoute.page,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 100,
        ),
      ];
}
