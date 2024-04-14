import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPincodefield extends StatelessWidget {
  const AppPincodefield({
    super.key,
    required this.verifictionCodeController,
    required this.isPinCodeError,
    required this.onCompletedEvent,
  });

  final TextEditingController verifictionCodeController;
  final bool isPinCodeError;
  final Function onCompletedEvent;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var width = mediaQuery.size.width;
    return SizedBox(
      width: width * 0.90435,
      height: width * 0.23948,
      child: PinCodeTextField(
        controller: verifictionCodeController,
        onCompleted: (value) {
          onCompletedEvent(value);
        },
        beforeTextPaste: (text) {
          return true;
        },
        appContext: context,
        length: 4,
        keyboardType: TextInputType.number,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldWidth: width * 0.21513,
          fieldHeight: width * 0.21513,
          selectedColor: isPinCodeError ? darkGrayClr : errorColor,
          activeColor: isPinCodeError ? darkGrayClr : errorColor,
          inactiveColor: darkGrayClr,
        ),
        textStyle: TextStyle(
          color: darkGrayClr,
          fontFamily: fontLato,
          fontSize: width * 0.17513,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
