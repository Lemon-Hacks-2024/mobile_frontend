import 'package:flutter/material.dart';

class BackgroundClippedBlur extends CustomClipper<Path> {
  BackgroundClippedBlur({
    super.reclip,
    required this.focusHeight,
  });

  final double focusHeight;

  @override
  Path getClip(Size size) {
    RRect roundRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: focusHeight,
        height: focusHeight / 1.75,
      ),
      const Radius.circular(20),
    );

    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()
        ..addRRect(roundRect)
        ..close(),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
