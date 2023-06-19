// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CryptoViewModel on CryptoViewModelBase, Store {
  late final _$cryptoAtom =
      Atom(name: 'CryptoViewModelBase.crypto', context: context);

  @override
  List<DTOBucket> get crypto {
    _$cryptoAtom.reportRead();
    return super.crypto;
  }

  @override
  set crypto(List<DTOBucket> value) {
    _$cryptoAtom.reportWrite(value, super.crypto, () {
      super.crypto = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CryptoViewModelBase.isLoading', context: context);

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

  late final _$getCoinsAsyncAction =
      AsyncAction('CryptoViewModelBase.getCoins', context: context);

  @override
  Future<dynamic> getCoins() {
    return _$getCoinsAsyncAction.run(() => super.getCoins());
  }

  late final _$CryptoViewModelBaseActionController =
      ActionController(name: 'CryptoViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$CryptoViewModelBaseActionController.startAction(
        name: 'CryptoViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$CryptoViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
crypto: ${crypto},
isLoading: ${isLoading}
    ''';
  }
}
