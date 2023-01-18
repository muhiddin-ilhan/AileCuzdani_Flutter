// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:aile_cuzdani/view/family/family_view_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/components/custom_bottom_navigation_bar.dart';
import '../../core/components/custom_material_button.dart';
import '../../core/components/list_card_item.dart';
import '../../core/components/popups/message_popup.dart';
import '../../core/components/popups/user_detail_popup.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/authentication_provider.dart';
import '../../core/providers/bottom_navbar_provider.dart';
import '../../core/utils/loading_utils.dart';
import '../../core/utils/navigate_animation_state.dart';
import '../../core/utils/navigate_utils.dart';
import '../../core/utils/sizer_utils.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';

class FamilyView extends StatefulWidget {
  const FamilyView({super.key});

  @override
  State<FamilyView> createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView> {
  FamilyViewModel viewModel = FamilyViewModel();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getFamilyInfos(context);
    });
  }

  onBackPress(BuildContext context) {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false)
          .setCurrentIndex(0);
      NavigateUtils.pushAndRemoveUntil(
        context,
        page: const CustomBottomNavBar(),
        animationState: NavigateAnimationState.nonAnimation,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FamilyViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          onBackPress(context);
          return false;
        },
        child: Scaffold(
          bottomNavigationBar: customBottomNavigationBar(context),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  topSection(),
                  bottomSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSection() {
    return Expanded(
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: bottomSectionTitle()),
                const SizedBox(height: 10),
                ...familyRequests(),
                ...familyMembers(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> familyMembers() {
    return [
      Observer(builder: (_) {
        if (viewModel.family != null) {
          if (viewModel.family!.users != null) {
            if (viewModel.family!.users!.isNotEmpty) {
              return const Padding(
                padding: EdgeInsets.only(left: 30, top: 20, bottom: 4),
                child: Text(
                  "Aile Üyeleri",
                  style: TextStyle(
                    color: Color.fromARGB(211, 59, 59, 59),
                    fontFamily: "JosefinSans",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              );
            }
          }
        }
        return const SizedBox();
      }),
      Observer(builder: (_) {
        return ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.family != null
              ? viewModel.family!.users != null
                  ? viewModel.family!.users!.length
                  : 0
              : 0,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) => listCardItem(
            onTap: () {
              showUserDetailPopup(context,
                  user: viewModel.family!.users![index]);
            },
            titleText:
                "${viewModel.family!.users![index].name.firstCapitalize()} ${viewModel.family!.users![index].surname.firstCapitalize()}",
            subTitleText: "Aile Üyesi",
            suffixWidget: InkWell(
              onTap: () {
                showMessagePopup(
                  context,
                  message:
                      "${viewModel.family!.users![index].name} ${viewModel.family!.users![index].surname} Kişisini Aileden Çıkartmak İstiyor musunuz?",
                  title: "Üyelik Feshi",
                  onAcceptTap: () {
                    viewModel.removeFamilyMember(context,
                        user: viewModel.family!.users![index]);
                  },
                  onAccessTitle: "Evet",
                  onRejectTap: () {},
                  onRejectTitle: "Vazgeç",
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 230, 205, 168),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: CustomColors.BLACK.withOpacity(0.6),
                  size: 22,
                ),
              ),
            ),
          ),
        );
      }),
    ];
  }

  List<Widget> familyRequests() {
    return [
      Observer(builder: (_) {
        if (viewModel.familyRequests.isNotEmpty) {
          return const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, bottom: 4),
            child: Text(
              "Aile Katılım Talepleri",
              style: TextStyle(
                color: Color.fromARGB(211, 59, 59, 59),
                fontFamily: "JosefinSans",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
          );
        }
        return const SizedBox();
      }),
      Observer(builder: (_) {
        return ListView.separated(
          shrinkWrap: true,
          itemCount: viewModel.familyRequests.length,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (context, index) => listCardItem(
            onTap: null,
            titleText:
                "${viewModel.familyRequests[index].users!.name.firstCapitalize()} ${viewModel.familyRequests[index].users!.surname.firstCapitalize()}",
            subTitleText:
                viewModel.familyRequests[index].created_at!.toDateTimeString(),
            suffixWidget: Row(
              children: [
                InkWell(
                  onTap: () {
                    showMessagePopup(
                      context,
                      message:
                          "Aile Talebini Reddetmek İstediğinize Emin misiniz?",
                      title: "Talebi Reddet",
                      onAcceptTap: () {
                        viewModel.answerFamilyRequest(context,
                            isAccept: false,
                            familyRequest: viewModel.familyRequests[index]);
                      },
                      onAccessTitle: "Evet",
                      onRejectTap: () {},
                      onRejectTitle: "Vazgeç",
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 250, 208, 208),
                    ),
                    child: Icon(
                      Icons.close,
                      color: CustomColors.BLACK.withOpacity(0.6),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () {
                    showMessagePopup(
                      context,
                      message:
                          "Aile Talebini Onaylamak İstediğinize Emin misiniz?",
                      title: "Talebi Onayla",
                      onAcceptTap: () {
                        viewModel.answerFamilyRequest(context,
                            isAccept: true,
                            familyRequest: viewModel.familyRequests[index]);
                      },
                      onAccessTitle: "Evet",
                      onRejectTap: () {},
                      onRejectTitle: "Vazgeç",
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 203, 235, 216),
                    ),
                    child: Icon(
                      Icons.done,
                      color: CustomColors.BLACK.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ];
  }

  Widget bottomSectionTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0, right: 28, top: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Ailem",
            style: TextStyle(
              color: CustomColors.VERY_DARK_GREEN,
              fontFamily: "JosefinSans",
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget topSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          appBar(),
          const SizedBox(height: 8),
          ...familyBigName(),
          const SizedBox(height: 14),
          familyNumbers(),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget familyNumbers() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Üye Sayısı",
                  style: TextStyle(
                    color: CustomColors.WHITE.withOpacity(0.6),
                    fontFamily: "JosefinSans",
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  viewModel.family != null
                      ? viewModel.family!.users!.length.toString()
                      : "0",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Talep Sayısı",
                  style: TextStyle(
                    color: CustomColors.WHITE.withOpacity(0.6),
                    fontFamily: "JosefinSans",
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  viewModel.familyRequests.isNotEmpty
                      ? viewModel.familyRequests.length.toString()
                      : "0",
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
        ),
      );
    });
  }

  List<Widget> familyBigName() {
    return [
      Observer(builder: (_) {
        return Text(
          viewModel.family != null
              ? viewModel.family!.title.firstCapitalize() ?? ""
              : "...",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: CustomColors.OFF_WHITE,
            fontFamily: "JosefinSans",
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        );
      }),
      const SizedBox(height: 4),
      Observer(builder: (_) {
        return customMaterialButton(
          context: context,
          onTap: () {
            showMessagePopup(
              context,
              message: "Aileyi Terketmek İstediğinize Emin misiniz?",
              title: "Aileyi Terket",
              onAcceptTap: () {
                viewModel.removeFamilyMember(context,
                    user: Provider.of<AuthenticationProvider>(context,
                            listen: false)
                        .user!);
              },
              onAccessTitle: "Evet",
              onRejectTap: () {},
              onRejectTitle: "Vazgeç",
            );
          },
          isLoading: viewModel.isLoading,
          height: 30,
          text: "Aileyi Terket",
          enableLoadingAnim: false,
          isFullWidth: false,
          backgroundColor: CustomColors.DARK_GREEN,
          disableBackgroundColor: CustomColors.DARK_GREEN,
          elevation: 0,
          textStyle: const TextStyle(
            color: Color.fromARGB(218, 255, 255, 255),
            fontFamily: "JosefinSans",
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        );
      }),
    ];
  }

  Widget appBar() {
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
              Icons.arrow_back_ios_new,
              color: CustomColors.WHITE,
              size: 28,
            ),
          ),
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              await viewModel.getFamilyInfos(context);
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
}
