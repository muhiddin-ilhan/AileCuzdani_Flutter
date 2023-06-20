// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borclar_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BorclarViewModel on BorclarViewModelBase, Store {
  late final _$borrowsAtom =
      Atom(name: 'BorclarViewModelBase.borrows', context: context);

  @override
  List<DTOBorrow> get borrows {
    _$borrowsAtom.reportRead();
    return super.borrows;
  }

  @override
  set borrows(List<DTOBorrow> value) {
    _$borrowsAtom.reportWrite(value, super.borrows, () {
      super.borrows = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'BorclarViewModelBase.isLoading', context: context);

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

  late final _$getBorrowsAsyncAction =
      AsyncAction('BorclarViewModelBase.getBorrows', context: context);

  @override
  Future<dynamic> getBorrows() {
    return _$getBorrowsAsyncAction.run(() => super.getBorrows());
  }

  late final _$BorclarViewModelBaseActionController =
      ActionController(name: 'BorclarViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$BorclarViewModelBaseActionController.startAction(
        name: 'BorclarViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$BorclarViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
borrows: ${borrows},
isLoading: ${isLoading}
    ''';
  }
}
