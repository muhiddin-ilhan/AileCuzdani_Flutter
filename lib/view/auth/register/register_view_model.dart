// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/api/authentication/authentication_services.dart';
import '../../../core/api/user/user_services.dart';
import '../../../core/model/dto_user.dart';
import '../../../core/providers/authentication_provider.dart';
import '../../../core/utils/navigate_utils.dart';
import '../../bottom_navigation_bar/bottom_navigation_bar.dart';
import '../../family_selection/family_selection_view.dart';
part 'register_view_model.g.dart';

class RegisterViewModel = RegisterViewModelBase with _$RegisterViewModel;

abstract class RegisterViewModelBase with Store {
  @observable
  bool loading = false;
  @observable
  bool showPassword = true;
  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  TextEditingController nameController = TextEditingController();
  @observable
  TextEditingController surnameController = TextEditingController();
  @observable
  String? nameError = "";
  @observable
  String? surnameError = "";
  @observable
  String? emailError = "";
  @observable
  String? passwordError = "";

  @action
  void setNameError(bool value) {
    nameError = value ? "" : null;
    nameController = nameController;
  }

  @action
  void setSurnameError(bool value) {
    surnameError = value ? "" : null;
    surnameController = surnameController;
  }

  @action
  void setEmailError(bool value) {
    emailError = value ? "" : null;
    emailController = emailController;
  }

  @action
  void setPasswordError(bool value) {
    passwordError = value ? "" : null;
    passwordController = passwordController;
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
  Future register(BuildContext context) async {
    setLoading(true);

    DTOUser request = DTOUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      surname: surnameController.text,
      phone_number: "05554443322",
    );

    DTOUser? response = await AuthenticationServices.register(request);

    if (response != null) {
      Provider.of<AuthenticationProvider>(context, listen: false).setUser(response);

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
