import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/functions.dart';

class AppTextfield extends StatefulWidget {
  const AppTextfield({
    super.key,
    required this.controller,
    required this.text,
    required this.label,
    this.icon,
    this.regexp = '',
    this.isMail = false,
    this.isPass = false,
    this.isPassVisible = false,
    this.passEvent,
  });

  final TextEditingController controller;
  final String text, label;
  final IconData? icon;
  final String regexp;
  final bool isMail, isPass, isPassVisible;
  final Function()? passEvent;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double queryData = mediaQuery.textScaleFactor;
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget suffixIconPass = Container(
      padding: EdgeInsets.only(
        left: width * 0.02564,
        right: width * 0.07692,
      ),
      child: IconButton(
        icon: widget.isPassVisible
            ? Icon(
                Icons.visibility_off_outlined,
                color: Theme.of(context).iconTheme.color,
              )
            : Icon(
                Icons.visibility_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
        onPressed: widget.passEvent,
        color: darkGrayClr,
      ),
    );

    Widget suffixIcon = SizedBox(width: width * 0.05128);

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
          child: TextFormField(
            controller: widget.controller,
            inputFormatters: <TextInputFormatter>[
              widget.isMail || widget.isPass
                  ? FilteringTextInputFormatter.deny(
                      RegExp('[${widget.regexp}]'),
                    )
                  : FilteringTextInputFormatter.allow(
                      RegExp('[${widget.regexp}ё]'),
                    ),
            ],
            keyboardType:
                widget.isMail ? TextInputType.emailAddress : TextInputType.text,
            textInputAction: TextInputAction.next,
            style: textTheme.titleLarge?.copyWith(
              color: darkGrayClr,
              fontSize: 24 / queryData,
              fontFamily: fontLato,
            ),
            obscureText: widget.isPassVisible,
            decoration: TextfieldDecoration(
              context: context,
              text: widget.text,
              label: widget.label,
              icon: widget.icon,
              suffixIcon: widget.isPass ? suffixIconPass : suffixIcon,
            ).textfieldDecoration(),
          ),
        ),
        SizedBox(height: width * 0.04179),
      ],
    );
  }
}
