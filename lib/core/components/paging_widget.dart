import 'package:aile_cuzdani/core/model/dto_paging.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Widget pagingWidget({required DTOPaging? paging}) {
  if (paging == null) {
    return const SizedBox();
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          height: 35,
          margin: const EdgeInsets.only(left: 28.0, bottom: 8, top: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.15),
            ),
          ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: CustomColors.LIGHT_BLACK.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Text(
          "1/4",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: CustomColors.VERY_DARK_GREEN.withOpacity(0.75),
            fontFamily: "JosefinSans",
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 35,
          margin: const EdgeInsets.only(right: 28, bottom: 8, top: 8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.1),
            ),
          ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: CustomColors.LIGHT_BLACK.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
