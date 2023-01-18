import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

Widget customShowCase({required GlobalKey key, required String description, required Widget child}) {
  return Showcase(
    key: key,
    description: description,
    blurValue: 1,
    descTextStyle: const TextStyle(
      fontFamily: "JosefinSans",
      fontSize: 14,
      height: 1.4,
      fontWeight: FontWeight.w500,
    ),
    overlayColor: Colors.black,
    overlayOpacity: 0.4,
    showArrow: true,
    targetBorderRadius: BorderRadius.circular(8),
    targetPadding: const EdgeInsets.all(5),
    child: child,
  );
}
