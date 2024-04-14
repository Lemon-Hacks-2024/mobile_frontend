import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onIconPressed,
  });

  final IconData icon;
  final double size;
  final Function() onIconPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(icon, color: lightGrayClr, size: size),
        SizedBox(
          width: size + 15,
          height: size + 15,
          child: MaterialButton(
            onPressed: onIconPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        )
      ],
    );
  }
}
