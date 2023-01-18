// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/user/user_services.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  DTOUser? _user;
  DTOUser? get user => _user;

  Future editCurrentUser(BuildContext context, {required DTOUser user}) async {
    _user = null;
    setLoading(true);

    bool response = await UserServices.editCurrentUser(request: user);

    if (response) {
      await getCurrentUser(context);
    }

    setLoading(false);
  }

  Future getCurrentUser(BuildContext context) async {
    _user = null;
    setLoading(true);

    await UserServices.getCurrentUser(context);

    setLoading(false);
  }

  void setUser(DTOUser user) {
    _user = user;
    notifyListeners();
  }

  void removeFamily() {
    _user!.family = null;
    _user!.family_id = null;
    notifyListeners();
  }

  void reset() {
    _user = null;
    notifyListeners();
  }

  void setLoading(bool val) {
    _isLoading = val;
    LoadingUtils.instance.loading(val);
    notifyListeners();
  }
}
