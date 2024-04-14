import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:lemon/config/config.dart';
import 'package:lemon/core/core.dart';
import 'package:lemon/pages/main/main_screen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.menuButtons,
  });

  final List<SliderMenuButton> menuButtons;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Drawer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: width * 0.20513,
          horizontal: width * 0.05641,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const AccountInfo(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: width * 0.041),
                  child: Container(
                    width: width,
                    height: 1,
                    color: lightGrayClr.withOpacity(0.9),
                  ),
                ),
                MenuButtonsBuilder(menuButtons: menuButtons)
              ],
            ),
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  height: width * 0.06154,
                  child: ASText(
                    text: 'Выйти',
                    color: errorColor,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: width * 0.09154,
                  child: MaterialButton(
                    onPressed: () {
                      GetIt.I<SharedPreferences>().setBool(
                        'is_entrance',
                        false,
                      );
                      GetIt.I<AppRouter>().push(const EntranceRoute());
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
