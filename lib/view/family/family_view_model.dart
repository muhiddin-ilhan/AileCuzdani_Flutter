// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../core/api/family/family_services.dart';
import '../../core/model/dto_family.dart';
import '../../core/model/dto_family_request.dart';
import '../../core/model/dto_user.dart';
import '../../core/providers/authentication_provider.dart';
import '../../core/utils/loading_utils.dart';
import '../../core/utils/navigate_utils.dart';
part 'family_view_model.g.dart';

class FamilyViewModel = FamilyViewModelBase with _$FamilyViewModel;

abstract class FamilyViewModelBase with Store {
  @observable
  bool isLoading = false;

  @observable
  DTOFamily? family;

  @observable
  List<DTOFamilyRequest> familyRequests = [];

  @action
  Future getFamilyInfos(BuildContext context) async {
    family = null;
    familyRequests = [];
    setLoading(true);

    DTOFamily? response = await FamilyServices.getFamilyAndUsers();

    if (response != null) {
      family = response;
    }

    List<DTOFamilyRequest>? response2 = await FamilyServices.getFamilyRequest(isMine: false);

    if (response2 != null) {
      familyRequests = response2;
    }

    setLoading(false);
  }

  @action
  Future answerFamilyRequest(BuildContext context, {required bool isAccept, required DTOFamilyRequest familyRequest}) async {
    setLoading(true);

    bool response = await FamilyServices.answerFamilyRequest(requestId: familyRequest.id!, isAccept: isAccept);

    if (response) {
      await getFamilyInfos(context);
    }

    setLoading(false);
  }

  @action
  Future removeFamilyMember(BuildContext context, {required DTOUser user}) async {
    setLoading(true);

    bool response = await FamilyServices.removeUserFromFamily(userId: user.id!, familyId: user.family_id!);

    if (response) {
      if (Provider.of<AuthenticationProvider>(context, listen: false).user!.id == user.id) {
        NavigateUtils.goFamilySelectionPage(context);
        return;
      }
      await getFamilyInfos(context);
    }

    setLoading(false);
  }

  @action
  setLoading(bool val) {
    isLoading = val;
    LoadingUtils.instance.loading(val);
  }

  @action
  reset() {
    isLoading = false;
    family = null;
    familyRequests = [];
  }
}
