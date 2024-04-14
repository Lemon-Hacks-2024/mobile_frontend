import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/core/core.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

@RoutePage()
class ThanksScreen extends StatefulWidget {
  const ThanksScreen({
    super.key,
    required this.isSuccess,
  });

  final bool isSuccess;

  @override
  State<ThanksScreen> createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  String successText =
      'Мы проверили Вашу заявку и обнаружили нарушение. Исправим в ближайшее время. Благодарим Вас!';
  String failureText =
      'Мы проверили Вашу заявку. Цена соответствует требованиям и явялется допустимой. Благодарим Вас за выделенное время!';
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CustomIcons.clapping,
              size: width * 0.4,
            ),
            SizedBox(height: width * 0.2),
            SizedBox(
              width: width * 0.9,
              height: width * 0.1,
              child: ASText(
                text: 'Благодарим за осознанность!',
                color: darkGrayClr,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: width * 0.05),
            SizedBox(
              width: width * 0.9,
              height: width * 0.25,
              child: ASText(
                text: widget.isSuccess ? successText : failureText,
                color: darkGrayClr.withOpacity(0.8),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: width * 0.05),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width * 0.5,
                  height: width * 0.14,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: blackClr),
                  ),
                  child: Text(
                    'На главную',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: darkGrayClr,
                      fontFamily: fontLato,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.5,
                  height: width * 0.14,
                  child: TapDebouncer(
                    cooldown: const Duration(seconds: 1),
                    onTap: () => GetIt.I<AppRouter>().push(
                      const MainCameraRoute(),
                    ),
                    builder: (context, onTap) => MaterialButton(
                      onPressed: onTap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
