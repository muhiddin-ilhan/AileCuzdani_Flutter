// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/api/user/user_services.dart';
import '../../core/model/dto_user.dart';
import '../../core/utils/loading_utils.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = ProfileViewModelBase with _$ProfileViewModel;

abstract class ProfileViewModelBase with Store {
  @observable
  bool isLoading = false;
  @observable
  DTOUser? user;

  @action
  Future editCurrentUser(BuildContext context, {required DTOUser paramUser}) async {
    user = null;
    setLoading(true);

    bool response = await UserServices.editCurrentUser(request: paramUser);

    if (response) {
      await getCurrentUser(context);
    }

    setLoading(false);
  }

  @action
  Future getCurrentUser(BuildContext context) async {
    user = null;
    setLoading(true);

    DTOUser? response = await UserServices.getCurrentUser(context);

    if (response != null) {
      user = response;
    }

    setLoading(false);
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }
}
