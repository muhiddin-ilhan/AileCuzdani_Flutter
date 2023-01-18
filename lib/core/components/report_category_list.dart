import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/model/dto_report_item.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/sizer_utils.dart';

List<Widget> reportCategoryList(
  BuildContext context, {
  required List<DTOReportItem>? reportItems,
  required String title,
  IconData? iconData,
  required Function(DTOReportItem) onTap,
}) {
  double cardHeight = 45;
  double cardPadding = 8;
  double iconPadding = 4;
  double iconSize = cardHeight - (cardPadding * 2) - (iconPadding * 2);

  Widget icon(int index) {
    if (iconData != null) {
      return Icon(
        iconData,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    }
    if (reportItems![index].title == "Market") {
      return Icon(
        Icons.shopping_cart,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Yol") {
      return Icon(
        Icons.directions_bus_filled_outlined,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Kişisel") {
      return Icon(
        Icons.person,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "İş") {
      return Icon(
        Icons.work_rounded,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Fatura") {
      return Icon(
        Icons.receipt,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Borç") {
      return Icon(
        Icons.wallet,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Yemek") {
      return Icon(
        Icons.fastfood_rounded,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Maaş") {
      return Icon(
        Icons.payments,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Diğer") {
      return Icon(
        Icons.construction_rounded,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    } else if (reportItems[index].title == "Sağlık") {
      return Icon(
        Icons.medical_information,
        size: iconSize,
        color: CustomColors.DARK_GREY,
      );
    }

    return Icon(
      Icons.person,
      size: iconSize,
      color: CustomColors.DARK_GREY,
    );
  }

  if (reportItems != null) {
    reportItems.sort((a, b) {
      double valA = a.is_expense! ? a.expense! : a.income!;
      double valB = b.is_expense! ? b.expense! : b.income!;

      valA = valA < 0 ? valA * -1 : valA;
      valB = valB < 0 ? valB * -1 : valB;

      return valB.compareTo(valA);
    });
  }

  double maxValue = reportItems != null
      ? reportItems.first.is_expense!
          ? reportItems.first.expense! < 0
              ? reportItems.first.expense! * -1
              : reportItems.first.expense!
          : reportItems.first.income! < 0
              ? reportItems.first.income! * -1
              : reportItems.first.income!
      : 0;
  double minValue = 0;

  double normalizedValue(double value) {
    int minRange = 0;
    int maxRange = 1;
    if (maxValue == 0) maxValue = 1;
    double normalizeValue = (minRange + (value.abs() - minValue) * (maxRange - minRange) / (maxValue - minValue));
    return normalizeValue;
  }

  return [
    if (reportItems != null)
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
      height: reportItems != null ? (reportItems.length * cardHeight) + (reportItems.length * 1.2) : 0,
      child: ListView.builder(
        itemCount: reportItems != null ? reportItems.length : 0,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => Card(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 1.2),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: index == 0
                ? const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
                : index == reportItems!.length - 1
                    ? const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                    : BorderRadius.circular(0),
          ),
          child: InkWell(
            onTap: () {
              onTap(reportItems[index]);
            },
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
                    child: icon(index),
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
                                reportItems![index].title ?? "",
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
                            Text(
                              reportItems[index].expense! != 0
                                  ? "${reportItems[index].expense!.currencyFormat()}₺"
                                  : "${reportItems[index].income!.currencyFormat()}₺",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: reportItems[index].is_expense! ? const Color.fromARGB(255, 133, 68, 35) : CustomColors.DARK_GREEN,
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
                              decoration: BoxDecoration(color: const Color.fromARGB(255, 232, 232, 232), borderRadius: BorderRadius.circular(8)),
                            ),
                            Container(
                              height: 4,
                              width: ((Sizer.getWidth(context) - 24 - 16 - 8 - 21) *
                                  (reportItems[index].expense! != 0
                                      ? normalizedValue(reportItems[index].expense ?? 0)
                                      : normalizedValue(reportItems[index].income ?? 0))),
                              decoration: BoxDecoration(
                                  color: reportItems[index].is_expense! ? const Color.fromARGB(255, 163, 110, 84) : CustomColors.GREEN,
                                  borderRadius: BorderRadius.circular(8)),
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
    ),
  ];
}
