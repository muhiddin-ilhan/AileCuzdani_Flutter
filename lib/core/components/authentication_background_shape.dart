import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/sizer_utils.dart';

Widget authenticationBackgroundShape(BuildContext context) {
  return Hero(
    tag: "BACKGROUND",
    child: Container(
      height: Sizer.getHeight(context) * 0.69,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            CustomColors.GREEN,
            CustomColors.DARK_GREEN,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 1),
          stops: [0.25, 1],
          tileMode: TileMode.clamp,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(Sizer.getWidth(context) * 0.5, Sizer.getHeight(context) * 0.64 * 0.1),
          bottomRight: Radius.elliptical(Sizer.getWidth(context) * 0.5, Sizer.getHeight(context) * 0.64 * 0.1),
        ),
      ),
    ),
  );
}
