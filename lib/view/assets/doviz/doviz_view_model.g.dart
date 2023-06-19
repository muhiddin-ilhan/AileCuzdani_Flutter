// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doviz_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DovizViewModel on DovizViewModelBase, Store {
  late final _$currenciesAtom =
      Atom(name: 'DovizViewModelBase.currencies', context: context);

  @override
  List<DTOBucket> get currencies {
    _$currenciesAtom.reportRead();
    return super.currencies;
  }

  @override
  set currencies(List<DTOBucket> value) {
    _$currenciesAtom.reportWrite(value, super.currencies, () {
      super.currencies = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'DovizViewModelBase.isLoading', context: context);

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

  late final _$getCurrenciesAsyncAction =
      AsyncAction('DovizViewModelBase.getCurrencies', context: context);

  @override
  Future<dynamic> getCurrencies() {
    return _$getCurrenciesAsyncAction.run(() => super.getCurrencies());
  }

  late final _$DovizViewModelBaseActionController =
      ActionController(name: 'DovizViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$DovizViewModelBaseActionController.startAction(
        name: 'DovizViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$DovizViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currencies: ${currencies},
isLoading: ${isLoading}
    ''';
  }
}
