// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'HomeViewModelBase.isLoading', context: context);

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
      Atom(name: 'HomeViewModelBase.transactions', context: context);

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
      Atom(name: 'HomeViewModelBase.totalValues', context: context);

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

  late final _$scrollControllerAtom =
      Atom(name: 'HomeViewModelBase.scrollController', context: context);

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  late final _$fontSizePriceAtom =
      Atom(name: 'HomeViewModelBase.fontSizePrice', context: context);

  @override
  double get fontSizePrice {
    _$fontSizePriceAtom.reportRead();
    return super.fontSizePrice;
  }

  @override
  set fontSizePrice(double value) {
    _$fontSizePriceAtom.reportWrite(value, super.fontSizePrice, () {
      super.fontSizePrice = value;
    });
  }

  late final _$maxFontSizePriceAtom =
      Atom(name: 'HomeViewModelBase.maxFontSizePrice', context: context);

  @override
  double get maxFontSizePrice {
    _$maxFontSizePriceAtom.reportRead();
    return super.maxFontSizePrice;
  }

  @override
  set maxFontSizePrice(double value) {
    _$maxFontSizePriceAtom.reportWrite(value, super.maxFontSizePrice, () {
      super.maxFontSizePrice = value;
    });
  }

  late final _$fontSizeTitleAtom =
      Atom(name: 'HomeViewModelBase.fontSizeTitle', context: context);

  @override
  double get fontSizeTitle {
    _$fontSizeTitleAtom.reportRead();
    return super.fontSizeTitle;
  }

  @override
  set fontSizeTitle(double value) {
    _$fontSizeTitleAtom.reportWrite(value, super.fontSizeTitle, () {
      super.fontSizeTitle = value;
    });
  }

  late final _$maxFontSizeTitleAtom =
      Atom(name: 'HomeViewModelBase.maxFontSizeTitle', context: context);

  @override
  double get maxFontSizeTitle {
    _$maxFontSizeTitleAtom.reportRead();
    return super.maxFontSizeTitle;
  }

  @override
  set maxFontSizeTitle(double value) {
    _$maxFontSizeTitleAtom.reportWrite(value, super.maxFontSizeTitle, () {
      super.maxFontSizeTitle = value;
    });
  }

  late final _$maxIconSizeAtom =
      Atom(name: 'HomeViewModelBase.maxIconSize', context: context);

  @override
  double get maxIconSize {
    _$maxIconSizeAtom.reportRead();
    return super.maxIconSize;
  }

  @override
  set maxIconSize(double value) {
    _$maxIconSizeAtom.reportWrite(value, super.maxIconSize, () {
      super.maxIconSize = value;
    });
  }

  late final _$minIconSizeAtom =
      Atom(name: 'HomeViewModelBase.minIconSize', context: context);

  @override
  double get minIconSize {
    _$minIconSizeAtom.reportRead();
    return super.minIconSize;
  }

  @override
  set minIconSize(double value) {
    _$minIconSizeAtom.reportWrite(value, super.minIconSize, () {
      super.minIconSize = value;
    });
  }

  late final _$iconSizeAtom =
      Atom(name: 'HomeViewModelBase.iconSize', context: context);

  @override
  double get iconSize {
    _$iconSizeAtom.reportRead();
    return super.iconSize;
  }

  @override
  set iconSize(double value) {
    _$iconSizeAtom.reportWrite(value, super.iconSize, () {
      super.iconSize = value;
    });
  }

  late final _$getTransactionsAsyncAction =
      AsyncAction('HomeViewModelBase.getTransactions', context: context);

  @override
  Future<dynamic> getTransactions(BuildContext context) {
    return _$getTransactionsAsyncAction
        .run(() => super.getTransactions(context));
  }

  late final _$HomeViewModelBaseActionController =
      ActionController(name: 'HomeViewModelBase', context: context);

  @override
  void scrollListener() {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase.scrollListener');
    try {
      return super.scrollListener();
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
transactions: ${transactions},
totalValues: ${totalValues},
scrollController: ${scrollController},
fontSizePrice: ${fontSizePrice},
maxFontSizePrice: ${maxFontSizePrice},
fontSizeTitle: ${fontSizeTitle},
maxFontSizeTitle: ${maxFontSizeTitle},
maxIconSize: ${maxIconSize},
minIconSize: ${minIconSize},
iconSize: ${iconSize}
    ''';
  }
}
