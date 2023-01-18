import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/view/cards/cards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/components/bucket_list.dart';
import '../../core/components/custom_appBar.dart';
import '../../core/components/custom_bottom_navigation_bar.dart';
import '../../core/components/custom_material_button.dart';
import '../../core/components/popups/add_card_popup.dart';
import '../../core/components/popups/between_cards_transfer_popup.dart';
import '../../core/constants/app_constants.dart';
import '../../core/model/dto_bucket.dart';
import '../../core/providers/bottom_navbar_provider.dart';
import '../../core/utils/loading_utils.dart';
import '../../core/utils/navigate_animation_state.dart';
import '../../core/utils/navigate_utils.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';

class CardsView extends StatefulWidget {
  const CardsView({super.key});

  @override
  State<CardsView> createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  CardsViewModel viewModel = CardsViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getBuckets();
    });
  }

  Future<bool> onBackPress(BuildContext context) async {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false).setCurrentIndex(0);
      NavigateUtils.pushAndRemoveUntil(context, page: const CustomBottomNavBar(), animationState: NavigateAnimationState.nonAnimation);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CardsViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          return onBackPress(context);
        },
        child: Scaffold(
          bottomNavigationBar: customBottomNavigationBar(context),
          backgroundColor: CustomColors.OFF_WHITE,
          floatingActionButton: addCardButton(),
          appBar: appBar(),
          body: Observer(builder: (_) {
            return Column(
              children: [
                transferButton(),
                Expanded(
                  child: bucketList(
                    viewModel.buckets,
                    onTap: (DTOBucket bucket) async {
                      bool? result = await showAddCardPopup(context, bucket: bucket);
                      if (result == true) {
                        viewModel.getBuckets();
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  FloatingActionButton addCardButton() {
    return FloatingActionButton(
      onPressed: () async {
        bool? result = await showAddCardPopup(context);
        if (result == true) {
          viewModel.getBuckets();
        }
      },
      backgroundColor: CustomColors.DARK_GREEN,
      child: const Icon(Icons.add_card),
    );
  }

  AppBar appBar() {
    return customAppBar(
      context,
      title: "Kartlar",
      leading: IconButton(
        onPressed: () {
          onBackPress(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
      actions: [
        IconButton(
          onPressed: () {
            viewModel.getBuckets();
          },
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }

  Widget transferButton() {
    return Observer(builder: (_) {
      if (viewModel.buckets.length > 1) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: customMaterialButton(
              context: context,
              onTap: () async {
                bool? result = await showBetweenCardsTransferPopup(context);
                if (result == true) {
                  viewModel.getBuckets();
                }
              },
              isLoading: false,
              backgroundColor: CustomColors.DARK_GREEN,
              child: Row(
                children: const [
                  Icon(
                    Icons.sync_alt,
                    color: CustomColors.WHITE,
                  ),
                  Spacer(),
                  Text(
                    "Kartlar Arası Transfer",
                    style: TextStyle(color: CustomColors.WHITE),
                  ),
                  Spacer(),
                  SizedBox(width: 24),
                ],
              )),
        );
      }
      return const SizedBox();
    });
  }
}
