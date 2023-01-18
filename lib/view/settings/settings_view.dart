import 'dart:developer';

import 'package:aile_cuzdani/core/api/user/user_services.dart';
import 'package:aile_cuzdani/core/base/base_view.dart';
import 'package:aile_cuzdani/core/components/custom_appBar.dart';
import 'package:aile_cuzdani/core/components/popups/about_popup.dart';
import 'package:aile_cuzdani/core/components/popups/communication_popup.dart';
import 'package:aile_cuzdani/core/components/popups/family_settings_popup.dart';
import 'package:aile_cuzdani/core/components/popups/message_popup.dart';
import 'package:aile_cuzdani/core/components/popups/notification_settings_popup.dart';
import 'package:aile_cuzdani/core/constants/app_constants.dart';
import 'package:aile_cuzdani/core/providers/bottom_navbar_provider.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/core/utils/navigate_animation_state.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:aile_cuzdani/view/profile/profile_view.dart';
import 'package:aile_cuzdani/view/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  SettingsViewModel viewModel = SettingsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      onPageBuilder: (context) => WillPopScope(
        onWillPop: () async {
          Provider.of<BottomNavBarProvider>(context, listen: false).goPage(0);
          return false;
        },
        child: Scaffold(
          backgroundColor: CustomColors.OFF_WHITE,
          appBar: appBar(context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  settingsCardItem(
                    icon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 188, 121, 53),
                    ),
                    text: "Profilim",
                    onTap: () {
                      NavigateUtils.pushAndRemoveUntil(
                        context,
                        page: ProfileView(),
                        animationState: NavigateAnimationState.nonAnimation,
                      );
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
                      Icons.family_restroom,
                      color: CustomColors.GREEN,
                    ),
                    text: "Aile Ayarları",
                    onTap: () {
                      showFamilySettingsPopup(context);
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
                      Icons.notifications,
                      color: Color.fromARGB(255, 83, 80, 80),
                    ),
                    text: "Bildirim Ayarı",
                    onTap: () {
                      showNotificationSettingsPopup(context);
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
                      Icons.mail,
                      color: Color.fromARGB(255, 55, 133, 172),
                    ),
                    text: "İletişim",
                    onTap: () {
                      showCommunicationPopup(context);
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
                      Icons.info,
                      color: Color.fromARGB(255, 90, 41, 93),
                    ),
                    text: "Hakkında",
                    onTap: () {
                      showAboutPopup(context, appVersion: viewModel.version);
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
                      Icons.delete,
                      color: Color.fromARGB(255, 150, 57, 57),
                    ),
                    text: "Hesabımı Sil",
                    onTap: () {
                      showMessagePopup(
                        context,
                        title: "Hesabımı Sil",
                        message: "Hesabınız silindiği takdirde tüm verileriniz kaybolacaktır. Yinede hesabınızı silmek istediğinize emin misiniz?",
                        onAcceptTap: () {
                          showMessagePopup(
                            context,
                            title: "Kararın Kesin mi?",
                            message: "Hesabını silmek istediğine gerçekten emin misin?",
                            onAcceptTap: () async {
                              LoadingUtils.instance.loading(true);

                              try {
                                await UserServices.deleteAccount();
                              } catch (e) {
                                log(e.toString());
                              }

                              LoadingUtils.instance.loading(false);
                            },
                            onAccessTitle: "Sil",
                            onRejectTap: () {},
                            onRejectTitle: "Vazgeç",
                          );
                        },
                        onAccessTitle: "Sil",
                        onRejectTap: () {},
                        onRejectTitle: "Vazgeç",
                      );
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
                      Icons.logout,
                      color: Color.fromARGB(255, 150, 57, 57),
                    ),
                    text: "Oturumu Kapat",
                    onTap: () {
                      showMessagePopup(
                        context,
                        title: "Oturumu Kapat",
                        message: "Oturumunu kapatmak istediğine gerçekten emin misin?",
                        onAcceptTap: () {
                          NavigateUtils.logout(context);
                        },
                        onAccessTitle: "Evet",
                        onRejectTap: () {},
                        onRejectTitle: "Vazgeç",
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
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

  AppBar appBar(BuildContext context) {
    return customAppBar(
      context,
      title: "Ayarlar",
      leading: IconButton(
        onPressed: () {
          Provider.of<BottomNavBarProvider>(context, listen: false).goPage(0);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }
}
