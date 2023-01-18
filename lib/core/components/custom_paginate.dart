import 'dart:developer';

import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Widget customPaginate({int? currentPage, int? totalPage, required Function(int) onTap}) {
  if (currentPage == null || totalPage == null) {
    return const SizedBox();
  }
  if (totalPage < 2) {
    return const SizedBox();
  }

  const double height = 35;
  final ScrollController scrollController = ScrollController();

  try {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo((scrollController.position.maxScrollExtent / totalPage) * (currentPage - 0.5));
    });
  } catch (e) {
    log(e.toString());
  }

  return Container(
    height: height,
    margin: const EdgeInsets.only(left: 28, right: 28, bottom: 6, top: 6),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 246, 246, 246),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        InkWell(
          onTap: () {
            if (currentPage > 1) {
              onTap(currentPage - 1);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.keyboard_arrow_left_rounded),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: scrollController,
            itemCount: totalPage,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (currentPage != index + 1) {
                  onTap(index + 1);
                }
              },
              child: Container(
                height: height,
                width: height,
                margin: const EdgeInsets.only(left: 2, right: 2),
                decoration: BoxDecoration(
                  color: currentPage == index + 1 ? CustomColors.GREEN : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: currentPage == index + 1
                      ? [
                          BoxShadow(
                            blurRadius: 5,
                            spreadRadius: 1,
                            color: Colors.green.withOpacity(0.3),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(
                      fontFamily: "JosefinSans",
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (currentPage < totalPage) {
              onTap(currentPage + 1);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.keyboard_arrow_right_rounded),
            ),
          ),
        ),
      ],
    ),
  );
}
