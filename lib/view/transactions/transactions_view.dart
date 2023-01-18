// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_showcase.dart';
import 'package:aile_cuzdani/core/components/popups/add_expense_popup.dart';
import 'package:aile_cuzdani/core/components/transactions_list.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/model/dto_transaction.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/transactions/transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../core/components/popups/filter_transaction_popup.dart';
import '../../core/utils/loading_utils.dart';
import '../../core/utils/shared_preferences.dart';

class TransactionsView extends StatelessWidget {
  TransactionsView({super.key});

  final GlobalKey _filterButtonShowCase = GlobalKey();
  final GlobalKey _listShowCase = GlobalKey();
  final TransactionsViewModel viewModel = TransactionsViewModel();

  void initState(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await viewModel.getTransactions(context);

      bool showCase = await SharedManager.instance.getBoolValue("TransactionsPageShowCase") ?? false;

      if (!showCase) {
        ShowCaseWidget.of(context).startShowCase([
          _filterButtonShowCase,
          _listShowCase,
        ]);

        await SharedManager.instance.setBoolValue("TransactionsPageShowCase", true);
      }
    });
  }

  onBackPress(BuildContext context) {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false).goPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionsViewModel>(
      initState: initState,
      onPageBuilder: (_) => WillPopScope(
        onWillPop: () async {
          onBackPress(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: CustomColors.DARK_GREEN,
          body: Container(
            height: Sizer.getHeight(context),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  CustomColors.DARK_GREEN,
                  CustomColors.GREEN,
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  topSection(context),
                  bottomSection(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSection(BuildContext context) {
    return Observer(
      builder: (_) => Expanded(
        child: Hero(
          tag: "bottomSection",
          child: SizedBox(
            width: Sizer.getWidth(context),
            child: Card(
              margin: EdgeInsets.zero,
              color: CustomColors.OFF_WHITE,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(38),
                  topRight: Radius.circular(38),
                ),
              ),
              child: Column(
                children: [
                  bottomSectionTitle(context),
                  const SizedBox(height: 10),
                  Expanded(
                    child: customShowCase(
                      key: _listShowCase,
                      description: "Aile İçinde Yapılan Tüm İşlemler Burada Listelenir",
                      child: transactionList(
                        viewModel.transactions,
                        isLoading: false,
                        onTap: (DTOTransaction transaction) async {
                          bool? result = await showAddIncomePopup(context, transaction: transaction);

                          if (result == true) {
                            viewModel.getTransactions(context);
                          }
                        },
                        currentPage: viewModel.currentPage,
                        totalPage: viewModel.totalPage,
                        onPageTap: (int pageNumber) {
                          viewModel.getTransactions(context, page: pageNumber);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28, top: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Text(
              "Tüm İşlemler",
              style: TextStyle(
                color: CustomColors.VERY_DARK_GREEN,
                fontFamily: "JosefinSans",
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          Observer(builder: (_) {
            if (!viewModel.isFilterActive) {
              return const SizedBox();
            }
            return Expanded(
              child: InkWell(
                onTap: () async {
                  viewModel.filterClear();
                  await viewModel.getTransactions(context);
                },
                child: const Text(
                  "Filtreyi Kaldır",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: CustomColors.VERY_DARK_GREEN,
                    fontFamily: "JosefinSans",
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget topSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          appBar(context),
          const SizedBox(height: 8),
          ...totalBalance(context),
          const SizedBox(height: 8),
          incomeExpense(context),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget incomeExpense(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Observer(builder: (_) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gelir",
                  style: TextStyle(
                    color: CustomColors.WHITE.withOpacity(0.6),
                    fontFamily: "JosefinSans",
                    fontSize: 13,
                  ),
                ),
                Text(
                  "₺${viewModel.totalValues != null ? viewModel.totalValues!.totalIncome!.currencyFormat() : 0.0.currencyFormat()}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 118, 231, 182),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 42),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gider",
                  style: TextStyle(
                    color: CustomColors.WHITE.withOpacity(0.6),
                    fontFamily: "JosefinSans",
                    fontSize: 13,
                  ),
                ),
                Text(
                  "₺${viewModel.totalValues != null ? (viewModel.totalValues!.totalExpense! * -1).currencyFormat() : 0.0.currencyFormat()}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 231, 190, 118),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  List<Widget> totalBalance(BuildContext context) {
    return [
      Text(
        "Toplam Bakiye",
        style: TextStyle(
          color: CustomColors.WHITE.withOpacity(0.6),
          fontFamily: "JosefinSans",
        ),
      ),
      Observer(builder: (_) {
        return Text(
          "₺${viewModel.totalValues != null ? viewModel.totalValues!.totalCount!.currencyFormat() : 0.0.currencyFormat()}",
          style: const TextStyle(
            color: CustomColors.WHITE,
            fontWeight: FontWeight.w800,
            fontSize: 30,
            height: 1,
          ),
        );
      }),
    ];
  }

  Widget appBar(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onBackPress(context);
            },
            borderRadius: BorderRadius.circular(10),
            child: const Icon(
              Icons.arrow_back,
              color: CustomColors.WHITE,
              size: 28,
            ),
          ),
        ),
        const Spacer(),
        customShowCase(
          key: _filterButtonShowCase,
          description: "İşlemleri Detaylı Şekilde Listelemek İçin Bunu Kullanın",
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                showFilterTransactionPopup(context, viewModel);
              },
              borderRadius: BorderRadius.circular(10),
              child: const Icon(
                Icons.filter_alt,
                color: CustomColors.WHITE,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
