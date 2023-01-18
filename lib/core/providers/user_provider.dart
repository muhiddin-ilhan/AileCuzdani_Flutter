// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/core/api/family/family_services.dart';
import 'package:aile_cuzdani/core/model/dto_family.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<DTOUser> _users = [];
  List<DTOUser> get users => _users;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future getUsers(BuildContext context) async {
    _users = [];
    setLoading(true);

    DTOFamily? response = await FamilyServices.getFamilyAndUsers();

    if (response != null) {
      _users = response.users ?? [];
    }

    setLoading(false);
  }

  reset() {
    _isLoading = false;
    _users = [];
    notifyListeners();
  }

  setLoading(bool value) {
    _isLoading = value;
    LoadingUtils.instance.loading(value);
    notifyListeners();
  }
}
