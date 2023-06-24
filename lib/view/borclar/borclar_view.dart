import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/borc_card.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/custom_bottom_navigation_bar.dart';
import 'package:aile_cuzdani/core/components/custom_material_button.dart';
import 'package:aile_cuzdani/core/components/popups/borrows_pay_borrow_popup.dart';
import 'package:aile_cuzdani/core/components/popups/pay_borrow_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/view/borclar/borclar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/utils/navigate_animation_state.dart';
import '../../core/utils/navigate_utils.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';

class BorclarView extends StatefulWidget {
  const BorclarView({super.key});

  @override
  State<BorclarView> createState() => _BorclarViewState();
}

class _BorclarViewState extends State<BorclarView> {
  BorclarViewModel viewModel = BorclarViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getBorrows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onPageBuilder: (_) => body,
    );
  }

  Widget get body => WillPopScope(
        onWillPop: () async {
          onBackPress();
          return false;
        },
        child: Scaffold(
          bottomNavigationBar: customBottomNavigationBar(context),
          backgroundColor: CustomColors.OFF_WHITE,
          floatingActionButton: addCardButton(),
          appBar: appBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            child: SingleChildScrollView(
              child: Observer(builder: (_) {
                return Column(
                  children: [
                    payBorrow(),
                    ListView.builder(
                      itemCount: viewModel.borrows.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, i) => BorcCard(
                        borrows: viewModel.borrows[i],
                        onTap: () async {
                          bool? result = await showPayBorrowPopup(context, borrow: viewModel.borrows[i]);
                          if (result == true) {
                            viewModel.getBorrows();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 86),
                  ],
                );
              }),
            ),
          ),
        ),
      );

  Padding payBorrow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: customMaterialButton(
        context: context,
        onTap: () async {
          bool? result = await showBorrowsPayBorrowPopup(context);
          if (result == true) {
            viewModel.getBorrows();
          }
        },
        isLoading: false,
        backgroundColor: CustomColors.DARK_GREEN,
        child: const Row(
          children: [
            Icon(
              Icons.payments,
              color: CustomColors.WHITE,
            ),
            Spacer(),
            Text(
              "Borç Öde",
              style: TextStyle(color: CustomColors.WHITE),
            ),
            Spacer(),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        bool? result = await showPayBorrowPopup(context);
        if (result == true) {
          viewModel.getBorrows();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add),
    );
  }

  AppBar appBar() {
    return customAppBar(
      context,
      title: "Borçlar",
      leading: IconButton(
        onPressed: () {
          onBackPress();
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  onBackPress() {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false).setCurrentIndex(0);
      NavigateUtils.pushAndRemoveUntil(context, page: const CustomBottomNavBar(), animationState: NavigateAnimationState.nonAnimation);
    }
    return false;
  }
}
