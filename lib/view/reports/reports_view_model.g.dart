// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReportsViewModel on ReportsViewModelBase, Store {
  late final _$loadingAtom =
      Atom(name: 'ReportsViewModelBase.loading', context: context);

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

  late final _$scrollControllerAtom =
      Atom(name: 'ReportsViewModelBase.scrollController', context: context);

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

  late final _$selectedCategoryTabIndexAtom = Atom(
      name: 'ReportsViewModelBase.selectedCategoryTabIndex', context: context);

  @override
  int get selectedCategoryTabIndex {
    _$selectedCategoryTabIndexAtom.reportRead();
    return super.selectedCategoryTabIndex;
  }

  @override
  set selectedCategoryTabIndex(int value) {
    _$selectedCategoryTabIndexAtom
        .reportWrite(value, super.selectedCategoryTabIndex, () {
      super.selectedCategoryTabIndex = value;
    });
  }

  late final _$selectedChartIndexAtom =
      Atom(name: 'ReportsViewModelBase.selectedChartIndex', context: context);

  @override
  int? get selectedChartIndex {
    _$selectedChartIndexAtom.reportRead();
    return super.selectedChartIndex;
  }

  @override
  set selectedChartIndex(int? value) {
    _$selectedChartIndexAtom.reportWrite(value, super.selectedChartIndex, () {
      super.selectedChartIndex = value;
    });
  }

  late final _$selectedYearAtom =
      Atom(name: 'ReportsViewModelBase.selectedYear', context: context);

  @override
  int get selectedYear {
    _$selectedYearAtom.reportRead();
    return super.selectedYear;
  }

  @override
  set selectedYear(int value) {
    _$selectedYearAtom.reportWrite(value, super.selectedYear, () {
      super.selectedYear = value;
    });
  }

  late final _$yearListAtom =
      Atom(name: 'ReportsViewModelBase.yearList', context: context);

  @override
  List<int> get yearList {
    _$yearListAtom.reportRead();
    return super.yearList;
  }

  @override
  set yearList(List<int> value) {
    _$yearListAtom.reportWrite(value, super.yearList, () {
      super.yearList = value;
    });
  }

  late final _$chartScrollControllerAtom = Atom(
      name: 'ReportsViewModelBase.chartScrollController', context: context);

  @override
  ScrollController get chartScrollController {
    _$chartScrollControllerAtom.reportRead();
    return super.chartScrollController;
  }

  @override
  set chartScrollController(ScrollController value) {
    _$chartScrollControllerAtom.reportWrite(value, super.chartScrollController,
        () {
      super.chartScrollController = value;
    });
  }

  late final _$chartHeightAtom =
      Atom(name: 'ReportsViewModelBase.chartHeight', context: context);

  @override
  double get chartHeight {
    _$chartHeightAtom.reportRead();
    return super.chartHeight;
  }

  @override
  set chartHeight(double value) {
    _$chartHeightAtom.reportWrite(value, super.chartHeight, () {
      super.chartHeight = value;
    });
  }

  late final _$yearTabHeightAtom =
      Atom(name: 'ReportsViewModelBase.yearTabHeight', context: context);

  @override
  double get yearTabHeight {
    _$yearTabHeightAtom.reportRead();
    return super.yearTabHeight;
  }

  @override
  set yearTabHeight(double value) {
    _$yearTabHeightAtom.reportWrite(value, super.yearTabHeight, () {
      super.yearTabHeight = value;
    });
  }

  late final _$chartReportsAtom =
      Atom(name: 'ReportsViewModelBase.chartReports', context: context);

  @override
  DTOMonthlyChartReport? get chartReports {
    _$chartReportsAtom.reportRead();
    return super.chartReports;
  }

  @override
  set chartReports(DTOMonthlyChartReport? value) {
    _$chartReportsAtom.reportWrite(value, super.chartReports, () {
      super.chartReports = value;
    });
  }

  late final _$reportItemsAtom =
      Atom(name: 'ReportsViewModelBase.reportItems', context: context);

  @override
  List<DTOReportItem>? get reportItems {
    _$reportItemsAtom.reportRead();
    return super.reportItems;
  }

  @override
  set reportItems(List<DTOReportItem>? value) {
    _$reportItemsAtom.reportWrite(value, super.reportItems, () {
      super.reportItems = value;
    });
  }

  late final _$familyPeriodDayAtom =
      Atom(name: 'ReportsViewModelBase.familyPeriodDay', context: context);

  @override
  int? get familyPeriodDay {
    _$familyPeriodDayAtom.reportRead();
    return super.familyPeriodDay;
  }

  @override
  set familyPeriodDay(int? value) {
    _$familyPeriodDayAtom.reportWrite(value, super.familyPeriodDay, () {
      super.familyPeriodDay = value;
    });
  }

  late final _$onTapYearAsyncAction =
      AsyncAction('ReportsViewModelBase.onTapYear', context: context);

  @override
  Future<dynamic> onTapYear(int index) {
    return _$onTapYearAsyncAction.run(() => super.onTapYear(index));
  }

  late final _$onTapTabAsyncAction =
      AsyncAction('ReportsViewModelBase.onTapTab', context: context);

  @override
  Future<dynamic> onTapTab(int index) {
    return _$onTapTabAsyncAction.run(() => super.onTapTab(index));
  }

  late final _$getChartStatisticsAsyncAction =
      AsyncAction('ReportsViewModelBase.getChartStatistics', context: context);

  @override
  Future<dynamic> getChartStatistics() {
    return _$getChartStatisticsAsyncAction
        .run(() => super.getChartStatistics());
  }

  late final _$getCategorizeReportsAsyncAction = AsyncAction(
      'ReportsViewModelBase.getCategorizeReports',
      context: context);

  @override
  Future<dynamic> getCategorizeReports() {
    return _$getCategorizeReportsAsyncAction
        .run(() => super.getCategorizeReports());
  }

  late final _$getUsersReportsAsyncAction =
      AsyncAction('ReportsViewModelBase.getUsersReports', context: context);

  @override
  Future<dynamic> getUsersReports() {
    return _$getUsersReportsAsyncAction.run(() => super.getUsersReports());
  }

  late final _$getCardsReportsAsyncAction =
      AsyncAction('ReportsViewModelBase.getCardsReports', context: context);

  @override
  Future<dynamic> getCardsReports() {
    return _$getCardsReportsAsyncAction.run(() => super.getCardsReports());
  }

  late final _$onReportItemClickAsyncAction =
      AsyncAction('ReportsViewModelBase.onReportItemClick', context: context);

  @override
  Future<dynamic> onReportItemClick(
      BuildContext context, DTOReportItem item, bool isExpenses) {
    return _$onReportItemClickAsyncAction
        .run(() => super.onReportItemClick(context, item, isExpenses));
  }

  late final _$ReportsViewModelBaseActionController =
      ActionController(name: 'ReportsViewModelBase', context: context);

  @override
  dynamic scrollListener(BuildContext context) {
    final _$actionInfo = _$ReportsViewModelBaseActionController.startAction(
        name: 'ReportsViewModelBase.scrollListener');
    try {
      return super.scrollListener(context);
    } finally {
      _$ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getYears() {
    final _$actionInfo = _$ReportsViewModelBaseActionController.startAction(
        name: 'ReportsViewModelBase.getYears');
    try {
      return super.getYears();
    } finally {
      _$ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setScrollPositionChart(BuildContext context) {
    final _$actionInfo = _$ReportsViewModelBaseActionController.startAction(
        name: 'ReportsViewModelBase.setScrollPositionChart');
    try {
      return super.setScrollPositionChart(context);
    } finally {
      _$ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic onTapChart(int index) {
    final _$actionInfo = _$ReportsViewModelBaseActionController.startAction(
        name: 'ReportsViewModelBase.onTapChart');
    try {
      return super.onTapChart(index);
    } finally {
      _$ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$ReportsViewModelBaseActionController.startAction(
        name: 'ReportsViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
scrollController: ${scrollController},
selectedCategoryTabIndex: ${selectedCategoryTabIndex},
selectedChartIndex: ${selectedChartIndex},
selectedYear: ${selectedYear},
yearList: ${yearList},
chartScrollController: ${chartScrollController},
chartHeight: ${chartHeight},
yearTabHeight: ${yearTabHeight},
chartReports: ${chartReports},
reportItems: ${reportItems},
familyPeriodDay: ${familyPeriodDay}
    ''';
  }
}
