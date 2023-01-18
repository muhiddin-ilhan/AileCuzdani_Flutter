import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Widget listCardItem({
  Icon? prefixIcon,
  required Function()? onTap,
  required String titleText,
  required String subTitleText,
  Widget? suffixWidget,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: CustomColors.WHITE,
      boxShadow: [
        BoxShadow(
          blurRadius: 15,
          spreadRadius: 1,
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 0),
        ),
      ],
    ),
    margin: const EdgeInsets.only(left: 28, right: 28),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.DARK_WHITE,
                ),
                child: prefixIcon ??
                    Icon(
                      Icons.person,
                      color: CustomColors.BLACK.withOpacity(0.6),
                    ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      titleText,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: CustomColors.LIGHT_BLACK,
                        fontFamily: "JosefinSans",
                        fontSize: 13,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      subTitleText,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color.fromARGB(201, 59, 59, 59),
                        fontFamily: "JosefinSans",
                        fontSize: 12,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              suffixWidget ?? const SizedBox(),
            ],
          ),
        ),
      ),
    ),
  );
}
