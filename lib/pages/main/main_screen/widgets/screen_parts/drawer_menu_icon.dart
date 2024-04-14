import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

class DrawerMenuIcon extends StatelessWidget {
  const DrawerMenuIcon({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Stack(
      children: [
        SizedBox(
          width: width * 0.10256,
          height: width * 0.10256,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuIconStroke(),
              MenuIconStroke(),
              MenuIconStroke(),
            ],
          ),
        ),
        SizedBox(
          width: width * 0.10256,
          height: width * 0.10256,
          child: MaterialButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        )
      ],
    );
  }
}

class MenuIconStroke extends StatelessWidget {
  const MenuIconStroke({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return Container(
      width: width * 0.09487,
      height: width * 0.00769,
      decoration: BoxDecoration(
        color: lightGrayClr,
        borderRadius: BorderRadius.circular(width),
      ),
    );
  }
}
