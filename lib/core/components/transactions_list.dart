import 'package:aile_cuzdani/core/components/custom_paginate.dart';
import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../model/dto_transaction.dart';
import '../utils/expense_enum.dart';

Widget transactionList(
  List<DTOTransaction> transactions, {
  required Function(DTOTransaction) onTap,
  required bool isLoading,
  ScrollController? scrollController,
  double? topPadding,
  int? currentPage,
  int? totalPage,
  Function(int)? onPageTap,
}) {
  BorderRadius customBorderRadius(int index) {
    if (index == 0) {
      if (index == transactions.length - 1) {
        return BorderRadius.circular(10);
      }
      if (transactions[index].date!.day != transactions[index + 1].date!.day) {
        return BorderRadius.circular(10);
      }
      return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
    }
    if (index == transactions.length - 1) {
      if (transactions[index].date!.day == transactions[index - 1].date!.day) {
        return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
      }
      return BorderRadius.circular(10);
    }
    if (transactions[index].date!.day == transactions[index - 1].date!.day) {
      if (transactions[index].date!.day == transactions[index + 1].date!.day) {
        return BorderRadius.circular(0);
      }
      return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
    }
    if (transactions[index].date!.day == transactions[index + 1].date!.day) {
      if (transactions[index].date!.day == transactions[index - 1].date!.day) {
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
    if (index == transactions.length - 1) {
      return BoxShadow(
        blurRadius: 15,
        spreadRadius: 1,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 15),
      );
    }
    if (transactions[index].date!.day == transactions[index - 1].date!.day) {
      if (transactions[index].date!.day == transactions[index + 1].date!.day) {
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
    if (transactions[index].date!.day == transactions[index + 1].date!.day) {
      if (transactions[index].date!.day == transactions[index - 1].date!.day) {
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
    if (transactions[index].date!.day == transactions[index - 1].date!.day) {
      return LinearGradient(
        stops: const [0.02, 0.02],
        colors: [CustomColors.LIGHT_BLACK.withOpacity(0.0001), Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }

    return null;
  }

  Widget customText(String text, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 29, top: index == 0 ? topPadding ?? 10 : 10, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(211, 59, 59, 59),
          fontFamily: "JosefinSans",
          fontSize: 15,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
    );
  }

  Widget icon(int index) {
    if (transactions[index].category == "Market") {
      return const Icon(
        Icons.shopping_cart,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Yol") {
      return const Icon(
        Icons.directions_bus_filled_outlined,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Kişisel") {
      return const Icon(
        Icons.person,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "İş") {
      return const Icon(
        Icons.work_rounded,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Fatura") {
      return const Icon(
        Icons.receipt,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Borç") {
      return const Icon(
        Icons.wallet,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Yemek") {
      return const Icon(
        Icons.fastfood_rounded,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Maaş") {
      return const Icon(
        Icons.payments,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Diğer") {
      return const Icon(
        Icons.construction_rounded,
        color: CustomColors.DARK_GREEN,
      );
    } else if (transactions[index].category == "Sağlık") {
      return const Icon(
        Icons.medical_information,
        color: CustomColors.DARK_GREEN,
      );
    }

    return const Icon(
      Icons.person,
      color: CustomColors.DARK_GREEN,
    );
  }

  if (isLoading) {
    return const Center(
      child: CircularProgressIndicator(
        color: CustomColors.GREEN,
      ),
    );
  }

  return ListView.separated(
    controller: scrollController,
    itemBuilder: (context, i) {
      int index = i - 1;
      if (index == -1) {
        return const SizedBox();
      }

      if (index != transactions.length - 1 || currentPage == null) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: customBorderRadius(index),
            gradient: customBorderSide(index),
            color: CustomColors.WHITE,
            boxShadow: [customBoxShadow(index)],
          ),
          margin: EdgeInsets.only(left: 28, right: 28, bottom: index == transactions.length - 1 ? topPadding ?? 6 : 0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: customBorderRadius(index),
              onTap: () {
                onTap(transactions[index]);
              },
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
                      child: icon(index),
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
                            transactions[index].title!.firstCapitalize() ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: CustomColors.LIGHT_BLACK,
                              fontFamily: "JosefinSans",
                              fontSize: 15,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            "${transactions[index].user!.name} ${transactions[index].user!.surname}",
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
                    Text(
                      "₺${transactions[index].price!.currencyFormat()}",
                      style: TextStyle(
                        color: transactions[index].is_expense == ExpenseState.income.value ? CustomColors.GREEN : const Color.fromARGB(255, 167, 120, 40),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: customBorderRadius(index),
                gradient: customBorderSide(index),
                color: CustomColors.WHITE,
                boxShadow: [customBoxShadow(index)],
              ),
              margin: EdgeInsets.only(left: 28, right: 28, bottom: index == transactions.length - 1 ? topPadding ?? 6 : 0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: customBorderRadius(index),
                  onTap: () {
                    onTap(transactions[index]);
                  },
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
                          child: icon(index),
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
                                transactions[index].title!.firstCapitalize() ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: CustomColors.LIGHT_BLACK,
                                  fontFamily: "JosefinSans",
                                  fontSize: 15,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                "${transactions[index].user!.name} ${transactions[index].user!.surname}",
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
                        Text(
                          "₺${transactions[index].price!.currencyFormat()}",
                          style: TextStyle(
                            color: transactions[index].is_expense == ExpenseState.income.value ? CustomColors.GREEN : const Color.fromARGB(255, 167, 120, 40),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            customPaginate(
              currentPage: currentPage,
              totalPage: totalPage,
              onTap: (int pageNumber) {
                if (onPageTap != null) {
                  onPageTap(pageNumber);
                }
              },
            )
          ],
        );
      }
    },
    separatorBuilder: (context, index) {
      int i = index;
      if (i == transactions.length) {
        i--;
      }
      if (i == 0) {
        if (transactions[i].date!.day == DateTime.now().day && transactions[i].date!.month == DateTime.now().month) {
          return customText("Bugün", index);
        } else if (transactions[i].date!.day == DateTime.now().day - 1 && transactions[i].date!.month == DateTime.now().month) {
          return customText("Dün", index);
        } else {
          return customText(transactions[i].date!.toMonthNameFullDate(), index);
        }
      }
      if (transactions[i].date!.day == transactions[i - 1].date!.day) {
        return const SizedBox();
      } else {
        if (transactions[i].date!.day == DateTime.now().day && transactions[i].date!.month == DateTime.now().month) {
          return customText("Bugün", index);
        } else if (transactions[i].date!.day == DateTime.now().day - 1 && transactions[i].date!.month == DateTime.now().month) {
          return customText("Dün", index);
        } else {
          return customText(transactions[i].date!.toMonthNameFullDate(), index);
        }
      }
    },
    itemCount: transactions.length + 1,
  );
}
