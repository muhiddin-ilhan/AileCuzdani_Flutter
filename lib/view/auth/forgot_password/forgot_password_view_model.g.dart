// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ForgotPasswordViewModel on ForgotPasswordViewModelBase, Store {
  late final _$loadingAtom =
      Atom(name: 'ForgotPasswordViewModelBase.loading', context: context);

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

  late final _$isValidationCodeShowAtom = Atom(
      name: 'ForgotPasswordViewModelBase.isValidationCodeShow',
      context: context);

  @override
  bool get isValidationCodeShow {
    _$isValidationCodeShowAtom.reportRead();
    return super.isValidationCodeShow;
  }

  @override
  set isValidationCodeShow(bool value) {
    _$isValidationCodeShowAtom.reportWrite(value, super.isValidationCodeShow,
        () {
      super.isValidationCodeShow = value;
    });
  }

  late final _$emailControllerAtom = Atom(
      name: 'ForgotPasswordViewModelBase.emailController', context: context);

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

  late final _$confirmCodeControllerAtom = Atom(
      name: 'ForgotPasswordViewModelBase.confirmCodeController',
      context: context);

  @override
  TextEditingController get confirmCodeController {
    _$confirmCodeControllerAtom.reportRead();
    return super.confirmCodeController;
  }

  @override
  set confirmCodeController(TextEditingController value) {
    _$confirmCodeControllerAtom.reportWrite(value, super.confirmCodeController,
        () {
      super.confirmCodeController = value;
    });
  }

  late final _$emailErrorAtom =
      Atom(name: 'ForgotPasswordViewModelBase.emailError', context: context);

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

  late final _$confirmErrorAtom =
      Atom(name: 'ForgotPasswordViewModelBase.confirmError', context: context);

  @override
  String? get confirmError {
    _$confirmErrorAtom.reportRead();
    return super.confirmError;
  }

  @override
  set confirmError(String? value) {
    _$confirmErrorAtom.reportWrite(value, super.confirmError, () {
      super.confirmError = value;
    });
  }

  late final _$sendEmailCodeAsyncAction = AsyncAction(
      'ForgotPasswordViewModelBase.sendEmailCode',
      context: context);

  @override
  Future<dynamic> sendEmailCode(BuildContext context) {
    return _$sendEmailCodeAsyncAction.run(() => super.sendEmailCode(context));
  }

  late final _$sendConfirmationCodeAsyncAction = AsyncAction(
      'ForgotPasswordViewModelBase.sendConfirmationCode',
      context: context);

  @override
  Future<dynamic> sendConfirmationCode(BuildContext context) {
    return _$sendConfirmationCodeAsyncAction
        .run(() => super.sendConfirmationCode(context));
  }

  late final _$ForgotPasswordViewModelBaseActionController =
      ActionController(name: 'ForgotPasswordViewModelBase', context: context);

  @override
  void setConfirmError(bool value) {
    final _$actionInfo = _$ForgotPasswordViewModelBaseActionController
        .startAction(name: 'ForgotPasswordViewModelBase.setConfirmError');
    try {
      return super.setConfirmError(value);
    } finally {
      _$ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmailError(bool value) {
    final _$actionInfo = _$ForgotPasswordViewModelBaseActionController
        .startAction(name: 'ForgotPasswordViewModelBase.setEmailError');
    try {
      return super.setEmailError(value);
    } finally {
      _$ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsValidationCodeShow(bool value) {
    final _$actionInfo =
        _$ForgotPasswordViewModelBaseActionController.startAction(
            name: 'ForgotPasswordViewModelBase.setIsValidationCodeShow');
    try {
      return super.setIsValidationCodeShow(value);
    } finally {
      _$ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$ForgotPasswordViewModelBaseActionController
        .startAction(name: 'ForgotPasswordViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$ForgotPasswordViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
isValidationCodeShow: ${isValidationCodeShow},
emailController: ${emailController},
confirmCodeController: ${confirmCodeController},
emailError: ${emailError},
confirmError: ${confirmError}
    ''';
  }
}
