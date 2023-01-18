import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/sizer_utils.dart';

Widget reportCardList(BuildContext context, {required List<DTOBucket> items, required String title}) {
  double cardHeight = 45;
  double cardPadding = 8;
  double iconPadding = 4;
  double iconSize = cardHeight - (cardPadding * 2) - (iconPadding * 2);

  items.sort((a, b) => a.user_id!.compareTo(b.user_id!));

  BorderRadius customBorderRadius(int index) {
    if (index == 0) {
      return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
    }
    if (index == items.length - 1) {
      if (items[index].user_id == items[index - 1].user_id) {
        return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
      }
      return BorderRadius.circular(10);
    }
    if (items[index].user_id == items[index - 1].user_id) {
      if (items[index].user_id == items[index + 1].user_id) {
        return BorderRadius.circular(0);
      }
      return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
    }
    if (items[index].user_id == items[index + 1].user_id) {
      if (items[index].user_id == items[index - 1].user_id) {
        return BorderRadius.circular(0);
      }
      return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
    }
    return BorderRadius.circular(10);
  }

  Widget customText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 6, bottom: 2),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(211, 59, 59, 59),
          fontFamily: "JosefinSans",
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
    );
  }

  List<String> differentUser = [];

  for (String e in differentUser) {
    if (!differentUser.contains(e)) {
      differentUser.add(e);
    }
  }

  return SizedBox(
    height: ((items.length + 1) * cardHeight) + ((items.length + 1) * 1.2) + (differentUser.length * 21),
    child: ListView.separated(
      itemCount: items.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        int index = i - 1;
        if (index == -1) {
          return const SizedBox();
        }
        return Card(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 1.2),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: customBorderRadius(index),
          ),
          child: Container(
            height: cardHeight,
            padding: EdgeInsets.all(cardPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(iconPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: CustomColors.DARK_WHITE,
                  ),
                  child: Icon(
                    Icons.wallet,
                    size: iconSize,
                    color: const Color.fromARGB(255, 68, 78, 132),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              items[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 48, 48, 48),
                                fontFamily: "JosefinSans",
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                height: 1,
                              ),
                            ),
                          ),
                          const Text(
                            "14.123,32₺",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color.fromARGB(255, 110, 59, 59),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Stack(
                        children: [
                          Container(
                            height: 4,
                            width: (Sizer.getWidth(context) - 24 - 16 - 8 - 21),
                            decoration: BoxDecoration(color: const Color.fromARGB(255, 180, 180, 180), borderRadius: BorderRadius.circular(8)),
                          ),
                          Container(
                            height: 4,
                            width: (Sizer.getWidth(context) - 24 - 16 - 8 - 21) * 0.75,
                            decoration: BoxDecoration(color: const Color.fromARGB(255, 33, 146, 135), borderRadius: BorderRadius.circular(8)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 1),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        int i = index;
        if (i == items.length) {
          i--;
        }
        if (i == 0) {
          return customText("${items[i].user!.name} ${items[i].user!.surname}");
        }
        if (items[i].user_id == items[i - 1].user_id) {
          return const SizedBox();
        } else {
          return customText("${items[i].user!.name} ${items[i].user!.surname}");
        }
      },
    ),
  );
}
