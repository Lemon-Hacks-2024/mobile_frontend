import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/pages/main/main_screen/main_screen.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.menuButtons,
  });

  final SliderMenuButton menuButtons;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Column(
      children: [
        Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  width: width * 0.07692,
                  height: width * 0.07692,
                  child: Icon(menuButtons.icon),
                ),
                SizedBox(width: width * 0.03846),
                SizedBox(
                  height: width * 0.0641,
                  child: ASText(
                    text: menuButtons.btnText,
                    color: darkGrayClr,
                    textAlign: TextAlign.start,
                  ),
                )
              ],
            ),
            SizedBox(
              width: width,
              height: width * 0.07692,
              child: MaterialButton(
                onPressed: () {},
              ),
            )
          ],
        ),
        SizedBox(height: width * 0.05128),
      ],
    );
  }
}
