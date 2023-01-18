// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionsViewModel on TransactionsViewModelBase, Store {
  Computed<bool>? _$isFilterActiveComputed;

  @override
  bool get isFilterActive =>
      (_$isFilterActiveComputed ??= Computed<bool>(() => super.isFilterActive,
              name: 'TransactionsViewModelBase.isFilterActive'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: 'TransactionsViewModelBase.isLoading', context: context);

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

  late final _$transactionsAtom =
      Atom(name: 'TransactionsViewModelBase.transactions', context: context);

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

  late final _$totalValuesAtom =
      Atom(name: 'TransactionsViewModelBase.totalValues', context: context);

  @override
  DTOTotalValues? get totalValues {
    _$totalValuesAtom.reportRead();
    return super.totalValues;
  }

  @override
  set totalValues(DTOTotalValues? value) {
    _$totalValuesAtom.reportWrite(value, super.totalValues, () {
      super.totalValues = value;
    });
  }

  late final _$searchWordsAtom =
      Atom(name: 'TransactionsViewModelBase.searchWords', context: context);

  @override
  String? get searchWords {
    _$searchWordsAtom.reportRead();
    return super.searchWords;
  }

  @override
  set searchWords(String? value) {
    _$searchWordsAtom.reportWrite(value, super.searchWords, () {
      super.searchWords = value;
    });
  }

  late final _$filterBucketAtom =
      Atom(name: 'TransactionsViewModelBase.filterBucket', context: context);

  @override
  DTOBucket? get filterBucket {
    _$filterBucketAtom.reportRead();
    return super.filterBucket;
  }

  @override
  set filterBucket(DTOBucket? value) {
    _$filterBucketAtom.reportWrite(value, super.filterBucket, () {
      super.filterBucket = value;
    });
  }

  late final _$filterExpenseStateAtom = Atom(
      name: 'TransactionsViewModelBase.filterExpenseState', context: context);

  @override
  ExpenseState? get filterExpenseState {
    _$filterExpenseStateAtom.reportRead();
    return super.filterExpenseState;
  }

  @override
  set filterExpenseState(ExpenseState? value) {
    _$filterExpenseStateAtom.reportWrite(value, super.filterExpenseState, () {
      super.filterExpenseState = value;
    });
  }

  late final _$filterUserAtom =
      Atom(name: 'TransactionsViewModelBase.filterUser', context: context);

  @override
  DTOUser? get filterUser {
    _$filterUserAtom.reportRead();
    return super.filterUser;
  }

  @override
  set filterUser(DTOUser? value) {
    _$filterUserAtom.reportWrite(value, super.filterUser, () {
      super.filterUser = value;
    });
  }

  late final _$filterStartDateAtom =
      Atom(name: 'TransactionsViewModelBase.filterStartDate', context: context);

  @override
  DateTime? get filterStartDate {
    _$filterStartDateAtom.reportRead();
    return super.filterStartDate;
  }

  @override
  set filterStartDate(DateTime? value) {
    _$filterStartDateAtom.reportWrite(value, super.filterStartDate, () {
      super.filterStartDate = value;
    });
  }

  late final _$filterEndDateAtom =
      Atom(name: 'TransactionsViewModelBase.filterEndDate', context: context);

  @override
  DateTime? get filterEndDate {
    _$filterEndDateAtom.reportRead();
    return super.filterEndDate;
  }

  @override
  set filterEndDate(DateTime? value) {
    _$filterEndDateAtom.reportWrite(value, super.filterEndDate, () {
      super.filterEndDate = value;
    });
  }

  late final _$filterStartPriceAtom = Atom(
      name: 'TransactionsViewModelBase.filterStartPrice', context: context);

  @override
  int? get filterStartPrice {
    _$filterStartPriceAtom.reportRead();
    return super.filterStartPrice;
  }

  @override
  set filterStartPrice(int? value) {
    _$filterStartPriceAtom.reportWrite(value, super.filterStartPrice, () {
      super.filterStartPrice = value;
    });
  }

  late final _$filterEndPriceAtom =
      Atom(name: 'TransactionsViewModelBase.filterEndPrice', context: context);

  @override
  int? get filterEndPrice {
    _$filterEndPriceAtom.reportRead();
    return super.filterEndPrice;
  }

  @override
  set filterEndPrice(int? value) {
    _$filterEndPriceAtom.reportWrite(value, super.filterEndPrice, () {
      super.filterEndPrice = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: 'TransactionsViewModelBase.currentPage', context: context);

  @override
  int? get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int? value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$totalPageAtom =
      Atom(name: 'TransactionsViewModelBase.totalPage', context: context);

  @override
  int? get totalPage {
    _$totalPageAtom.reportRead();
    return super.totalPage;
  }

  @override
  set totalPage(int? value) {
    _$totalPageAtom.reportWrite(value, super.totalPage, () {
      super.totalPage = value;
    });
  }

  late final _$getTransactionsAsyncAction = AsyncAction(
      'TransactionsViewModelBase.getTransactions',
      context: context);

  @override
  Future<dynamic> getTransactions(BuildContext context, {int? page}) {
    return _$getTransactionsAsyncAction
        .run(() => super.getTransactions(context, page: page));
  }

  late final _$TransactionsViewModelBaseActionController =
      ActionController(name: 'TransactionsViewModelBase', context: context);

  @override
  dynamic setSearchWords(String? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setSearchWords');
    try {
      return super.setSearchWords(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterBucket(DTOBucket? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setFilterBucket');
    try {
      return super.setFilterBucket(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterUser(DTOUser? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setFilterUser');
    try {
      return super.setFilterUser(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterStartDate(DateTime? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setFilterStartDate');
    try {
      return super.setFilterStartDate(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterEndDate(DateTime? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setFilterEndDate');
    try {
      return super.setFilterEndDate(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterStartPrice(int? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setFilterStartPrice');
    try {
      return super.setFilterStartPrice(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterEndPrice(int? val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setFilterEndPrice');
    try {
      return super.setFilterEndPrice(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCurrentPage(int val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setCurrentPage');
    try {
      return super.setCurrentPage(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTotalPage(int val) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setTotalPage');
    try {
      return super.setTotalPage(val);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterClear() {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.filterClear');
    try {
      return super.filterClear();
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$TransactionsViewModelBaseActionController
        .startAction(name: 'TransactionsViewModelBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$TransactionsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
transactions: ${transactions},
totalValues: ${totalValues},
searchWords: ${searchWords},
filterBucket: ${filterBucket},
filterExpenseState: ${filterExpenseState},
filterUser: ${filterUser},
filterStartDate: ${filterStartDate},
filterEndDate: ${filterEndDate},
filterStartPrice: ${filterStartPrice},
filterEndPrice: ${filterEndPrice},
currentPage: ${currentPage},
totalPage: ${totalPage},
isFilterActive: ${isFilterActive}
    ''';
  }
}
