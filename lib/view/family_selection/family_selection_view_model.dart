// ignore_for_file: use_build_context_synchronously

import 'package:aile_cuzdani/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:mobx/mobx.dart';
import 'package:aile_cuzdani/core/api/family/family_services.dart';
import 'package:aile_cuzdani/core/api/user/user_services.dart';
import 'package:aile_cuzdani/core/components/popups/message_popup.dart';
import 'package:aile_cuzdani/core/model/dto_family.dart';
import 'package:aile_cuzdani/core/model/dto_family_request.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:aile_cuzdani/core/utils/loading_utils.dart';
import 'package:aile_cuzdani/core/utils/navigate_utils.dart';
import 'package:flutter/material.dart';

part 'family_selection_view_model.g.dart';

class FamilySelectionViewModel = FamilySelectionViewModelBase with _$FamilySelectionViewModel;

abstract class FamilySelectionViewModelBase with Store {
  @observable
  bool loading = true;

  @observable
  DTOUser? currentUser;

  @observable
  bool isError = false;

  @observable
  List<DTOFamily> families = [];

  @observable
  List<DTOFamily> searchedFamilies = [];

  @observable
  List<DTOFamilyRequest> familyRequest = [];

  @observable
  List<DTOFamily> familyRequestFamily = [];

  @observable
  TextEditingController searchController = TextEditingController();

  @observable
  TextEditingController familyNameController = TextEditingController();

  @action
  void setLoading(bool val) {
    loading = val;
    LoadingUtils.instance.loading(val);
  }

  @action
  reset() {
    currentUser = null;
    families = [];
    isError = false;
    searchedFamilies = [];
    familyRequest = [];
    familyRequestFamily = [];
    searchController.clear();
    familyNameController.clear();
    loading = false;
  }

  @action
  void searchFamily(String title) {
    searchedFamilies = families.where((element) => element.title!.toLowerCase().contains(title.toLowerCase())).toList();
  }

  @action
  Future<bool> getUserInfo(BuildContext context) async {
    currentUser = await UserServices.getCurrentUser(context);

    if (currentUser == null) {
      isError = true;
      return false;
    }

    if (isHasFamily()) {
      NavigateUtils.pushAndRemoveUntil(context, page: const CustomBottomNavBar());
      return false;
    }

    return true;
  }

  @action
  bool isHasFamily() {
    return currentUser != null ? currentUser!.family_id != null : false;
  }

  @action
  Future getAllFamilies(BuildContext context) async {
    reset();
    setLoading(true);

    if (!(await getUserInfo(context))) {
      setLoading(false);
      return;
    }

    List<DTOFamily>? response = await FamilyServices.getAllFamily();

    setLoading(false);

    if (response != null) {
      families = response;
      searchedFamilies = response;

      getFamilyRequest(context);
      return;
    }

    isError = true;
  }

  @action
  Future getFamilyRequest(BuildContext context) async {
    setLoading(true);

    List<DTOFamilyRequest>? response = await FamilyServices.getFamilyRequest(isMine: true);

    if (response != null) {
      familyRequest = response;
      familyRequestFamily = families.where((element) {
        for (DTOFamilyRequest e in familyRequest) {
          if (element.id == e.family_id) return true;
        }
        return false;
      }).toList();
      setLoading(false);
      return;
    }

    isError = true;
    setLoading(false);
  }

  Future cancelFamilyRequest(BuildContext context, {required DTOFamily family}) async {
    setLoading(true);

    bool response = await FamilyServices.cancelFamilyRequest(familyId: family.id!);

    setLoading(false);

    if (response) {
      getAllFamilies(context);
    }
  }

  @action
  Future leaveFamily(BuildContext context, {required DTOFamily family}) async {
    setLoading(true);

    bool response = await FamilyServices.removeUserFromFamily(userId: currentUser!.id!, familyId: family.id!);

    setLoading(false);

    if (response) {
      getAllFamilies(context);
    }
  }

  @action
  Future sendFamilyRequest(BuildContext context, {required DTOFamily family}) async {
    setLoading(true);

    bool response = await FamilyServices.sendFamilyRequest(familyId: family.id!);

    setLoading(false);

    if (response) {
      await getAllFamilies(context);
      showMessagePopup(
        context,
        message: "Aileye Katılım İsteğiniz Gönderildi. Aile Üyeleri İsteğinizi Kabul Ettiği Zaman Uygulamaya Giriş Yapabileceksiniz",
        title: "Başarılı",
      );
    }
  }

  @action
  Future createFamily(BuildContext context) async {
    setLoading(true);

    bool response = await FamilyServices.createFamily(title: familyNameController.text);

    setLoading(false);

    if (response) {
      getAllFamilies(context);
    }
  }
}
