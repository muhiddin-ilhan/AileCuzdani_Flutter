import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Widget customTabItem({required String title, required Function() onTap, bool selected = false}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 35,
      decoration: BoxDecoration(
        color: selected ? CustomColors.GREEN : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 7,
            color: Colors.black.withOpacity(0.03),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontFamily: "JosefinSans",
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : const Color.fromARGB(255, 95, 95, 95),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
