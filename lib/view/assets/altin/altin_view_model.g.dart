// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'altin_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AltinViewModel on AltinViewModelBase, Store {
  late final _$goldsAtom =
      Atom(name: 'AltinViewModelBase.golds', context: context);

  @override
  List<DTOBucket> get golds {
    _$goldsAtom.reportRead();
    return super.golds;
  }

  @override
  set golds(List<DTOBucket> value) {
    _$goldsAtom.reportWrite(value, super.golds, () {
      super.golds = value;
    });
  }

  late final _$goldTotalValueAtom =
      Atom(name: 'AltinViewModelBase.goldTotalValue', context: context);

  @override
  double get goldTotalValue {
    _$goldTotalValueAtom.reportRead();
    return super.goldTotalValue;
  }

  @override
  set goldTotalValue(double value) {
    _$goldTotalValueAtom.reportWrite(value, super.goldTotalValue, () {
      super.goldTotalValue = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AltinViewModelBase.isLoading', context: context);

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

  late final _$getGoldsAsyncAction =
      AsyncAction('AltinViewModelBase.getGolds', context: context);

  @override
  Future<dynamic> getGolds() {
    return _$getGoldsAsyncAction.run(() => super.getGolds());
  }

  late final _$AltinViewModelBaseActionController =
      ActionController(name: 'AltinViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$AltinViewModelBaseActionController.startAction(
        name: 'AltinViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$AltinViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
golds: ${golds},
goldTotalValue: ${goldTotalValue},
isLoading: ${isLoading}
    ''';
  }
}
