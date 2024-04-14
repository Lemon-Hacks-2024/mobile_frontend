import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

class TextfieldDecoration {
  TextfieldDecoration({
    required this.context,
    required this.text,
    required this.label,
    this.icon,
    this.suffixIcon,
  });
  final BuildContext context;
  final String text, label;
  final IconData? icon;
  final Widget? suffixIcon;

  InputDecoration textfieldDecoration() {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double queryData = mediaQuery.textScaleFactor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return InputDecoration(
      isDense: true,
      label: SizedBox(
        height: width * 0.05,
        child: ASText(
          text: label,
          color: darkGrayClr,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.normal,
        ),
      ),
      hintText: text,
      hintStyle: textTheme.titleLarge?.copyWith(
        color: darkGrayClr.withOpacity(0.6),
        fontSize: 22 / queryData,
        fontFamily: fontLato,
      ),
      prefixIcon: Container(
        padding: EdgeInsets.fromLTRB(width * 0.02564, 0, width * 0.02564, 0),
        child: Icon(
          icon,
          color: Theme.of(context).iconTheme.color,
          size: width * 0.05692,
        ),
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: whiteClr,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(width * 0.02564),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: whiteClr,
        ),
        borderRadius: BorderRadius.circular(width * 0.02564),
      ),
    );
  }

  InputDecoration phonefieldDecoration() {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    double queryData = mediaQuery.textScaleFactor;
    TextTheme textTheme = Theme.of(context).textTheme;
    return InputDecoration(
      isDense: true,
      label: SizedBox(
        height: width * 0.05,
        child: ASText(
          text: label,
          color: darkGrayClr,
          textAlign: TextAlign.start,
          fontWeight: FontWeight.normal,
        ),
      ),
      hintText: text,
      hintStyle: textTheme.titleLarge?.copyWith(
        color: darkGrayClr.withOpacity(0.6),
        fontSize: 22 / queryData,
        fontFamily: fontLato,
      ),
      filled: true,
      fillColor: whiteClr,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(
          width * 0.02564,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: mainClr,
        ),
        borderRadius: BorderRadius.circular(
          width * 0.02564,
        ),
      ),
    );
  }
}
