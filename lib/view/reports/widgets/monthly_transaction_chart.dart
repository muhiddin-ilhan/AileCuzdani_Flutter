import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_monthly_chart_report.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget monthlyTransactionChart(
  BuildContext context, {
  required int selectedIndex,
  required Function(int index) onTap,
  required ScrollController scrollController,
  required double widgetHeigth,
  required DTOMonthlyChartReport? monthlyChartReport,
}) {
  int? periodDay = Provider.of<AuthenticationProvider>(context, listen: false).user?.family?.period_day;

  double maxValue = 0;

  if (monthlyChartReport != null) {
    for (double value in monthlyChartReport.toJson().values) {
      if ((value < 0 ? value * -1 : value) > maxValue) {
        maxValue = (value < 0 ? value * -1 : value);
      }
    }
  }

  double normalizedValue(double value) {
    int minRange = 0;
    double maxRange = 0.85;
    int minValue = 0;
    if (maxValue == 0) maxValue = 1;
    double normalizeValue = (minRange + (value.abs() - minValue) * (maxRange - minRange) / (maxValue - minValue));
    return normalizeValue;
  }

  double getExpenseValue(int index) {
    if (monthlyChartReport == null) return 0;

    switch (index) {
      case 0:
        return normalizedValue(monthlyChartReport.expense_1 ?? 0);
      case 1:
        return normalizedValue(monthlyChartReport.expense_2 ?? 0);
      case 2:
        return normalizedValue(monthlyChartReport.expense_3 ?? 0);
      case 3:
        return normalizedValue(monthlyChartReport.expense_4 ?? 0);
      case 4:
        return normalizedValue(monthlyChartReport.expense_5 ?? 0);
      case 5:
        return normalizedValue(monthlyChartReport.expense_6 ?? 0);
      case 6:
        return normalizedValue(monthlyChartReport.expense_7 ?? 0);
      case 7:
        return normalizedValue(monthlyChartReport.expense_8 ?? 0);
      case 8:
        return normalizedValue(monthlyChartReport.expense_9 ?? 0);
      case 9:
        return normalizedValue(monthlyChartReport.expense_10 ?? 0);
      case 10:
        return normalizedValue(monthlyChartReport.expense_11 ?? 0);
      case 11:
        return normalizedValue(monthlyChartReport.expense_12 ?? 0);
      default:
        return 0;
    }
  }

  double getIncomeValue(int index) {
    if (monthlyChartReport == null) return 0;

    switch (index) {
      case 0:
        return normalizedValue(monthlyChartReport.income_1 ?? 0);
      case 1:
        return normalizedValue(monthlyChartReport.income_2 ?? 0);
      case 2:
        return normalizedValue(monthlyChartReport.income_3 ?? 0);
      case 3:
        return normalizedValue(monthlyChartReport.income_4 ?? 0);
      case 4:
        return normalizedValue(monthlyChartReport.income_5 ?? 0);
      case 5:
        return normalizedValue(monthlyChartReport.income_6 ?? 0);
      case 6:
        return normalizedValue(monthlyChartReport.income_7 ?? 0);
      case 7:
        return normalizedValue(monthlyChartReport.income_8 ?? 0);
      case 8:
        return normalizedValue(monthlyChartReport.income_9 ?? 0);
      case 9:
        return normalizedValue(monthlyChartReport.income_10 ?? 0);
      case 10:
        return normalizedValue(monthlyChartReport.income_11 ?? 0);
      case 11:
        return normalizedValue(monthlyChartReport.income_12 ?? 0);
      default:
        return 0;
    }
  }

  String indexToMonthName(int index) {
    switch (index) {
      case 0:
        return "$periodDay Oca";
      case 1:
        return "$periodDay Şub";
      case 2:
        return "$periodDay Mar";
      case 3:
        return "$periodDay Nis";
      case 4:
        return "$periodDay May";
      case 5:
        return "$periodDay Haz";
      case 6:
        return "$periodDay Tem";
      case 7:
        return "$periodDay Ağu";
      case 8:
        return "$periodDay Eyl";
      case 9:
        return "$periodDay Eki";
      case 10:
        return "$periodDay Kas";
      case 11:
        return "$periodDay Ara";
      case 12:
        return "$periodDay Oca";
      default:
        return "";
    }
  }

  return Container(
    height: widgetHeigth,
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.black.withOpacity(0.05), width: widgetHeigth == 0 ? 0 : 1),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widgetHeigth,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 223, 223, 223),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(6),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: widgetHeigth * 0.1 + 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${(maxValue / 7 * 6).toStringAsFixed(0)}₺",
                    style: const TextStyle(fontSize: 11, height: 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widgetHeigth * 0.25 + 4),
                child: Divider(
                  height: widgetHeigth == 0 ? 0 : 16,
                  thickness: widgetHeigth == 0 ? 0 : 1,
                  color: Colors.black.withOpacity(0.05),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widgetHeigth * 0.4 + 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${(maxValue / 7 * 4).toStringAsFixed(0)}₺",
                    style: const TextStyle(fontSize: 11, height: 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widgetHeigth * 0.55 + 4),
                child: Divider(
                  height: widgetHeigth == 0 ? 0 : 16,
                  thickness: widgetHeigth == 0 ? 0 : 1,
                  color: Colors.black.withOpacity(0.05),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: widgetHeigth * 0.7 + 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${(maxValue / 7 * 2).toStringAsFixed(0)}₺",
                    style: const TextStyle(fontSize: 11, height: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              if (widgetHeigth > 0)
                Padding(
                  padding: EdgeInsets.only(top: widgetHeigth * 0.1),
                  child: Divider(
                    height: widgetHeigth == 0 ? 0 : 16,
                    thickness: widgetHeigth == 0 ? 0 : 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              if (widgetHeigth > 0)
                Padding(
                  padding: EdgeInsets.only(top: widgetHeigth * 0.25),
                  child: Divider(
                    height: widgetHeigth == 0 ? 0 : 16,
                    thickness: widgetHeigth == 0 ? 0 : 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              if (widgetHeigth > 0)
                Padding(
                  padding: EdgeInsets.only(top: widgetHeigth * 0.4),
                  child: Divider(
                    height: widgetHeigth == 0 ? 0 : 16,
                    thickness: widgetHeigth == 0 ? 0 : 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              if (widgetHeigth > 0)
                Padding(
                  padding: EdgeInsets.only(top: widgetHeigth * 0.55),
                  child: Divider(
                    height: widgetHeigth == 0 ? 0 : 16,
                    thickness: widgetHeigth == 0 ? 0 : 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              if (widgetHeigth > 0)
                Padding(
                  padding: EdgeInsets.only(top: widgetHeigth * 0.7),
                  child: Divider(
                    height: widgetHeigth == 0 ? 0 : 16,
                    thickness: widgetHeigth == 0 ? 0 : 1,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ),
              ListView.builder(
                itemCount: 12,
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                itemBuilder: (context, index) {
                  bool isSelected = selectedIndex == index;
                  return InkWell(
                    onTap: () {
                      onTap(index);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: isSelected ? const EdgeInsets.fromLTRB(10, 0, 10, 0) : const EdgeInsets.fromLTRB(18, 0, 18, 4),
                            child: Container(
                              padding: isSelected ? const EdgeInsets.fromLTRB(10, 4, 10, 4) : null,
                              decoration: isSelected
                                  ? const BoxDecoration(
                                      color: Color.fromARGB(255, 216, 216, 216),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    )
                                  : null,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: widgetHeigth * getIncomeValue(index),
                                    width: 7,
                                    decoration: const BoxDecoration(
                                      color: CustomColors.GREEN,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                  const SizedBox(width: 1),
                                  Container(
                                    height: widgetHeigth * getExpenseValue(index),
                                    width: 7,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 193, 131, 73),
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: widgetHeigth * 0.15,
                          width: 56,
                          padding: const EdgeInsets.all(1.75),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 223, 223, 223),
                          ),
                          child: Center(
                            child: Container(
                              decoration: isSelected
                                  ? BoxDecoration(
                                      color: CustomColors.DARK_GREY,
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                  : null,
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        indexToMonthName(index),
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 1,
                                          fontFamily: "JosefinSans",
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? Colors.white : const Color.fromARGB(255, 95, 95, 95),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        indexToMonthName(index + 1),
                                        style: TextStyle(
                                          fontSize: 13,
                                          height: 1,
                                          fontFamily: "JosefinSans",
                                          fontWeight: FontWeight.w600,
                                          color: isSelected ? Colors.white : const Color.fromARGB(255, 95, 95, 95),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
