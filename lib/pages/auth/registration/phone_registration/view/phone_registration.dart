import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';

import 'package:lemon/core/core.dart';
import 'package:lemon/data/auth/api/registration_api.dart';
import 'package:lemon/pages/auth/registration/registration.dart';
import 'package:lemon/widgets/registration_phonefield.dart';
import 'package:lemon/widgets/widgets.dart';

@RoutePage()
class PhoneRegistrationScreen extends StatefulWidget {
  const PhoneRegistrationScreen({
    super.key,
    required this.regInfo,
  });

  final RegistrationInformation regInfo;

  @override
  State<PhoneRegistrationScreen> createState() =>
      _PhoneRegistrationScreenState();
}

class _PhoneRegistrationScreenState extends State<PhoneRegistrationScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPhoneFilled = false,
      isPasswordLength = false,
      isPasswordVisibility = true;

  @override
  void initState() {
    phoneController.addListener(() {
      if (phoneController.text.length == 13) {
        setState(() => isPhoneFilled = true);
      } else {
        setState(() => isPhoneFilled = false);
      }
    });
    passwordController.addListener(() {
      if (passwordController.text.length >= 8) {
        setState(() => isPasswordLength = true);
      } else {
        setState(() => isPasswordLength = false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;

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
                  AppPhonefield(
                    controller: phoneController,
                    text: '999-999-99-99',
                    label: 'Телефон',
                  ),
                  AppTextfield(
                    controller: passwordController,
                    text: '********',
                    label: 'Пароль',
                    icon: CustomIcons.padlock,
                    regexp: ' ',
                    isPass: true,
                    isPassVisible: isPasswordVisibility,
                    passEvent: togglePasswordVisibility,
                  ),
                  SizedBox(height: width * 0.1),
                  RegistrationButton(
                    isPhoneFilled: isPhoneFilled,
                    isPasswordLength: isPasswordLength,
                    password: passwordController.text,
                    phone: phoneController.text,
                    regInfo: widget.regInfo,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() =>
      setState(() => isPasswordVisibility = !isPasswordVisibility);
}

class RegistrationButton extends StatefulWidget {
  const RegistrationButton({
    super.key,
    required this.isPhoneFilled,
    required this.isPasswordLength,
    required this.password,
    required this.phone,
    required this.regInfo,
  });

  final RegistrationInformation regInfo;
  final String password, phone;
  final bool isPhoneFilled, isPasswordLength;

  @override
  State<RegistrationButton> createState() => _RegistrationButtonState();
}

class _RegistrationButtonState extends State<RegistrationButton> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width * 0.6,
          height: width * 0.13,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isPhoneFilled && widget.isPasswordLength
                  ? const [Color(0xFFF5515F), Color(0xFFA1051D)]
                  : [lightGrayClr, lightGrayClr],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(width * 0.02564),
            boxShadow: [
              BoxShadow(
                color: blackClr.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SizedBox(
          height: width * 0.07,
          child: ASText(
            text: 'Подтвердить',
            color: widget.isPhoneFilled && widget.isPasswordLength
                ? whiteClr
                : darkGrayClr,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: width * 0.6,
          height: width * 0.13,
          child: MaterialButton(
            onPressed: widget.isPhoneFilled && widget.isPasswordLength
                ? () async {
                    widget.regInfo.password = widget.password;
                    widget.regInfo.phone =
                        '8${widget.phone.replaceAll('-', '').replaceAll(' ', '')}';
                    if (await RegistrationApi().registrationAccountPost(
                      widget.regInfo,
                    )) {
                      GetIt.I<AppRouter>().push(
                        VerificationCodeRoute(
                          regInfo: widget.regInfo,
                          isPhone: true,
                        ),
                      );
                    }
                  }
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                width * 0.02564,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
