import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

class PhotoSendingButton extends StatelessWidget {
  const PhotoSendingButton({
    super.key,
    required this.isLike,
    required this.onPressed,
  });

  final bool isLike;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width * 0.21795,
          height: width * 0.21795,
          decoration: BoxDecoration(
            color: whiteClr,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF540000,
                ).withOpacity(0.25),
                offset: const Offset(0, 2),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        RotatedBox(
          quarterTurns: isLike ? 0 : 90,
          child: Icon(
            CustomIcons.like,
            size: width * 0.11282,
            color: isLike ? const Color(0xFF1B8D27) : const Color(0xFFB52F2F),
          ),
        ),
        SizedBox(
          width: width * 0.21795,
          height: width * 0.21795,
          child: MaterialButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
