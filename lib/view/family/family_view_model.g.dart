// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FamilyViewModel on FamilyViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'FamilyViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$familyAtom =
      Atom(name: 'FamilyViewModelBase.family', context: context);

  @override
  DTOFamily? get family {
    _$familyAtom.reportRead();
    return super.family;
  }

  @override
  set family(DTOFamily? value) {
    _$familyAtom.reportWrite(value, super.family, () {
      super.family = value;
    });
  }

  late final _$familyRequestsAtom =
      Atom(name: 'FamilyViewModelBase.familyRequests', context: context);

  @override
  List<DTOFamilyRequest> get familyRequests {
    _$familyRequestsAtom.reportRead();
    return super.familyRequests;
  }

  @override
  set familyRequests(List<DTOFamilyRequest> value) {
    _$familyRequestsAtom.reportWrite(value, super.familyRequests, () {
      super.familyRequests = value;
    });
  }

  late final _$getFamilyInfosAsyncAction =
      AsyncAction('FamilyViewModelBase.getFamilyInfos', context: context);

  @override
  Future<dynamic> getFamilyInfos(BuildContext context) {
    return _$getFamilyInfosAsyncAction.run(() => super.getFamilyInfos(context));
  }

  late final _$answerFamilyRequestAsyncAction =
      AsyncAction('FamilyViewModelBase.answerFamilyRequest', context: context);

  @override
  Future<dynamic> answerFamilyRequest(BuildContext context,
      {required bool isAccept, required DTOFamilyRequest familyRequest}) {
    return _$answerFamilyRequestAsyncAction.run(() => super.answerFamilyRequest(
        context,
        isAccept: isAccept,
        familyRequest: familyRequest));
  }

  late final _$removeFamilyMemberAsyncAction =
      AsyncAction('FamilyViewModelBase.removeFamilyMember', context: context);

  @override
  Future<dynamic> removeFamilyMember(BuildContext context,
      {required DTOUser user}) {
    return _$removeFamilyMemberAsyncAction
        .run(() => super.removeFamilyMember(context, user: user));
  }

  late final _$FamilyViewModelBaseActionController =
      ActionController(name: 'FamilyViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$FamilyViewModelBaseActionController.startAction(
        name: 'FamilyViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$FamilyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$FamilyViewModelBaseActionController.startAction(
        name: 'FamilyViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$FamilyViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
family: ${family},
familyRequests: ${familyRequests}
    ''';
  }
}
