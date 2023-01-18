// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginViewModel on LoginViewModelBase, Store {
  late final _$loadingAtom =
      Atom(name: 'LoginViewModelBase.loading', context: context);

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

  late final _$showPasswordAtom =
      Atom(name: 'LoginViewModelBase.showPassword', context: context);

  @override
  bool get showPassword {
    _$showPasswordAtom.reportRead();
    return super.showPassword;
  }

  @override
  set showPassword(bool value) {
    _$showPasswordAtom.reportWrite(value, super.showPassword, () {
      super.showPassword = value;
    });
  }

  late final _$emailErrorAtom =
      Atom(name: 'LoginViewModelBase.emailError', context: context);

  @override
  String? get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String? value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  late final _$passwordErrorAtom =
      Atom(name: 'LoginViewModelBase.passwordError', context: context);

  @override
  String? get passwordError {
    _$passwordErrorAtom.reportRead();
    return super.passwordError;
  }

  @override
  set passwordError(String? value) {
    _$passwordErrorAtom.reportWrite(value, super.passwordError, () {
      super.passwordError = value;
    });
  }

  late final _$emailControllerAtom =
      Atom(name: 'LoginViewModelBase.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$passwordControllerAtom =
      Atom(name: 'LoginViewModelBase.passwordController', context: context);

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  late final _$setSharedUserInfosAsyncAction =
      AsyncAction('LoginViewModelBase.setSharedUserInfos', context: context);

  @override
  Future<dynamic> setSharedUserInfos() {
    return _$setSharedUserInfosAsyncAction
        .run(() => super.setSharedUserInfos());
  }

  late final _$getSharedUserInfosAsyncAction =
      AsyncAction('LoginViewModelBase.getSharedUserInfos', context: context);

  @override
  Future<dynamic> getSharedUserInfos() {
    return _$getSharedUserInfosAsyncAction
        .run(() => super.getSharedUserInfos());
  }

  late final _$loginAsyncAction =
      AsyncAction('LoginViewModelBase.login', context: context);

  @override
  Future<dynamic> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  late final _$LoginViewModelBaseActionController =
      ActionController(name: 'LoginViewModelBase', context: context);

  @override
  void setPasswordError(bool value) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.setPasswordError');
    try {
      return super.setPasswordError(value);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmailError(bool value) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.setEmailError');
    try {
      return super.setEmailError(value);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$LoginViewModelBaseActionController.startAction(
        name: 'LoginViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
showPassword: ${showPassword},
emailError: ${emailError},
passwordError: ${passwordError},
emailController: ${emailController},
passwordController: ${passwordController}
    ''';
  }
}
