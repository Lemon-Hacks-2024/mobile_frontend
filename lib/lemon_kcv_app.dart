import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LemonKCVApp extends StatefulWidget {
  const LemonKCVApp({super.key});

  @override
  State<LemonKCVApp> createState() => _LemonKCVAppState();
}

class _LemonKCVAppState extends State<LemonKCVApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Контролируем цены вместе!',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ru', 'RU')],
      routerConfig: GetIt.I<AppRouter>().config(
        deepLinkBuilder: (deepLink) async {
          final model = CheckAuth();
          await model.checkAuth();
          if (model.isAuth) {
            return DeepLink.single(const MainCameraRoute());
          } else {
            return DeepLink.single(const EntranceRoute());
          }
        },
        navigatorObservers: () => [
          TalkerRouteObserver(GetIt.I<Talker>()),
        ],
      ),
    );
  }
}
