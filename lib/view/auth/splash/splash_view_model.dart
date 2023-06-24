// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/api.dart';
import 'package:aile_cuzdani/core/api/version/version_services.dart';
import 'package:aile_cuzdani/view/auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../../core/api/authentication/authentication_services.dart';
import '../../../core/api/user/user_services.dart';
import '../../../core/model/dto_user.dart';
import '../../../core/providers/authentication_provider.dart';
import '../../../core/utils/navigate_utils.dart';
import '../../../core/utils/shared_preferences.dart';
import '../../bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../family_selection/family_selection_view.dart';
part 'splash_view_model.g.dart';

class SplashViewModel = SplashViewModelBase with _$SplashViewModel;

abstract class SplashViewModelBase with Store {
  Future<int> checkVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;

    return VersionServices.checkVersion(version);
  }

  Future isAuthenticate(BuildContext context) async {
    String? email = await SharedManager.instance.getStringValue("email");
    String? token = await SharedManager.instance.getStringValue("token");

    if (token != null) {
      Api.instance!.setToken(token);
      if (email != null) {
        DTOUser request = DTOUser(email: email);

        DTOUser? response = await AuthenticationServices.isAuthentication(request);

        if (response != null) {
          Provider.of<AuthenticationProvider>(context, listen: false).setUser(response);

          if (response.family_id == null) {
            NavigateUtils.pushAndRemoveUntil(context, page: const FamilySelectionView());
            return;
          } else {
            await UserServices.saveTokenToDatabase();

            NavigateUtils.pushAndRemoveUntil(context, page: const CustomBottomNavBar());
            return;
          }
        }
      }
    }

    NavigateUtils.pushAndRemoveUntil(context, page: LoginView());
  }
}
