// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borsa_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BorsaViewModel on BorsaViewModelBase, Store {
  late final _$borsasAtom =
      Atom(name: 'BorsaViewModelBase.borsas', context: context);

  @override
  List<DTOBucket> get borsas {
    _$borsasAtom.reportRead();
    return super.borsas;
  }

  @override
  set borsas(List<DTOBucket> value) {
    _$borsasAtom.reportWrite(value, super.borsas, () {
      super.borsas = value;
    });
  }

  late final _$totalValueAtom =
      Atom(name: 'BorsaViewModelBase.totalValue', context: context);

  @override
  double get totalValue {
    _$totalValueAtom.reportRead();
    return super.totalValue;
  }

  @override
  set totalValue(double value) {
    _$totalValueAtom.reportWrite(value, super.totalValue, () {
      super.totalValue = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'BorsaViewModelBase.isLoading', context: context);

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

  late final _$getHisseAsyncAction =
      AsyncAction('BorsaViewModelBase.getHisse', context: context);

  @override
  Future<dynamic> getHisse() {
    return _$getHisseAsyncAction.run(() => super.getHisse());
  }

  late final _$BorsaViewModelBaseActionController =
      ActionController(name: 'BorsaViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$BorsaViewModelBaseActionController.startAction(
        name: 'BorsaViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$BorsaViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
borsas: ${borsas},
totalValue: ${totalValue},
isLoading: ${isLoading}
    ''';
  }
}
