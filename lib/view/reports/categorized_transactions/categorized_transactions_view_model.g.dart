// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorized_transactions_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategorizedTransactionsViewModel
    on CategorizedTransactionsViewModelBase, Store {
  late final _$transactionsAtom = Atom(
      name: 'CategorizedTransactionsViewModelBase.transactions',
      context: context);

  @override
  List<DTOTransaction> get transactions {
    _$transactionsAtom.reportRead();
    return super.transactions;
  }

  @override
  set transactions(List<DTOTransaction> value) {
    _$transactionsAtom.reportWrite(value, super.transactions, () {
      super.transactions = value;
    });
  }

  late final _$isLoadingAtom = Atom(
      name: 'CategorizedTransactionsViewModelBase.isLoading', context: context);

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

  late final _$getTransactionsAsyncAction = AsyncAction(
      'CategorizedTransactionsViewModelBase.getTransactions',
      context: context);

  @override
  Future<dynamic> getTransactions(DTOTransactionRequest transactionRequest) {
    return _$getTransactionsAsyncAction
        .run(() => super.getTransactions(transactionRequest));
  }

  late final _$CategorizedTransactionsViewModelBaseActionController =
      ActionController(
          name: 'CategorizedTransactionsViewModelBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$CategorizedTransactionsViewModelBaseActionController
        .startAction(name: 'CategorizedTransactionsViewModelBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$CategorizedTransactionsViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
transactions: ${transactions},
isLoading: ${isLoading}
    ''';
  }
}
