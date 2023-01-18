// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_showcase.dart';
import 'package:aile_cuzdani/core/components/custom_tab_item.dart';
import 'package:aile_cuzdani/core/components/report_category_list.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_report_item.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/reports/widgets/monthly_transaction_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../core/components/custom_appBar.dart';
import '../../../core/providers/bottom_navbar_provider.dart';
import '../../../core/utils/loading_utils.dart';
import '../../core/utils/shared_preferences.dart';
import 'reports_view_model.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _MonthlyReportViewState();
}

class _MonthlyReportViewState extends State<ReportsView> {
  ReportsViewModel viewModel = ReportsViewModel();
  final GlobalKey _yearsShowCase = GlobalKey();
  final GlobalKey _chartShowCase = GlobalKey();
  final GlobalKey _categoriCardsShowCase = GlobalKey();
  final GlobalKey _listCardShowCase = GlobalKey();

  onBackPress() {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false).goPage(0);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      viewModel.getYears();
      viewModel.setScrollPositionChart(context);
      viewModel.chartHeight = Sizer.getHeight(context) * 0.3;
      viewModel.scrollController.addListener(() {
        viewModel.scrollListener(context);
      });
      await viewModel.getChartStatistics();
      await viewModel.getCategorizeReports();

      bool showCase = await SharedManager.instance.getBoolValue("MonthlyReportViewShowCase") ?? false;

      if (!showCase) {
        ShowCaseWidget.of(context).startShowCase([
          _yearsShowCase,
          _chartShowCase,
          _categoriCardsShowCase,
          _listCardShowCase,
        ]);

        await SharedManager.instance.setBoolValue("MonthlyReportViewShowCase", true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ReportsViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          onBackPress();
          return false;
        },
        child: Scaffold(
          appBar: appBar(context),
          backgroundColor: CustomColors.OFF_WHITE,
          body: SizedBox(
            height: Sizer.getHeight(context),
            width: Sizer.getWidth(context),
            child: Observer(builder: (_) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customShowCase(
                    key: _yearsShowCase,
                    description: "Yıllara Göre Yaptığınız Gelir/Giderleri Görmek İçin Buradan Yıl Seçebilirsiniz",
                    child: yearsListWidget(),
                  ),
                  customShowCase(
                    key: _chartShowCase,
                    description:
                        "Seçilmiş Yıla Ait Aylık Gelir/Gider Grafiği Burada Görebilirsiniz. Yeşil Çubuk Gelirleri, Turuncu Çubuk Giderleri Temsil Etmektedir",
                    child: monthlyTransactionChart(
                      context,
                      selectedIndex: viewModel.selectedChartIndex ?? -1,
                      scrollController: viewModel.chartScrollController,
                      onTap: (val) {
                        viewModel.onTapChart(val);
                      },
                      widgetHeigth: viewModel.chartHeight,
                      monthlyChartReport: viewModel.chartReports,
                    ),
                  ),
                  if (viewModel.selectedChartIndex != null && viewModel.reportItems != null) ...[
                    const SizedBox(height: 10),
                    customShowCase(
                      key: _categoriCardsShowCase,
                      description: "Grafikte Seçilmiş Döneme Göre Görmek İstediğiniz Rapor Türünü Seçebilirsiniz",
                      child: tabs(),
                    ),
                  ],
                  Expanded(
                    child: viewModel.reportItems == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.report_gmailerrorred,
                                  color: CustomColors.GREY,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Hiçbir Veri Bulunamadı",
                                  style: TextStyle(color: CustomColors.GREY, fontFamily: "JosefinSans"),
                                ),
                              ],
                            ),
                          )
                        : customShowCase(
                            key: _listCardShowCase,
                            description: "Seçili Döneme Ait Raporlar Burada Görüntülenir, Tıklanarak Detayına Gidilebilir",
                            child: SingleChildScrollView(
                              controller: viewModel.scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: Sizer.getHeight(context) * 0.3 - (viewModel.chartHeight),
                                  ),
                                  ...reportCategoryList(
                                    context,
                                    reportItems: viewModel.reportItems != null ? viewModel.reportItems!.where((e) => e.is_expense == true).toList() : null,
                                    iconData: viewModel.selectedCategoryTabIndex == 2 ? Icons.wallet : null,
                                    title: "Giderler",
                                    onTap: (DTOReportItem item) {
                                      viewModel.onReportItemClick(context, item, true);
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  ...reportCategoryList(
                                    context,
                                    reportItems: viewModel.reportItems != null ? viewModel.reportItems!.where((e) => e.is_expense == false).toList() : null,
                                    iconData: viewModel.selectedCategoryTabIndex == 2 ? Icons.wallet : null,
                                    title: "Gelirler",
                                    onTap: (DTOReportItem item) {
                                      viewModel.onReportItemClick(context, item, false);
                                    },
                                  ),
                                  SizedBox(
                                    height: Sizer.getHeight(context) * 0.3 - (viewModel.chartHeight),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget tabs() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            Expanded(
              child: customTabItem(
                title: "Kategori",
                selected: viewModel.selectedCategoryTabIndex == 0,
                onTap: () {
                  viewModel.onTapTab(0);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: customTabItem(
                title: "Kişi",
                selected: viewModel.selectedCategoryTabIndex == 1,
                onTap: () {
                  viewModel.onTapTab(1);
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: customTabItem(
                title: "Kart",
                selected: viewModel.selectedCategoryTabIndex == 2,
                onTap: () {
                  viewModel.onTapTab(2);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Observer yearsListWidget() {
    return Observer(
      builder: (_) => Container(
        height: viewModel.yearTabHeight,
        padding: const EdgeInsets.fromLTRB(12, 7, 12, 7),
        child: ListView.builder(
          itemCount: viewModel.yearList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(right: 8),
            child: customTabItem(
              title: viewModel.yearList[index].toString(),
              onTap: () {
                viewModel.onTapYear(index);
              },
              selected: viewModel.selectedYear == viewModel.yearList[index],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(
      context,
      title: "Raporlar",
      leading: IconButton(
        onPressed: () {
          onBackPress();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
