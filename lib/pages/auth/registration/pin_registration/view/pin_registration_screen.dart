import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/config/router/main_navigation.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/data/auth/api/registration_api.dart';
import 'package:lemon/pages/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({
    super.key,
    required this.regInfo,
    required this.isPhone,
  });

  final RegistrationInformation regInfo;
  final bool isPhone;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
//?-----------------------CONSTANTS-----------------------?\\\

  TextEditingController verifictionCodeController = TextEditingController();

  bool isPinCodeFilled = false;
  bool isPinCodeError = false;

//?-----------------------CONSTANTS-----------------------?\\\

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var width = mediaQuery.size.width;

    ///-------------------------------------------SCREEN's STRUCTURE-------------------------------------------\\\

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundClr,
        body: SizedBox(
          width: width,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: width * 0.15,
                    child: ASText(
                      text: 'Регистрация',
                      color: darkGrayClr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: width * 0.2),
                  AppPincodefield(
                    verifictionCodeController: verifictionCodeController,
                    isPinCodeError: isPinCodeError,
                    onCompletedEvent: onCompletedEvent,
                  ),
                  SizedBox(height: width * 0.1),
                  AnimatedOpacity(
                    opacity: isPinCodeError ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInCubic,
                    child: SizedBox(
                      height: width * 0.05,
                      child: ASText(
                        text: 'Введен неккоректный пинкод',
                        color: errorColor,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(height: width * 0.13),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onCompletedEvent(String pin) async {
    if (widget.isPhone) {
      GetIt.I<AppRouter>().push(const MainCameraRoute());
      var prefs = GetIt.I<SharedPreferences>();
      prefs.setString('phone_number', widget.regInfo.phone.toString());
      prefs.setString('password', widget.regInfo.password.toString());
      prefs.setBool('is_entrance', true);
    } else {
      if (!await RegistrationApi().checkVerificationCodePost(
        widget.regInfo.mail,
        pin,
      )) {
        setState(() => isPinCodeError = true);
      } else {
        widget.regInfo.emailCode = pin;
        setState(() => isPinCodeError = false);
        GetIt.I<AppRouter>().push(
          PhoneRegistrationRoute(regInfo: widget.regInfo),
        );
      }
    }
  }
}
