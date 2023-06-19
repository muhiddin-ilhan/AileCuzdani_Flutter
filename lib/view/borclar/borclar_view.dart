import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/borc_card.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/custom_bottom_navigation_bar.dart';
import 'package:aile_cuzdani/core/components/popups/pay_borrow_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/view/borclar/borclar_view_model.dart';
import 'package:flutter/material.dart';
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
            child: Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (_, i) => const BorcCard(),
              ),
            ),
          ),
        ),
      );

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        showPayBorrowPopup(context);
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
      Provider.of<BottomNavBarProvider>(context, listen: false)
          .setCurrentIndex(0);
      NavigateUtils.pushAndRemoveUntil(context,
          page: const CustomBottomNavBar(),
          animationState: NavigateAnimationState.nonAnimation);
    }
    return false;
  }
}
