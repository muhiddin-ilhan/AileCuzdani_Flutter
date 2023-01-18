// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/api/authentication/authentication_services.dart';
import '../../../core/api/user/user_services.dart';
import '../../../core/model/dto_user.dart';
import '../../../core/providers/authentication_provider.dart';
import '../../../core/utils/navigate_utils.dart';
import '../../../core/utils/shared_preferences.dart';
import '../../bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../family_selection/family_selection_view.dart';
part 'login_view_model.g.dart';

class LoginViewModel = LoginViewModelBase with _$LoginViewModel;

abstract class LoginViewModelBase with Store {
  @observable
  bool loading = false;
  @observable
  bool showPassword = true;
  @observable
  String? emailError = "";
  @observable
  String? passwordError = "";
  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();

  @action
  void setPasswordError(bool value) {
    passwordError = value ? "" : null;
    passwordController = passwordController;
  }

  @action
  void setEmailError(bool value) {
    emailError = value ? "" : null;
    emailController = emailController;
  }

  @action
  void toggleShowPassword() {
    showPassword = !showPassword;
  }

  @action
  void setLoading(bool val) {
    loading = val;
  }

  @action
  Future setSharedUserInfos() async {
    await SharedManager.instance.setStringValue("email", emailController.text);
  }

  @action
  Future getSharedUserInfos() async {
    emailController.text = await SharedManager.instance.getStringValue("email") ?? "";
  }

  @action
  Future login(BuildContext context) async {
    setLoading(true);

    DTOUser request = DTOUser(email: emailController.text, password: passwordController.text);

    DTOUser? response = await AuthenticationServices.login(request);

    if (response != null) {
      Provider.of<AuthenticationProvider>(context, listen: false).setUser(response);

      await setSharedUserInfos();

      if (response.family_id == null) {
        NavigateUtils.pushAndRemoveUntil(context, page: const FamilySelectionView());
      } else {
        await UserServices.saveTokenToDatabase();

        NavigateUtils.pushAndRemoveUntil(context, page: const CustomBottomNavBar());
      }
    }

    setLoading(false);
  }
}
