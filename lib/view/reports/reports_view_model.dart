// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:aile_cuzdani/core/api/reports/report_services.dart';
import 'package:aile_cuzdani/core/model/dto_monthly_chart_report.dart';
import 'package:aile_cuzdani/core/model/dto_report_item.dart';
import 'package:aile_cuzdani/core/model/dto_reports_request.dart';
import 'package:aile_cuzdani/core/model/dto_transaction_request.dart';
import 'package:aile_cuzdani/core/providers/authentication_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/core/utils/navigate_animation_state.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/reports/categorized_transactions/categorized_transactions_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
part 'reports_view_model.g.dart';

class ReportsViewModel = ReportsViewModelBase with _$ReportsViewModel;

abstract class ReportsViewModelBase with Store {
  @observable
  bool loading = false;
  @observable
  ScrollController scrollController = ScrollController();
  @observable
  int selectedCategoryTabIndex = 0;
  @observable
  int? selectedChartIndex;
  @observable
  int selectedYear = DateTime.now().year;
  @observable
  List<int> yearList = [];
  @observable
  ScrollController chartScrollController = ScrollController();
  @observable
  double chartHeight = 0;
  @observable
  double yearTabHeight = 52;
  @observable
  DTOMonthlyChartReport? chartReports;
  @observable
  List<DTOReportItem>? reportItems;
  @observable
  int? familyPeriodDay;

  @action
  scrollListener(BuildContext context) {
    double offset = scrollController.offset;
    if (scrollController.offset <= 0) {
      offset = 0;
    }

    double chartMaxHeight = Sizer.getHeight(context) * 0.3;

    if (chartHeight >= 0 && chartHeight <= chartMaxHeight) {
      if (chartMaxHeight - (offset) < 0) {
        chartHeight = 0;
      } else {
        chartHeight = chartMaxHeight - (offset);
      }
    }

    if (yearTabHeight >= 0 && yearTabHeight <= 52) {
      if (52 - (offset) < 0) {
        yearTabHeight = 0;
      } else {
        yearTabHeight = 52 - (offset);
      }
    }
  }

  @action
  getYears() {
    LoadingUtils.instance.loading(true);
    int currentYear = DateTime.now().year;
    yearList = [];

    for (int i = 2010; i <= currentYear; i++) {
      yearList.add(i);
    }

    yearList = yearList.reversed.toList();
    LoadingUtils.instance.loading(false);
  }

