// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_bottom_navigation_bar.dart';
import 'package:aile_cuzdani/core/components/popups/change_password_popup.dart';
import 'package:aile_cuzdani/core/components/popups/user_edit_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/extensions/datetime_extension.dart';
import 'package:aile_cuzdani/core/extensions/string_extension.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/view/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../core/components/custom_material_button.dart';
import '../../core/components/popups/message_popup.dart';
import '../../core/providers/bottom_navbar_provider.dart';
import '../../core/utils/loading_utils.dart';
import '../../core/utils/navigate_animation_state.dart';
import '../../core/utils/sizer_utils.dart';
import '../bottom_navigation_bar/bottom_navigation_bar.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileViewModel viewModel = ProfileViewModel();

  onBackPress(BuildContext context) {
    if (!LoadingUtils.instance.isLoadingActive()) {
      Provider.of<BottomNavBarProvider>(context, listen: false).setCurrentIndex(3);
      NavigateUtils.pushAndRemoveUntil(
        context,
        page: const CustomBottomNavBar(),
        animationState: NavigateAnimationState.nonAnimation,
      );
    }
  }

  void initState(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.getCurrentUser(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      initState: initState,
      dispose: (_) {},
      onPageBuilder: (_) => WillPopScope(
        onWillPop: () async {
          onBackPress(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: CustomColors.DARK_GREEN,
          bottomNavigationBar: customBottomNavigationBar(context),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bottomSectionTitle(),
                    const SizedBox(height: 10),
                    ...infoCard(
                      content: viewModel.user == null ? "" : "${viewModel.user!.name.firstCapitalize()} ${viewModel.user!.surname.firstCapitalize()}",
                      title: "Ad Soyad",
                      icon: Icons.person,
                      onTap: viewModel.user == null
                          ? null
                          : () async {
                              bool? result = await showUserEditPopup(
                                context,
                                whatEdit: "ADSOYAD",
                                user: DTOUser(name: viewModel.user!.name.firstCapitalize(), surname: viewModel.user!.surname.firstCapitalize()),
                              );

                              if (result == true) {
                                viewModel.getCurrentUser(context);
                              }
                            },
                    ),
                    ...infoCard(
                      content: viewModel.user == null ? "" : viewModel.user!.email!,
                      title: "Email",
                      icon: Icons.email,
                      onTap: viewModel.user == null
                          ? null
                          : () async {
                              bool? result = await showUserEditPopup(
                                context,
                                whatEdit: "EMAIL",
                                user: DTOUser(email: viewModel.user!.email),
                              );

                              if (result == true) {
                                viewModel.getCurrentUser(context);
                              }
                            },
                    ),
                    ...infoCard(
                      content: "########",
                      title: "Parola",
                      icon: Icons.vpn_key,
                      onTap: viewModel.user == null
                          ? null
                          : () async {
                              bool? result = await showChangePasswordPopup(context);

                              if (result == true) {
                                viewModel.getCurrentUser(context);
                              }
                            },
                    ),
                    ...infoCard(
                      content: viewModel.user == null ? "" : viewModel.user!.created_at!.toDateTimeString(),
                      title: "Hesap Açılış Tarihi",
                      icon: Icons.date_range,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> infoCard({required String content, required String title, required IconData icon, Function()? onTap}) {
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(31, 10, 0, 0),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "JosefinSans",
            color: Color.fromARGB(255, 81, 81, 81),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(28, 2, 28, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.WHITE,
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                spreadRadius: 1,
                color: Colors.black.withOpacity(0.075),
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.DARK_WHITE,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      icon,
                      color: CustomColors.GREEN,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Observer(builder: (_) {
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        viewModel.user != null ? content : "...",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: "JosefinSans",
                          color: Color.fromARGB(255, 36, 36, 36),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
                ),
                if (onTap != null)
                  InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(10),
                    child: const Icon(
                      Icons.edit,
                      color: CustomColors.GREEN,
                    ),
                  ),
                const SizedBox(width: 6),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  Widget bottomSectionTitle() {
    return const Padding(
      padding: EdgeInsets.only(left: 28.0, right: 28, top: 28),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Bilgilerim",
          style: TextStyle(
            color: CustomColors.VERY_DARK_GREEN,
            fontFamily: "JosefinSans",
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget topSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          appBar(context),
          const SizedBox(height: 14),
          userName(context),
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  Widget userName(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.DARK_GREEN,
          ),
          child: const Padding(
            padding: EdgeInsets.all(13),
            child: Icon(
              Icons.person,
              color: CustomColors.WHITE,
              size: 32,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Observer(builder: (_) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    viewModel.user == null ? " " : "${viewModel.user!.name.firstCapitalize()} ${viewModel.user!.surname.firstCapitalize()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CustomColors.OFF_WHITE,
                      fontFamily: "JosefinSans",
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 4),
              customMaterialButton(
                context: context,
                onTap: () {
                  showMessagePopup(
                    context,
                    message: "Oturumunuzu Kapatmak İstediğinize Emin misiniz?",
                    title: "Oturumu Kapat",
                    onAcceptTap: () {
                      NavigateUtils.logout(context);
                    },
                    onAccessTitle: "Evet",
                    onRejectTap: () {},
                    onRejectTitle: "Vazgeç",
                  );
                },
                isLoading: viewModel.isLoading,
                height: 30,
                text: "Oturumu Kapat",
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
              ),
            ],
          ),
        ),
        const SizedBox(width: 50),
      ],
    );
  }

  Widget appBar(BuildContext context) {
    return Observer(
      builder: (_) => Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: viewModel.isLoading
                  ? null
                  : () {
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
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: viewModel.isLoading
                  ? null
                  : () async {
                      await viewModel.getCurrentUser(context);
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
      ),
    );
  }
}
