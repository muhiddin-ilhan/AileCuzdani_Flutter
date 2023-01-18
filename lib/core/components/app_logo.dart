import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Widget appLogo({required double height, required double width, required double textSize}) {
  return SizedBox(
    height: height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: "LOGO",
          child: Image.asset(
            Assets.LOGO,
            width: width,
          ),
        ),
        const SizedBox(height: 4),
        Hero(
          tag: "TITLE",
          child: Material(
            color: Colors.transparent,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Aile Cüzdanım",
                style: TextStyle(
                  color: CustomColors.VERY_DARK_GREEN,
                  fontFamily: "JosefinSans",
                  fontWeight: FontWeight.w900,
                  fontSize: textSize,
                  letterSpacing: 0.7,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