  @action
  setScrollPositionChart(BuildContext context) {
    LoadingUtils.instance.loading(true);
    DateTime today = DateTime.now();
    familyPeriodDay = Provider.of<AuthenticationProvider>(context, listen: false).user!.family!.period_day!;

    if (today.day < familyPeriodDay!) {
      if (today.month == 1) {
        selectedChartIndex = 11;
        selectedYear--;
      } else {
        selectedChartIndex = today.month - 2;
      }
    } else {
      selectedChartIndex = today.month - 1;
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      chartScrollController.jumpTo(chartScrollController.position.maxScrollExtent / 12 * (selectedChartIndex! == 11 ? 12 : selectedChartIndex!));
      LoadingUtils.instance.loading(false);
    });
  }

  @action
  onTapChart(int index) {
    selectedChartIndex = index;
    onTapTab(selectedCategoryTabIndex == -1 ? 0 : selectedCategoryTabIndex);
  }

  @action
  Future onTapYear(int index) async {
    try {
      await scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    } catch (e) {
      log(e.toString());
    }
    selectedYear = yearList[index];
    selectedChartIndex = null;
    reportItems = null;
    yearList = yearList;
    getChartStatistics();
  }

  @action
  Future onTapTab(int index) async {
    try {
      await scrollController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    } catch (e) {
      log(e.toString());
    }
    selectedCategoryTabIndex = index;
    if (index == 0) {
      getCategorizeReports();
    } else if (index == 1) {
      getUsersReports();
    } else if (index == 2) {
      getCardsReports();
    }
  }

  @action
  setLoading(bool val) {
    LoadingUtils.instance.loading(val);
    loading = val;
  }

  @action
  Future getChartStatistics() async {
    chartReports = null;
    setLoading(true);

    DTOMonthlyChartReport? response = await ReportService.monthlyChartReport(year: selectedYear.toString());

    if (response != null) {
      chartReports = response;
    } else {
      selectedCategoryTabIndex = -1;
      selectedChartIndex = null;
    }

    setLoading(false);
  }

  @action
  Future getCategorizeReports() async {
    if (selectedCategoryTabIndex != 0) return;

    reportItems = null;
    setLoading(true);

    DTOReportsRequest request = DTOReportsRequest(
      day: familyPeriodDay! < 10 ? "0$familyPeriodDay" : familyPeriodDay.toString(),
      start_year: selectedYear.toString(),
      end_year: selectedChartIndex == 11 ? (selectedYear + 1).toString() : selectedYear.toString(),
      start_month: (selectedChartIndex! + 1) < 10 ? "0${(selectedChartIndex! + 1)}" : (selectedChartIndex! + 1).toString(),
      end_month: (selectedChartIndex! + 2) > 12
          ? "01"
          : (selectedChartIndex! + 2) < 10
              ? "0${(selectedChartIndex! + 2)}"
              : (selectedChartIndex! + 2).toString(),
    );

    List<DTOReportItem>? response = await ReportService.categorizeReport(request: request);

    if (response != null) {
      reportItems = response;
    }

    setLoading(false);
  }

  @action
  Future getUsersReports() async {
    if (selectedCategoryTabIndex != 1) return;

    reportItems = null;
    setLoading(true);

    DTOReportsRequest request = DTOReportsRequest(
      day: familyPeriodDay! < 10 ? "0$familyPeriodDay" : familyPeriodDay.toString(),
      start_year: selectedYear.toString(),
      end_year: selectedChartIndex == 11 ? (selectedYear + 1).toString() : selectedYear.toString(),
      start_month: (selectedChartIndex! + 1) < 10 ? "0${(selectedChartIndex! + 1)}" : (selectedChartIndex! + 1).toString(),
      end_month: (selectedChartIndex! + 2) > 12
          ? "01"
          : (selectedChartIndex! + 2) < 10
              ? "0${(selectedChartIndex! + 2)}"
              : (selectedChartIndex! + 2).toString(),
    );

    List<DTOReportItem>? response = await ReportService.usersReport(request: request);

    if (response != null) {
      reportItems = response;
    }

    setLoading(false);
  }

  @action
  Future getCardsReports() async {
    if (selectedCategoryTabIndex != 2) return;

    reportItems = null;
    setLoading(true);

    DTOReportsRequest request = DTOReportsRequest(
      day: familyPeriodDay! < 10 ? "0$familyPeriodDay" : familyPeriodDay.toString(),
      start_year: selectedYear.toString(),
      end_year: selectedChartIndex == 11 ? (selectedYear + 1).toString() : selectedYear.toString(),
      start_month: (selectedChartIndex! + 1) < 10 ? "0${(selectedChartIndex! + 1)}" : (selectedChartIndex! + 1).toString(),
      end_month: (selectedChartIndex! + 2) > 12
          ? "01"
          : (selectedChartIndex! + 2) < 10
              ? "0${(selectedChartIndex! + 2)}"
              : (selectedChartIndex! + 2).toString(),
    );

    List<DTOReportItem>? response = await ReportService.bucketReport(request: request);

    if (response != null) {
      reportItems = response;
    }

    setLoading(false);
  }

  @action
  Future onReportItemClick(BuildContext context, DTOReportItem item, bool isExpenses) async {
    DTOTransactionRequest request = DTOTransactionRequest();

    request.start_date = DateTime(
      selectedYear,
      selectedChartIndex! + 1,
      familyPeriodDay!,
    );
    request.finish_date = DateTime(
      selectedChartIndex == 11 ? selectedYear + 1 : selectedYear,
      selectedChartIndex! + 2 > 12 ? 1 : selectedChartIndex! + 2,
      familyPeriodDay!,
    );
    request.is_expense = isExpenses ? 1 : -1;

    if (selectedCategoryTabIndex == 0) {
      request.category = item.title;
    } else if (selectedCategoryTabIndex == 1) {
      request.user_id = item.id;
    } else if (selectedCategoryTabIndex == 2) {
      request.bucket_id = item.id;
    }

    String pageTitle = "${item.title} ${isExpenses ? 'Giderleri' : 'Gelirleri'}";

    NavigateUtils.push(
      context,
      page: CategorizedTransactionView(transactionRequest: request, pageTitle: pageTitle),
      animationState: NavigateAnimationState.slideBottomToTop,
    );
  }
}
