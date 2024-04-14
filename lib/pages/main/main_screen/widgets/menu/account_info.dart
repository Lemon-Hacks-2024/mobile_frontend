import 'package:flutter/material.dart';
import 'package:lemon/core/core.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double width = mediaQuery.size.width;
    return SizedBox(
      height: width * 0.1923,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: width * 0.11025,
                child: ASText(
                  text: 'Имя Фамилия',
                  color: darkGrayClr,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: width * 0.06154,
                child: ASText(
                  text: 'Донецк',
                  color: darkGrayClr.withOpacity(0.6),
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          SizedBox(
            width: width,
            height: width * 0.1923,
            child: MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          )
        ],
      ),
    );
  }
}
