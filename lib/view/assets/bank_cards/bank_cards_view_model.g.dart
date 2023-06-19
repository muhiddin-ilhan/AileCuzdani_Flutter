// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_cards_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BankCardsViewModel on BankCardsViewModelBase, Store {
  late final _$bucketsAtom =
      Atom(name: 'BankCardsViewModelBase.buckets', context: context);

  @override
  List<DTOBucket> get buckets {
    _$bucketsAtom.reportRead();
    return super.buckets;
  }

  @override
  set buckets(List<DTOBucket> value) {
    _$bucketsAtom.reportWrite(value, super.buckets, () {
      super.buckets = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'BankCardsViewModelBase.isLoading', context: context);

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

  late final _$getBankAccountsAsyncAction =
      AsyncAction('BankCardsViewModelBase.getBankAccounts', context: context);

  @override
  Future<dynamic> getBankAccounts() {
    return _$getBankAccountsAsyncAction.run(() => super.getBankAccounts());
  }

  late final _$BankCardsViewModelBaseActionController =
      ActionController(name: 'BankCardsViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$BankCardsViewModelBaseActionController.startAction(
        name: 'BankCardsViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$BankCardsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
buckets: ${buckets},
isLoading: ${isLoading}
    ''';
  }
}
