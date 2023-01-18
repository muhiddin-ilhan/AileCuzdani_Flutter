// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterViewModel on RegisterViewModelBase, Store {
  late final _$loadingAtom =
      Atom(name: 'RegisterViewModelBase.loading', context: context);

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
      Atom(name: 'RegisterViewModelBase.showPassword', context: context);

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

  late final _$emailControllerAtom =
      Atom(name: 'RegisterViewModelBase.emailController', context: context);

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
      Atom(name: 'RegisterViewModelBase.passwordController', context: context);

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

  late final _$nameControllerAtom =
      Atom(name: 'RegisterViewModelBase.nameController', context: context);

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  late final _$surnameControllerAtom =
      Atom(name: 'RegisterViewModelBase.surnameController', context: context);

  @override
  TextEditingController get surnameController {
    _$surnameControllerAtom.reportRead();
    return super.surnameController;
  }

  @override
  set surnameController(TextEditingController value) {
    _$surnameControllerAtom.reportWrite(value, super.surnameController, () {
      super.surnameController = value;
    });
  }

  late final _$nameErrorAtom =
      Atom(name: 'RegisterViewModelBase.nameError', context: context);

  @override
  String? get nameError {
    _$nameErrorAtom.reportRead();
    return super.nameError;
  }

  @override
  set nameError(String? value) {
    _$nameErrorAtom.reportWrite(value, super.nameError, () {
      super.nameError = value;
    });
  }

  late final _$surnameErrorAtom =
      Atom(name: 'RegisterViewModelBase.surnameError', context: context);

  @override
  String? get surnameError {
    _$surnameErrorAtom.reportRead();
    return super.surnameError;
  }

  @override
  set surnameError(String? value) {
    _$surnameErrorAtom.reportWrite(value, super.surnameError, () {
      super.surnameError = value;
    });
  }

  late final _$emailErrorAtom =
      Atom(name: 'RegisterViewModelBase.emailError', context: context);

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
      Atom(name: 'RegisterViewModelBase.passwordError', context: context);

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

  late final _$registerAsyncAction =
      AsyncAction('RegisterViewModelBase.register', context: context);

  @override
  Future<dynamic> register(BuildContext context) {
    return _$registerAsyncAction.run(() => super.register(context));
  }

  late final _$RegisterViewModelBaseActionController =
      ActionController(name: 'RegisterViewModelBase', context: context);

  @override
  void setNameError(bool value) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.setNameError');
    try {
      return super.setNameError(value);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSurnameError(bool value) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.setSurnameError');
    try {
      return super.setSurnameError(value);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmailError(bool value) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.setEmailError');
    try {
      return super.setEmailError(value);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordError(bool value) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.setPasswordError');
    try {
      return super.setPasswordError(value);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleShowPassword() {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.toggleShowPassword');
    try {
      return super.toggleShowPassword();
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo = _$RegisterViewModelBaseActionController.startAction(
        name: 'RegisterViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$RegisterViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
showPassword: ${showPassword},
emailController: ${emailController},
passwordController: ${passwordController},
nameController: ${nameController},
surnameController: ${surnameController},
nameError: ${nameError},
surnameError: ${surnameError},
emailError: ${emailError},
passwordError: ${passwordError}
    ''';
  }
}
