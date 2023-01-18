// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/api/authentication/authentication_services.dart';
import '../../../core/model/dto_user.dart';
import '../../../core/utils/navigate_utils.dart';
import '../reset_password/reset_password_page.dart';
part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = ForgotPasswordViewModelBase with _$ForgotPasswordViewModel;

abstract class ForgotPasswordViewModelBase with Store {
  @observable
  bool loading = false;
  @observable
  bool isValidationCodeShow = false;
  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController confirmCodeController = TextEditingController();
  @observable
  String? emailError = "";
  @observable
  String? confirmError = "";

  @action
  void setConfirmError(bool value) {
    confirmError = value ? "" : null;
    confirmCodeController = confirmCodeController;
  }

  @action
  void setEmailError(bool value) {
    emailError = value ? "" : null;
    emailController = emailController;
  }

  @action
  void setIsValidationCodeShow(bool value) {
    isValidationCodeShow = value;
  }

  @action
  void setLoading(bool val) {
    loading = val;
  }

  @action
  Future sendEmailCode(BuildContext context) async {
    setLoading(true);

    DTOUser request = DTOUser(email: emailController.text);

    bool response = await AuthenticationServices.forgotPassword(request);

    if (response) {
      setIsValidationCodeShow(true);
    }

    setLoading(false);
  }

  @action
  Future sendConfirmationCode(BuildContext context) async {
    setLoading(true);

    bool response = await AuthenticationServices.validateResetKey(resetKey: confirmCodeController.text);

    if (response) {
      NavigateUtils.pushAndRemoveUntil(context, page: ResetPasswordPage(resetKey: confirmCodeController.text));
    }

    setLoading(false);
  }
}
