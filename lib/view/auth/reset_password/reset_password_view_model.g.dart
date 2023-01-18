// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResetPasswordViewModel on ResetPasswordViewModelBase, Store {
  late final _$loadingAtom =
      Atom(name: 'ResetPasswordViewModelBase.loading', context: context);

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
      Atom(name: 'ResetPasswordViewModelBase.showPassword', context: context);

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

  late final _$passwordControllerAtom = Atom(
      name: 'ResetPasswordViewModelBase.passwordController', context: context);

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

  late final _$passwordConfirmControllerAtom = Atom(
      name: 'ResetPasswordViewModelBase.passwordConfirmController',
      context: context);

  @override
  TextEditingController get passwordConfirmController {
    _$passwordConfirmControllerAtom.reportRead();
    return super.passwordConfirmController;
  }

  @override
  set passwordConfirmController(TextEditingController value) {
    _$passwordConfirmControllerAtom
        .reportWrite(value, super.passwordConfirmController, () {
      super.passwordConfirmController = value;
    });
  }

  late final _$passwordErrorAtom =
      Atom(name: 'ResetPasswordViewModelBase.passwordError', context: context);

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

  late final _$passwordConfirmErrorAtom = Atom(
      name: 'ResetPasswordViewModelBase.passwordConfirmError',
      context: context);

  @override
  String? get passwordConfirmError {
    _$passwordConfirmErrorAtom.reportRead();
    return super.passwordConfirmError;
  }

  @override
  set passwordConfirmError(String? value) {
    _$passwordConfirmErrorAtom.reportWrite(value, super.passwordConfirmError,
        () {
      super.passwordConfirmError = value;
    });
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('ResetPasswordViewModelBase.resetPassword', context: context);

  @override
  Future<dynamic> resetPassword(BuildContext context,
      {required String resetToken}) {
    return _$resetPasswordAsyncAction
        .run(() => super.resetPassword(context, resetToken: resetToken));
  }

  late final _$ResetPasswordViewModelBaseActionController =
      ActionController(name: 'ResetPasswordViewModelBase', context: context);

  @override
  void setPasswordError(bool value) {
    final _$actionInfo = _$ResetPasswordViewModelBaseActionController
        .startAction(name: 'ResetPasswordViewModelBase.setPasswordError');
    try {
      return super.setPasswordError(value);
    } finally {
      _$ResetPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordConfirmError(bool value) {
    final _$actionInfo =
        _$ResetPasswordViewModelBaseActionController.startAction(
            name: 'ResetPasswordViewModelBase.setPasswordConfirmError');
    try {
      return super.setPasswordConfirmError(value);
    } finally {
      _$ResetPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$ResetPasswordViewModelBaseActionController
        .startAction(name: 'ResetPasswordViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$ResetPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$ResetPasswordViewModelBaseActionController
        .startAction(name: 'ResetPasswordViewModelBase.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$ResetPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
showPassword: ${showPassword},
passwordController: ${passwordController},
passwordConfirmController: ${passwordConfirmController},
passwordError: ${passwordError},
passwordConfirmError: ${passwordConfirmError}
    ''';
  }
}
