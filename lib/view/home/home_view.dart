// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_showcase.dart';
import 'package:aile_cuzdani/core/components/popups/add_expense_popup.dart';
import 'package:aile_cuzdani/core/components/popups/message_popup.dart';
import 'package:aile_cuzdani/core/components/transactions_list.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/currency_extension.dart';
import 'package:aile_cuzdani/core/model/dto_transaction.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/expense_enum.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/core/utils/navigate_animation_state.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/core/utils/shared_preferences.dart';
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/cards/cards_view.dart';
import 'package:aile_cuzdani/view/family/family_view.dart';
import 'package:aile_cuzdani/view/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeViewModel viewModel = HomeViewModel();
  final GlobalKey _totalExpenseShowCase = GlobalKey();
  final GlobalKey _incomeExpenseShowCase = GlobalKey();
  final GlobalKey _expenseButtonShowCase = GlobalKey();
  final GlobalKey _incomeButtonShowCase = GlobalKey();
  final GlobalKey _familyButtonShowCase = GlobalKey();
  final GlobalKey _cardsButtonShowCase = GlobalKey();
  final GlobalKey _thisMonthTransactionsShowCase = GlobalKey();

  initState(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      viewModel.scrollController.addListener(viewModel.scrollListener);
      await viewModel.getTransactions(context);

      bool showCase = await SharedManager.instance.getBoolValue("HomeViewShowCase") ?? false;

      if (!showCase) {
        ShowCaseWidget.of(context).startShowCase([
          _totalExpenseShowCase,
          _incomeExpenseShowCase,
          _incomeButtonShowCase,
          _expenseButtonShowCase,
          _familyButtonShowCase,
          _cardsButtonShowCase,
          _thisMonthTransactionsShowCase,
        ]);

        await SharedManager.instance.setBoolValue("HomeViewShowCase", true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      initState: initState,
      onPageBuilder: (context) => WillPopScope(
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
                      key: _thisMonthTransactionsShowCase,
                      description: "Ay İçerisinde Yapılmış Gelir/Giderler Burada Kronolojik Sırayla Görüntülenir",
                      child: transactionList(
                        viewModel.transactions,
                        scrollController: viewModel.scrollController,
                        topPadding: (((viewModel.maxFontSizeTitle + viewModel.maxFontSizePrice) - (viewModel.fontSizePrice + viewModel.fontSizeTitle)) * 2) +
                            (viewModel.maxIconSize - viewModel.iconSize),
                        isLoading: false,
                        onTap: (DTOTransaction transaction) async {
                          bool? result = await showAddIncomePopup(context, transaction: transaction);

                          if (result == true) {
                            viewModel.getTransactions(context);
                          }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Text(
              "Bu Ayın İşlemleri",
              style: TextStyle(
                color: CustomColors.VERY_DARK_GREEN,
                fontFamily: "JosefinSans",
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Provider.of<BottomNavBarProvider>(context, listen: false).goPage(1);
            },
            child: Text(
              "Tümünü Gör",
              style: TextStyle(
                color: CustomColors.VERY_DARK_GREEN.withOpacity(0.75),
                fontFamily: "JosefinSans",
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
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
          customShowCase(
            key: _totalExpenseShowCase,
            description: "Ay İçerisinde Yapılan Gelir/Giderlerin Sonucunu Gösterir",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...totalBalanceText(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          customShowCase(
            key: _incomeExpenseShowCase,
            description: "Ay İçerisinde Yapılan Gelir/Gider'i ve Geçen Aydan Devreden Parayı Gösterir",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                incomeExpenseTexts(),
                Observer(builder: (_) {
                  return SizedBox(height: viewModel.fontSizeTitle + 1);
                }),
                lastMonthPriceText(),
              ],
            ),
          ),
          Observer(builder: (_) {
            return SizedBox(height: viewModel.fontSizeTitle + 1);
          }),
          menuCardButtons(context),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget menuCardButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customShowCase(
          key: _incomeButtonShowCase,
          description: "Yeni Bir Gelir Eklemek İçin Bu Butonu Kullanın",
          child: menuCardItem(
            title: "Gelir",
            icon: Icons.addchart_rounded,
            onTap: () async {
              bool? result = await showAddIncomePopup(context, state: ExpenseState.income);

              if (result == true) {
                viewModel.getTransactions(context);
              }
            },
          ),
        ),
        customShowCase(
          key: _expenseButtonShowCase,
          description: "Yeni Bir Harcama Eklemek İçin Bu Butonu Kullanın",
          child: menuCardItem(
            title: "Harcama",
            icon: Icons.discount_outlined,
            iconColor: const Color.fromARGB(255, 167, 120, 40),
            onTap: () async {
              bool? result = await showAddIncomePopup(context);

              if (result == true) {
                viewModel.getTransactions(context);
              }
            },
          ),
        ),
        customShowCase(
          key: _familyButtonShowCase,
          description: "Aile Üyelerini ve Aile Katılım Taleplerini Görmek İçin Bu Sayfaya Bakabilirsiniz",
          child: menuCardItem(
            title: "Aile",
            icon: Icons.groups_outlined,
            iconColor: CustomColors.DARK_GREY,
            onTap: () {
              NavigateUtils.pushAndRemoveUntil(context, page: const FamilyView(), animationState: NavigateAnimationState.nonAnimation);
            },
          ),
        ),
        customShowCase(
          key: _cardsButtonShowCase,
          description: "Ailede Bulunan Kartları Görmek ve Yönetmek İçin Bu Sayfaya Bakabilirsiniz",
          child: menuCardItem(
            title: "Kartlar",
            iconColor: const Color.fromARGB(255, 66, 105, 171),
            icon: Icons.payments_outlined,
            onTap: () {
              NavigateUtils.pushAndRemoveUntil(context, page: const CardsView(), animationState: NavigateAnimationState.nonAnimation);
            },
          ),
        ),
      ],
    );
  }

  Widget menuCardItem({required String title, required IconData icon, Color? iconColor, required Function() onTap}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: CustomColors.OFF_WHITE, boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 2,
              color: Colors.white.withOpacity(0.3),
            ),
          ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              splashColor: CustomColors.GREEN,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Observer(builder: (_) {
                  return Icon(
                    icon,
                    size: viewModel.iconSize,
                    color: iconColor ?? CustomColors.DARK_GREEN,
                  );
                }),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: TextStyle(
            color: CustomColors.WHITE.withOpacity(0.8),
            fontFamily: "JosefinSans",
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget incomeExpenseTexts() {
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
                    fontSize: viewModel.fontSizeTitle,
                  ),
                ),
                Text(
                  "₺${viewModel.totalValues != null ? viewModel.totalValues!.currentMonthIncome!.currencyFormat() : 0.0.currencyFormat()}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 118, 231, 182),
                    fontWeight: FontWeight.w600,
                    fontSize: viewModel.fontSizePrice,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(width: viewModel.fontSizePrice),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gider",
                  style: TextStyle(
                    color: CustomColors.WHITE.withOpacity(0.6),
                    fontFamily: "JosefinSans",
                    fontSize: viewModel.fontSizeTitle,
                  ),
                ),
                Text(
                  "₺${viewModel.totalValues != null ? (viewModel.totalValues!.currentMonthExpense! * -1).currencyFormat() : 0.0.currencyFormat()}",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 249, 166, 166),
                    fontWeight: FontWeight.w600,
                    fontSize: viewModel.fontSizePrice,
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

  Widget lastMonthPriceText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: Observer(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Geçen Aydan Devreden",
              style: TextStyle(
                color: CustomColors.WHITE.withOpacity(0.6),
                fontFamily: "JosefinSans",
                fontSize: viewModel.fontSizeTitle,
              ),
            ),
            Text(
              "₺${viewModel.totalValues != null ? (viewModel.totalValues!.lastMonthBalance!).currencyFormat() : 0.0.currencyFormat()}",
              style: TextStyle(
                color: const Color.fromARGB(255, 208, 185, 142),
                fontWeight: FontWeight.w600,
                fontSize: viewModel.fontSizePrice,
                height: 1,
              ),
            ),
          ],
        );
      }),
    );
  }

  List<Widget> totalBalanceText() {
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
          "₺${viewModel.totalValues != null ? viewModel.totalValues!.totalBalance!.currencyFormat() : 0.0.currencyFormat()}",
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
              Icons.logout_outlined,
              color: CustomColors.WHITE,
              size: 28,
            ),
          ),
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              viewModel.getTransactions(context);
            },
            borderRadius: BorderRadius.circular(10),
            child: const Icon(
              Icons.refresh_rounded,
              color: CustomColors.WHITE,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }

  onBackPress(BuildContext context) {
    if (!LoadingUtils.instance.isLoadingActive()) {
      showMessagePopup(
        context,
        title: "Oturumu Sonlandır",
        message: "Oturumunuzu Kapatmak İstediğinize Emin misiniz?",
        onAccessTitle: "Evet",
        onAcceptTap: () {
          NavigateUtils.logout(context);
        },
        onRejectTitle: "İptal",
        onRejectTap: () {},
      );
    }
  }
}
