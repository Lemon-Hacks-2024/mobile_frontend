import 'package:flutter/material.dart';
import 'package:lemon/pages/main/main_screen/main_screen.dart';

class MenuButtonsBuilder extends StatelessWidget {
  const MenuButtonsBuilder({
    super.key,
    required this.menuButtons,
  });

  final List<SliderMenuButton> menuButtons;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    return SizedBox(
      height: height / 3,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 0),
        itemCount: menuButtons.length,
        itemBuilder: (context, index) {
          return MenuButton(menuButtons: menuButtons[index]);
        },
      ),
    );
  }
}
