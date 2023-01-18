// ignore_for_file: file_names

import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, {List<Widget>? actions, required String title, Widget? leading}) {
  return AppBar(
    actions: actions,
    title: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: "JosefinSans",
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    backgroundColor: CustomColors.DARK_GREEN,
    centerTitle: true,
    elevation: 2,
    leading: leading,
    automaticallyImplyLeading: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(44, 15),
        bottomRight: Radius.elliptical(44, 15),
      ),
    ),
  );
}
