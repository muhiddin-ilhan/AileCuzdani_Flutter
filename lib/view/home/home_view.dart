// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/popups/add_expense_popup.dart';
import 'package:aile_cuzdani/core/components/popups/bucket_reload_popup.dart';
import 'package:aile_cuzdani/core/components/popups/main_pay_borrow_popup.dart';
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
import 'package:aile_cuzdani/core/utils/sizer_utils.dart';
import 'package:aile_cuzdani/view/assets/menu/menu_view.dart';
import 'package:aile_cuzdani/view/borclar/borclar_view.dart';
import 'package:aile_cuzdani/view/family/family_view.dart';
import 'package:aile_cuzdani/view/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeViewModel viewModel = HomeViewModel();

  initState(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      viewModel.scrollController.addListener(viewModel.scrollListener);
      await viewModel.getTransactions(context);
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...totalBalanceText(),
                  ],
                ),
              ),
              Material(
                color: CustomColors.DARK_GREEN,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    if (viewModel.tabIndex == 3) {
                      viewModel.tabIndex = 0;
                      return;
                    }
                    viewModel.tabIndex++;
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_right,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Observer(builder: (_) {
            return viewModel.tabIndex == 1
                ? Column(
                    children: [
                      ...allAssetsList(),
                    ],
                  )
                : viewModel.tabIndex == 2 || viewModel.tabIndex == 3
                    ? Column(
                        children: [
                          ...borrowDetail(),
                        ],
                      )
                    : const SizedBox();
          }),
          menuCardButtons(context),
          Observer(builder: (_) {
            return SizedBox(height: viewModel.isOtherMenuVisible ? 8 : 0);
          }),
          Observer(builder: (context) {
            return viewModel.isOtherMenuVisible ? menuOtherCardButtons(context) : const SizedBox();
          }),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  List<Widget> allAssetsList() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hesaplarım",
            style: TextStyle(
              color: CustomColors.WHITE.withOpacity(0.6),
              fontFamily: "JosefinSans",
              fontSize: viewModel.fontSizeTitle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsAccount!.currencyFormat() : 0.0.currencyFormat()}",
            style: TextStyle(
              color: const Color.fromARGB(255, 118, 231, 182),
              fontWeight: FontWeight.w600,
              fontSize: viewModel.fontSizeTitle,
              height: 1,
            ),
          ),
        ],
      ),
      Observer(builder: (_) {
        return SizedBox(height: viewModel.sizedBox);
      }),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Altın",
            style: TextStyle(
              color: CustomColors.WHITE.withOpacity(0.6),
              fontFamily: "JosefinSans",
              fontSize: viewModel.fontSizeTitle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsGold!.currencyFormat() : 0.0.currencyFormat()}",
            style: TextStyle(
              color: const Color.fromARGB(255, 118, 231, 182),
              fontWeight: FontWeight.w600,
              fontSize: viewModel.fontSizeTitle,
              height: 1,
            ),
          ),
        ],
      ),
      Observer(builder: (_) {
        return SizedBox(height: viewModel.sizedBox);
      }),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Döviz",
            style: TextStyle(
              color: CustomColors.WHITE.withOpacity(0.6),
              fontFamily: "JosefinSans",
              fontSize: viewModel.fontSizeTitle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsCurrency!.currencyFormat() : 0.0.currencyFormat()}",
            style: TextStyle(
              color: const Color.fromARGB(255, 118, 231, 182),
              fontWeight: FontWeight.w600,
              fontSize: viewModel.fontSizeTitle,
              height: 1,
            ),
          ),
        ],
      ),
      Observer(builder: (_) {
        return SizedBox(height: viewModel.sizedBox);
      }),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Borsa",
            style: TextStyle(
              color: CustomColors.WHITE.withOpacity(0.6),
              fontFamily: "JosefinSans",
              fontSize: viewModel.fontSizeTitle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsBorsa!.currencyFormat() : 0.0.currencyFormat()}",
            style: TextStyle(
              color: const Color.fromARGB(255, 118, 231, 182),
              fontWeight: FontWeight.w600,
              fontSize: viewModel.fontSizeTitle,
              height: 1,
            ),
          ),
        ],
      ),
      Observer(builder: (_) {
        return SizedBox(height: viewModel.sizedBox);
      }),
      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Text(
      //       "Coin",
      //       style: TextStyle(
      //         color: CustomColors.WHITE.withOpacity(0.6),
      //         fontFamily: "JosefinSans",
      //         fontSize: viewModel.fontSizeTitle,
      //       ),
      //     ),
      //     const SizedBox(width: 8),
      //     Text(
      //       "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsCoin!.currencyFormat() : 0.0.currencyFormat()}",
      //       style: TextStyle(
      //         color: const Color.fromARGB(255, 118, 231, 182),
      //         fontWeight: FontWeight.w600,
      //         fontSize: viewModel.fontSizeTitle,
      //         height: 1,
      //       ),
      //     ),
      //   ],
      // ),
      // Observer(builder: (_) {
      //   return SizedBox(height: viewModel.sizedBox);
      // }),
    ];
  }

  List<Widget> borrowDetail() {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Kredi Kartı",
            style: TextStyle(
              color: CustomColors.WHITE.withOpacity(0.6),
              fontFamily: "JosefinSans",
              fontSize: viewModel.fontSizeTitle,
            ),
          ),
          const SizedBox(width: 8),
          Observer(builder: (_) {
            return Text(
              viewModel.tabIndex == 2
                  ? "₺${viewModel.totalValues != null ? viewModel.totalValues!.myBorrowsThisMonthCreditCards!.currencyFormat() : 0.0.currencyFormat()}"
                  : "₺${viewModel.totalValues != null ? viewModel.totalValues!.myBorrowsCreditCards!.currencyFormat() : 0.0.currencyFormat()}",
              style: TextStyle(
                color: const Color.fromARGB(255, 118, 231, 182),
                fontWeight: FontWeight.w600,
                fontSize: viewModel.fontSizeTitle,
                height: 1,
              ),
            );
          }),
        ],
      ),
      Observer(builder: (_) {
        return SizedBox(height: viewModel.sizedBox);
      }),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Diğer",
            style: TextStyle(
              color: CustomColors.WHITE.withOpacity(0.6),
              fontFamily: "JosefinSans",
              fontSize: viewModel.fontSizeTitle,
            ),
          ),
          const SizedBox(width: 8),
          Observer(builder: (_) {
            return Text(
              viewModel.tabIndex == 2
                  ? "₺${viewModel.totalValues != null ? viewModel.totalValues!.myBorrowsThisMonthCredi!.currencyFormat() : 0.0.currencyFormat()}"
                  : "₺${viewModel.totalValues != null ? viewModel.totalValues!.myBorrowsCredi!.currencyFormat() : 0.0.currencyFormat()}",
              style: TextStyle(
                color: const Color.fromARGB(255, 118, 231, 182),
                fontWeight: FontWeight.w600,
                fontSize: viewModel.fontSizeTitle,
                height: 1,
              ),
            );
          }),
        ],
      ),
      Observer(builder: (_) {
        return SizedBox(height: viewModel.sizedBox);
      }),
    ];
  }

  Widget menuCardButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        menuCardItem(
          title: "Gelir",
          icon: Icons.addchart_rounded,
          onTap: () async {
            bool? result = await showAddIncomePopup(context, state: ExpenseState.income);

            if (result == true) {
              viewModel.getTransactions(context);
            }
          },
        ),
        menuCardItem(
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
        menuCardItem(
          title: "Varlık",
          icon: Icons.account_balance_wallet_outlined,
          iconColor: Colors.cyan[600],
          onTap: () async {
            NavigateUtils.pushAndRemoveUntil(context, page: const MenuView(), animationState: NavigateAnimationState.nonAnimation);
          },
        ),
        menuCardItem(
          title: "",
          icon: Icons.more_horiz_rounded,
          iconColor: CustomColors.DARK_GREY,
          onTap: () async {
            viewModel.isOtherMenuVisible = !viewModel.isOtherMenuVisible;
          },
        ),
      ],
    );
  }

  Widget menuOtherCardButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        menuCardItem(
          title: "Borçlar",
          icon: Icons.receipt_outlined,
          iconColor: Colors.blueGrey,
          onTap: () async {
            NavigateUtils.pushAndRemoveUntil(
              context,
              page: const BorclarView(),
              animationState: NavigateAnimationState.nonAnimation,
            );
          },
        ),
        menuCardItem(
          title: "Ailem",
          iconColor: Colors.greenAccent[800],
          icon: Icons.groups_2_outlined,
          onTap: () {
            NavigateUtils.pushAndRemoveUntil(
              context,
              page: const FamilyView(),
              animationState: NavigateAnimationState.nonAnimation,
            );
          },
        ),
        menuCardItem(
          title: "Ödeme",
          icon: Icons.payments_outlined,
          iconColor: const Color.fromARGB(255, 150, 76, 121),
          onTap: () async {
            bool? result = await showMainPayBorrowPopup(context);
            if (result == true) {
              viewModel.getTransactions(context);
            }
          },
        ),
        menuCardItem(
          title: "Yenile",
          icon: Icons.sync,
          iconColor: const Color.fromARGB(255, 51, 117, 131),
          onTap: () async {
            bool? result = await showBucketReloadPopup(context);
            if (result == true) {
              viewModel.setLoading(true);
              viewModel.getTransactions(context);
            }
          },
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

  List<Widget> totalBalanceText() {
    return [
      Observer(builder: (_) {
        return Text(
          viewModel.tabIndex == 0
              ? "Varlığım (Özel)"
              : viewModel.tabIndex == 1
                  ? "Varlığım (Tümü)"
                  : viewModel.tabIndex == 2
                      ? "Borçlarım (Bu Ay)"
                      : "Borçlarım (Tümü)",
          style: TextStyle(
            color: CustomColors.WHITE.withOpacity(0.6),
            fontFamily: "JosefinSans",
          ),
        );
      }),
      Observer(builder: (_) {
        return Text(
          viewModel.tabIndex == 0
              ? "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsSpecial!.currencyFormat() : 0.0.currencyFormat()}"
              : viewModel.tabIndex == 1
                  ? "₺${viewModel.totalValues != null ? viewModel.totalValues!.myAssetsAll!.currencyFormat() : 0.0.currencyFormat()}"
                  : viewModel.tabIndex == 2
                      ? "₺${viewModel.totalValues != null ? viewModel.totalValues!.myBorrowsThisMonth!.currencyFormat() : 0.0.currencyFormat()}"
                      : "₺${viewModel.totalValues != null ? viewModel.totalValues!.myBorrowsTotal!.currencyFormat() : 0.0.currencyFormat()}",
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
        Expanded(
          child: Observer(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  viewModel.tabIndex == 0 ? Icons.circle : Icons.circle_outlined,
                  color: Colors.white,
                  size: 12,
                ),
                Icon(
                  viewModel.tabIndex == 1 ? Icons.circle : Icons.circle_outlined,
                  color: Colors.white,
                  size: 12,
                ),
                Icon(
                  viewModel.tabIndex == 2 ? Icons.circle : Icons.circle_outlined,
                  color: Colors.white,
                  size: 12,
                ),
                Icon(
                  viewModel.tabIndex == 3 ? Icons.circle : Icons.circle_outlined,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            );
          }),
        ),
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
