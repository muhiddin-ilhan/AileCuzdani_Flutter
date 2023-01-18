// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on ProfileViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ProfileViewModelBase.isLoading', context: context);

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

  late final _$userAtom =
      Atom(name: 'ProfileViewModelBase.user', context: context);

  @override
  DTOUser? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(DTOUser? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$editCurrentUserAsyncAction =
      AsyncAction('ProfileViewModelBase.editCurrentUser', context: context);

  @override
  Future<dynamic> editCurrentUser(BuildContext context,
      {required DTOUser paramUser}) {
    return _$editCurrentUserAsyncAction
        .run(() => super.editCurrentUser(context, paramUser: paramUser));
  }

  late final _$getCurrentUserAsyncAction =
      AsyncAction('ProfileViewModelBase.getCurrentUser', context: context);

  @override
  Future<dynamic> getCurrentUser(BuildContext context) {
    return _$getCurrentUserAsyncAction.run(() => super.getCurrentUser(context));
  }

  late final _$ProfileViewModelBaseActionController =
      ActionController(name: 'ProfileViewModelBase', context: context);

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$ProfileViewModelBaseActionController.startAction(
        name: 'ProfileViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
user: ${user}
    ''';
  }
}
