import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

Widget goldAssetsList(List<DTOBucket> bucket, {Function(DTOBucket)? onTap, bool isScroll = true}) {
  bucket.sort((a, b) => a.user_id!.compareTo(b.user_id!));

  BorderRadius customBorderRadius(int index) {
    if (index == 0) {
      if (bucket.length == 1) {
        return BorderRadius.circular(10);
      }
      return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
    }
    if (index == bucket.length - 1) {
      if (bucket[index].user_id == bucket[index - 1].user_id) {
        return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
      }
      return BorderRadius.circular(10);
    }
    if (bucket[index].user_id == bucket[index - 1].user_id) {
      if (bucket[index].user_id == bucket[index + 1].user_id) {
        return BorderRadius.circular(0);
      }
      return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
    }
    if (bucket[index].user_id == bucket[index + 1].user_id) {
      if (bucket[index].user_id == bucket[index - 1].user_id) {
        return BorderRadius.circular(0);
      }
      return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
    }
    return BorderRadius.circular(10);
  }

  BoxShadow customBoxShadow(int index) {
    if (index == 0) {
      return BoxShadow(
        blurRadius: 15,
        spreadRadius: 1,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, -15),
      );
    }
    if (index == bucket.length - 1) {
      return BoxShadow(
        blurRadius: 15,
        spreadRadius: 1,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 15),
      );
    }
    if (bucket[index].user_id == bucket[index - 1].user_id) {
      if (bucket[index].user_id == bucket[index + 1].user_id) {
        return BoxShadow(
          blurRadius: 15,
          spreadRadius: 1,
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 10),
        );
      }
      return BoxShadow(
        blurRadius: 15,
        spreadRadius: 1,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 15),
      );
    }
    if (bucket[index].user_id == bucket[index + 1].user_id) {
      if (bucket[index].user_id == bucket[index - 1].user_id) {
        return BoxShadow(
          blurRadius: 15,
          spreadRadius: 1,
          color: Colors.black.withOpacity(0.05),
          offset: const Offset(0, 10),
        );
      }
      return BoxShadow(
        blurRadius: 15,
        spreadRadius: 1,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, -15),
      );
    }
    return BoxShadow(
      blurRadius: 15,
      spreadRadius: 1,
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 0),
    );
  }

  LinearGradient? customBorderSide(int index) {
    if (index == 0) {
      return null;
    }
    if (bucket[index].user_id == bucket[index - 1].user_id) {
      return LinearGradient(
        stops: const [0.02, 0.02],
        colors: [CustomColors.LIGHT_BLACK.withOpacity(0.0001), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    return null;
  }

  Widget customText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 18, bottom: 4),
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

  return ListView.separated(
    physics: isScroll ? null : const NeverScrollableScrollPhysics(),
    shrinkWrap: isScroll ? false : true,
    itemBuilder: (context, i) {
      int index = i - 1;
      if (index == -1) {
        return const SizedBox();
      }
      return Container(
        decoration: BoxDecoration(
          borderRadius: customBorderRadius(index),
          gradient: customBorderSide(index),
          color: CustomColors.WHITE,
          boxShadow: [customBoxShadow(index)],
        ),
        margin: const EdgeInsets.only(left: 16, right: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: customBorderRadius(index),
            onTap: onTap == null
                ? null
                : () {
                    onTap(bucket[index]);
                  },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.DARK_WHITE,
                        ),
                        child: Image.asset(
                          Assets.COIN,
                          height: 30,
                          width: 30,
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
                              bucket[index].title.firstCapitalize() ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: CustomColors.LIGHT_BLACK,
                                fontFamily: "JosefinSans",
                                fontSize: 14,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              "${bucket[index].user!.name.firstCapitalize()} ${bucket[index].user!.surname.firstCapitalize()}",
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
                    ],
                  ),
                  Divider(
                    height: 12,
                    color: Colors.grey.withOpacity(0.1),
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Adet",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(201, 59, 59, 59),
                            fontFamily: "JosefinSans",
                            fontSize: 12,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        (bucket[index].count ?? 0).toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "JosefinSans",
                          fontSize: 13,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Değer",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(201, 59, 59, 59),
                            fontFamily: "JosefinSans",
                            fontSize: 12,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        "₺${(bucket[index].money ?? 0).currencyFormat()}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: CustomColors.LIGHT_BLACK.withOpacity(0.75),
                          fontFamily: "JosefinSans",
                          fontSize: 13,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Platform",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(201, 59, 59, 59),
                            fontFamily: "JosefinSans",
                            fontSize: 12,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        bucket[index].platform ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CustomColors.DARK_GREEN,
                          fontFamily: "JosefinSans",
                          fontSize: 13,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Özel Varlıklarım",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(201, 59, 59, 59),
                            fontFamily: "JosefinSans",
                            fontSize: 12,
                            height: 1,
                          ),
                        ),
                      ),
                      Text(
                        bucket[index].show_my_assets == 1 ? "Dahil" : " Dahil Değil",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: CustomColors.GREY,
                          fontFamily: "JosefinSans",
                          fontSize: 13,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    separatorBuilder: (context, index) {
      int i = index;
      if (i == bucket.length) {
        i--;
      }
      if (i == 0) {
        return customText("${bucket[i].user!.name.firstCapitalize()} ${bucket[i].user!.surname.firstCapitalize()}");
      }
      if (bucket[i].user_id == bucket[i - 1].user_id) {
        return const SizedBox();
      } else {
        return customText("${bucket[i].user!.name.firstCapitalize()} ${bucket[i].user!.surname.firstCapitalize()}");
      }
    },
    itemCount: bucket.length + 1,
  );
}
