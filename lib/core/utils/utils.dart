import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

class ASText extends StatelessWidget {
  const ASText({
    super.key,
    required this.text,
    required this.color,
    required this.textAlign,
    this.overflowReplacement,
    this.overflow,
    this.textStyle,
    this.fontWeight,
  });

  final String text;
  final Color color;
  final TextAlign textAlign;
  final Widget? overflowReplacement;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      overflow: overflow,
      overflowReplacement: overflowReplacement,
      style: textStyle ??
          TextStyle(
            fontSize: 70,
            color: color,
            fontFamily: fontLato,
            fontWeight: fontWeight ?? FontWeight.bold,
            decoration: TextDecoration.none,
          ),
    );
  }
}
