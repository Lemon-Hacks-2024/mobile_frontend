import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/config/router/main_navigation.dart';
import 'package:lemon/core/core.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lemon/data/auth/api/registration_api.dart';
import 'package:lemon/pages/auth/auth.dart';
import 'package:lemon/widgets/widgets.dart';

@RoutePage()
class MailRegistrationScreen extends StatefulWidget {
  const MailRegistrationScreen({super.key});

  @override
  State<MailRegistrationScreen> createState() => _MailRegistrationScreenState();
}

class _MailRegistrationScreenState extends State<MailRegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  bool isNameFilled = false,
      isLastNameFilled = false,
      isMailFilled = false,
      isErrorEmail = false,
      visibleEmail = false;
  String cityValue = '';
  List<TownsList> towns = [];

  // getTowns()async{
  //   towns = await RegistrationApi().
  // }
  @override
  void initState() {
    nameController.addListener(() {
      final isNameFilled = nameController.text.isEmpty;
      setState(() => this.isNameFilled = !isNameFilled);
    });
    lastNameController.addListener(() {
      final isLastNameFilled = lastNameController.text.isEmpty;
      setState(() => this.isLastNameFilled = !isLastNameFilled);
    });
    mailController.addListener(() {
      final isMailFilled = mailController.text.isEmpty;
      setState(() => this.isMailFilled = !isMailFilled);
    });

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    mailController.dispose();
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
        body: Stack(
          children: [
            const BackButtonWidget(),
            SizedBox(
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
                      AppTextfield(
                        controller: nameController,
                        text: 'Иван',
                        label: 'Имя',
                        icon: CustomIcons.user,
                        regexp: 'a-zA-Zа-яА-Я-',
                      ),
                      AppTextfield(
                        controller: lastNameController,
                        text: 'Иванов',
                        label: 'Фамилия',
                        icon: CustomIcons.user,
                        regexp: 'a-zA-Zа-яА-Я-',
                      ),
                      CityEditTextfield(
                        citiesList: ['Донецк'],
                        saveCityValue: saveCity,
                        isIcon: true,
                      ),
                      AppTextfield(
                        controller: mailController,
                        text: 'example@mail.ru',
                        label: 'Почта',
                        icon: CustomIcons.mail,
                        isMail: true,
                        regexp: '[ ]',
                      ),
                      AnimatedOpacity(
                        opacity: visibleEmail ? 1 : 0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInCubic,
                        child: SizedBox(
                          height: width * 0.05,
                          child: ASText(
                            text: 'Введена неккоректная почта',
                            color: errorColor,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      SizedBox(height: width * 0.1),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: width * 0.6,
                            height: width * 0.13,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isNameFilled &&
                                        isLastNameFilled &&
                                        isMailFilled &&
                                        cityValue.isNotEmpty
                                    ? const [
                                        Color(0xFFF5515F),
                                        Color(0xFFA1051D)
                                      ]
                                    : [lightGrayClr, lightGrayClr],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius:
                                  BorderRadius.circular(width * 0.02564),
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
                              color: isNameFilled &&
                                      isLastNameFilled &&
                                      isMailFilled &&
                                      cityValue.isNotEmpty
                                  ? whiteClr
                                  : darkGrayClr,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.6,
                            height: width * 0.13,
                            child: MaterialButton(
                              onPressed: isNameFilled &&
                                      isLastNameFilled &&
                                      isMailFilled &&
                                      cityValue.isNotEmpty
                                  ? () async {
                                      if (!incorrectEmailError()) {
                                        RegistrationInformation regInfo =
                                            RegistrationInformation(
                                          name: nameController.text,
                                          lastName: lastNameController.text,
                                          city: cityValue,
                                          mail: mailController.text,
                                        );
                                        if (await RegistrationApi()
                                            .getVerificationCode(
                                          mailController.text,
                                        )) {
                                          GetIt.I<AppRouter>().push(
                                            VerificationCodeRoute(
                                              regInfo: regInfo,
                                              isPhone: false,
                                            ),
                                          );
                                        }
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveCity(String value) {
    setState(() => cityValue = value);
  }

  bool incorrectEmailError() {
    setState(() {
      isErrorEmail = !EmailValidator.validate(mailController.text);
      visibleEmail = isErrorEmail ? true : false;
    });
    return isErrorEmail;
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Positioned(
      top: width * 0.2,
      left: width * 0.03,
      child: Stack(
        children: [
          Container(
            width: width * 0.12,
            height: width * 0.12,
            decoration: BoxDecoration(
              color: darkGrayClr.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_sharp,
              color: whiteClr,
            ),
          ),
          SizedBox(
            width: width * 0.12,
            height: width * 0.12,
            child: MaterialButton(
              onPressed: () => GetIt.I<AppRouter>().popForced(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
