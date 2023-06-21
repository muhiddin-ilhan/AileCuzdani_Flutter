import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/custom_bottom_navigation_bar.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/core/utils/navigate_animation_state.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/view/assets/altin/altin_view.dart';
import 'package:aile_cuzdani/view/assets/bank_cards/bank_cards_view.dart';
import 'package:aile_cuzdani/view/assets/borsa/borsa_view.dart';
import 'package:aile_cuzdani/view/assets/credit_cards/credit_cards_view.dart';
import 'package:aile_cuzdani/view/assets/doviz/doviz_view.dart';
import 'package:aile_cuzdani/view/assets/menu/menu_view_model.dart';
import 'package:aile_cuzdani/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  MenuViewModel viewModel = MenuViewModel();

  onBackPress(BuildContext context) {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false).setCurrentIndex(0);
      NavigateUtils.pushAndRemoveUntil(
        context,
        page: const CustomBottomNavBar(),
        animationState: NavigateAnimationState.nonAnimation,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          onBackPress(context);
          return false;
        },
        child: Scaffold(
          bottomNavigationBar: customBottomNavigationBar(context),
          backgroundColor: CustomColors.OFF_WHITE,
          appBar: appBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  settingsCardItem(
                    icon: const Icon(
                      Icons.credit_card,
                      color: Colors.purple,
                    ),
                    text: "Banka Kartları",
                    onTap: () {
                      NavigateUtils.push(context, page: const BankCardView());
                    },
                  ),
                  Divider(
                    indent: 58,
                    endIndent: 42,
                    thickness: 1,
                    color: CustomColors.LIGHT_BLACK.withOpacity(0.1),
                  ),
                  settingsCardItem(
                    icon: const Icon(
                      Icons.credit_card,
                      color: Colors.cyan,
                    ),
                    text: "Kredi Kartları",
                    onTap: () {
                      NavigateUtils.push(context, page: const CreditCardView());
                    },
                  ),
                  Divider(
                    indent: 58,
                    endIndent: 42,
                    thickness: 1,
                    color: CustomColors.LIGHT_BLACK.withOpacity(0.1),
                  ),
                  settingsCardItem(
                    icon: Icon(
                      Icons.paid_outlined,
                      color: Colors.amber[700],
                    ),
                    text: "Altın",
                    onTap: () {
                      NavigateUtils.push(context, page: const AltinView());
                    },
                  ),
                  Divider(
                    indent: 58,
                    endIndent: 42,
                    thickness: 1,
                    color: CustomColors.LIGHT_BLACK.withOpacity(0.1),
                  ),
                  settingsCardItem(
                    icon: const Icon(
                      Icons.currency_lira_outlined,
                      color: CustomColors.GREEN,
                    ),
                    text: "Döviz",
                    onTap: () {
                      NavigateUtils.push(context, page: const DovizView());
                    },
                  ),
                  Divider(
                    indent: 58,
                    endIndent: 42,
                    thickness: 1,
                    color: CustomColors.LIGHT_BLACK.withOpacity(0.1),
                  ),
                  settingsCardItem(
                    icon: const Icon(
                      Icons.history_edu_outlined,
                      color: CustomColors.GREY,
                    ),
                    text: "Borsa",
                    onTap: () {
                      NavigateUtils.push(context, page: const BorsaView());
                    },
                  ),
                  // Divider(
                  //   indent: 58,
                  //   endIndent: 42,
                  //   thickness: 1,
                  //   color: CustomColors.LIGHT_BLACK.withOpacity(0.1),
                  // ),
                  // settingsCardItem(
                  //   icon: const Icon(
                  //     Icons.currency_bitcoin,
                  //     color: Colors.brown,
                  //   ),
                  //   text: "Kripto Para",
                  //   onTap: () {
                  //     NavigateUtils.push(context, page: const CryptoView());
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return customAppBar(
      context,
      title: "Varlıklarım",
      leading: IconButton(
        onPressed: () {
          onBackPress(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  Widget settingsCardItem({
    required Icon icon,
    required String text,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 212, 212, 212),
            ),
            child: icon,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: CustomColors.BLACK.withOpacity(0.8),
                fontFamily: "JosefinSans",
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
