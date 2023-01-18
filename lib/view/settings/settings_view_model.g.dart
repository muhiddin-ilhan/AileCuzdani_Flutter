// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsViewModel on SettingsViewModelBase, Store {
  late final _$versionAtom =
      Atom(name: 'SettingsViewModelBase.version', context: context);

  @override
  String get version {
    _$versionAtom.reportRead();
    return super.version;
  }

  @override
  set version(String value) {
    _$versionAtom.reportWrite(value, super.version, () {
      super.version = value;
    });
  }

  late final _$getVersionAsyncAction =
      AsyncAction('SettingsViewModelBase.getVersion', context: context);

  @override
  Future<dynamic> getVersion() {
    return _$getVersionAsyncAction.run(() => super.getVersion());
  }

  @override
  String toString() {
    return '''
version: ${version}
    ''';
  }
}
