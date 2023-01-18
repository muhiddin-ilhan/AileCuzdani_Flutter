// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/api/authentication/authentication_services.dart';
import '../../../core/utils/navigate_utils.dart';
import '../login/login_view.dart';
part 'reset_password_view_model.g.dart';

class ResetPasswordViewModel = ResetPasswordViewModelBase with _$ResetPasswordViewModel;

abstract class ResetPasswordViewModelBase with Store {
  @observable
  bool loading = false;
  @observable
  bool showPassword = true;
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  TextEditingController passwordConfirmController = TextEditingController();
  @observable
  String? passwordError = "";
  @observable
  String? passwordConfirmError = "";

  @action
  void setPasswordError(bool value) {
    passwordError = value ? "" : null;
    passwordController = passwordController;
  }

  @action
  void setPasswordConfirmError(bool value) {
    passwordConfirmError = value ? "" : null;
    passwordConfirmController = passwordConfirmController;
  }

  @action
  void setLoading(bool val) {
    loading = val;
  }

  @action
  void toggleShowPassword() {
    showPassword = !showPassword;
  }

  @action
  Future resetPassword(BuildContext context, {required String resetToken}) async {
    setLoading(true);

    bool response = await AuthenticationServices.resetPassword(
      password: passwordController.text,
      newPassword: passwordConfirmController.text,
      resetToken: resetToken,
    );

    if (response) {
      NavigateUtils.pushAndRemoveUntil(context, page: LoginView());
    }

    setLoading(false);
  }
}
