import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/functions.dart';

class AppPhonefield extends StatefulWidget {
  const AppPhonefield({
    super.key,
    required this.controller,
    required this.text,
    required this.label,
  });

  final TextEditingController controller;
  final String text, label;

  @override
  State<AppPhonefield> createState() => _AppPhonefieldState();
}

class _AppPhonefieldState extends State<AppPhonefield> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double queryData = mediaQuery.textScaleFactor;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          width: width * 0.90923,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: blackClr.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: InternationalPhoneNumberInput(
            textFieldController: widget.controller,
            onInputChanged: (value) {},
            searchBoxDecoration: null,
            countries: const ['RU'],
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              useBottomSheetSafeArea: true,
              setSelectorButtonAsPrefixIcon: true,
              leadingPadding: 10,
            ),
            textStyle: textTheme.titleLarge?.copyWith(
              color: darkGrayClr,
              fontSize: 22 / queryData,
            ),
            maxLength: 13,
            inputDecoration: TextfieldDecoration(
              context: context,
              text: widget.text,
              label: widget.label,
            ).phonefieldDecoration(),
          ),
        ),
        SizedBox(height: width * 0.04179),
      ],
    );
  }
}
