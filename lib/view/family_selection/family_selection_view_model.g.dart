// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_selection_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FamilySelectionViewModel on FamilySelectionViewModelBase, Store {
  late final _$loadingAtom =
      Atom(name: 'FamilySelectionViewModelBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: 'FamilySelectionViewModelBase.currentUser', context: context);

  @override
  DTOUser? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(DTOUser? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isErrorAtom =
      Atom(name: 'FamilySelectionViewModelBase.isError', context: context);

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  late final _$familiesAtom =
      Atom(name: 'FamilySelectionViewModelBase.families', context: context);

  @override
  List<DTOFamily> get families {
    _$familiesAtom.reportRead();
    return super.families;
  }

  @override
  set families(List<DTOFamily> value) {
    _$familiesAtom.reportWrite(value, super.families, () {
      super.families = value;
    });
  }

  late final _$searchedFamiliesAtom = Atom(
      name: 'FamilySelectionViewModelBase.searchedFamilies', context: context);

  @override
  List<DTOFamily> get searchedFamilies {
    _$searchedFamiliesAtom.reportRead();
    return super.searchedFamilies;
  }

  @override
  set searchedFamilies(List<DTOFamily> value) {
    _$searchedFamiliesAtom.reportWrite(value, super.searchedFamilies, () {
      super.searchedFamilies = value;
    });
  }

  late final _$familyRequestAtom = Atom(
      name: 'FamilySelectionViewModelBase.familyRequest', context: context);

  @override
  List<DTOFamilyRequest> get familyRequest {
    _$familyRequestAtom.reportRead();
    return super.familyRequest;
  }

  @override
  set familyRequest(List<DTOFamilyRequest> value) {
    _$familyRequestAtom.reportWrite(value, super.familyRequest, () {
      super.familyRequest = value;
    });
  }

  late final _$familyRequestFamilyAtom = Atom(
      name: 'FamilySelectionViewModelBase.familyRequestFamily',
      context: context);

  @override
  List<DTOFamily> get familyRequestFamily {
    _$familyRequestFamilyAtom.reportRead();
    return super.familyRequestFamily;
  }

  @override
  set familyRequestFamily(List<DTOFamily> value) {
    _$familyRequestFamilyAtom.reportWrite(value, super.familyRequestFamily, () {
      super.familyRequestFamily = value;
    });
  }

  late final _$searchControllerAtom = Atom(
      name: 'FamilySelectionViewModelBase.searchController', context: context);

  @override
  TextEditingController get searchController {
    _$searchControllerAtom.reportRead();
    return super.searchController;
  }

  @override
  set searchController(TextEditingController value) {
    _$searchControllerAtom.reportWrite(value, super.searchController, () {
      super.searchController = value;
    });
  }

  late final _$familyNameControllerAtom = Atom(
      name: 'FamilySelectionViewModelBase.familyNameController',
      context: context);

  @override
  TextEditingController get familyNameController {
    _$familyNameControllerAtom.reportRead();
    return super.familyNameController;
  }

  @override
  set familyNameController(TextEditingController value) {
    _$familyNameControllerAtom.reportWrite(value, super.familyNameController,
        () {
      super.familyNameController = value;
    });
  }

  late final _$getUserInfoAsyncAction =
      AsyncAction('FamilySelectionViewModelBase.getUserInfo', context: context);

  @override
  Future<bool> getUserInfo(BuildContext context) {
    return _$getUserInfoAsyncAction.run(() => super.getUserInfo(context));
  }

  late final _$getAllFamiliesAsyncAction = AsyncAction(
      'FamilySelectionViewModelBase.getAllFamilies',
      context: context);

  @override
  Future<dynamic> getAllFamilies(BuildContext context) {
    return _$getAllFamiliesAsyncAction.run(() => super.getAllFamilies(context));
  }

  late final _$getFamilyRequestAsyncAction = AsyncAction(
      'FamilySelectionViewModelBase.getFamilyRequest',
      context: context);

  @override
  Future<dynamic> getFamilyRequest(BuildContext context) {
    return _$getFamilyRequestAsyncAction
        .run(() => super.getFamilyRequest(context));
  }

  late final _$leaveFamilyAsyncAction =
      AsyncAction('FamilySelectionViewModelBase.leaveFamily', context: context);

  @override
  Future<dynamic> leaveFamily(BuildContext context,
      {required DTOFamily family}) {
    return _$leaveFamilyAsyncAction
        .run(() => super.leaveFamily(context, family: family));
  }

  late final _$sendFamilyRequestAsyncAction = AsyncAction(
      'FamilySelectionViewModelBase.sendFamilyRequest',
      context: context);

  @override
  Future<dynamic> sendFamilyRequest(BuildContext context,
      {required DTOFamily family}) {
    return _$sendFamilyRequestAsyncAction
        .run(() => super.sendFamilyRequest(context, family: family));
  }

  late final _$createFamilyAsyncAction = AsyncAction(
      'FamilySelectionViewModelBase.createFamily',
      context: context);

  @override
  Future<dynamic> createFamily(BuildContext context) {
    return _$createFamilyAsyncAction.run(() => super.createFamily(context));
  }

  late final _$FamilySelectionViewModelBaseActionController =
      ActionController(name: 'FamilySelectionViewModelBase', context: context);

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$FamilySelectionViewModelBaseActionController
        .startAction(name: 'FamilySelectionViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$FamilySelectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$FamilySelectionViewModelBaseActionController
        .startAction(name: 'FamilySelectionViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$FamilySelectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchFamily(String title) {
    final _$actionInfo = _$FamilySelectionViewModelBaseActionController
        .startAction(name: 'FamilySelectionViewModelBase.searchFamily');
    try {
      return super.searchFamily(title);
    } finally {
      _$FamilySelectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool isHasFamily() {
    final _$actionInfo = _$FamilySelectionViewModelBaseActionController
        .startAction(name: 'FamilySelectionViewModelBase.isHasFamily');
    try {
      return super.isHasFamily();
    } finally {
      _$FamilySelectionViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
currentUser: ${currentUser},
isError: ${isError},
families: ${families},
searchedFamilies: ${searchedFamilies},
familyRequest: ${familyRequest},
familyRequestFamily: ${familyRequestFamily},
searchController: ${searchController},
familyNameController: ${familyNameController}
    ''';
  }
}
