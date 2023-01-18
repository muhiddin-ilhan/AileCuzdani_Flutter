import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/model/dto_transaction_request.dart';
import 'package:aile_cuzdani/view/reports/categorized_transactions/categorized_transactions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/components/custom_appBar.dart';
import '../../../core/components/custom_bottom_navigation_bar.dart';
import '../../../core/components/popups/add_expense_popup.dart';
import '../../../core/components/transactions_list.dart';
import '../../../core/model/dto_transaction.dart';
import '../../../core/utils/loading_utils.dart';

class CategorizedTransactionView extends StatefulWidget {
  final DTOTransactionRequest transactionRequest;
  final String pageTitle;

  const CategorizedTransactionView({super.key, required this.transactionRequest, required this.pageTitle});

  @override
  State<CategorizedTransactionView> createState() => _CategorizedTransactionViewState();
}

class _CategorizedTransactionViewState extends State<CategorizedTransactionView> {
  CategorizedTransactionsViewModel viewModel = CategorizedTransactionsViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getTransactions(widget.transactionRequest);
    });
  }

  onBackPress() {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CategorizedTransactionsViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          onBackPress();
          return false;
        },
        child: Scaffold(
          backgroundColor: CustomColors.OFF_WHITE,
          appBar: appBar(),
          bottomNavigationBar: customBottomNavigationBar(context, currentIndex: 2),
          body: Observer(builder: (context) {
            return transactionList(
              viewModel.transactions,
              isLoading: false,
              onTap: (DTOTransaction transaction) async {
                bool? result = await showAddIncomePopup(context, transaction: transaction);

                if (result == true) {
                  viewModel.getTransactions(widget.transactionRequest);
                }
              },
            );
          }),
        ),
      ),
    );
  }

  AppBar appBar() {
    return customAppBar(
      context,
      title: widget.pageTitle,
      leading: IconButton(
        onPressed: () {
          onBackPress();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
