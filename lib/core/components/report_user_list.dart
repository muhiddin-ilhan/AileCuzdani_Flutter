import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/sizer_utils.dart';

List<Widget> reportUserList(BuildContext context, {required List<DTOUser> users, required String title}) {
  double cardHeight = 45;
  double cardPadding = 8;
  double iconPadding = 4;
  double iconSize = cardHeight - (cardPadding * 2) - (iconPadding * 2);

  return [
    Padding(
      padding: const EdgeInsets.only(left: 14, top: 2, bottom: 2),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(211, 59, 59, 59),
          fontFamily: "JosefinSans",
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
    ),
    SizedBox(
      height: (users.length * cardHeight) + (users.length * 1.2),
      child: ListView.builder(
        itemCount: users.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => Card(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 1.2),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: index == 0
                  ? const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                  : index == users.length - 1
                      ? const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                      : BorderRadius.circular(0)),
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
                    Icons.person,
                    size: iconSize,
                    color: CustomColors.BLACK.withOpacity(0.6),
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
                              "${users[index].name} ${users[index].surname}",
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
                              color: Color.fromARGB(255, 119, 79, 56),
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
        ),
      ),
    ),
  ];
}
