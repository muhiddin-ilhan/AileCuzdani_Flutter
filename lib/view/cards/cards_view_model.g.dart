// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cards_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CardsViewModel on CardsViewModelBase, Store {
  late final _$bucketsAtom =
      Atom(name: 'CardsViewModelBase.buckets', context: context);

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
      Atom(name: 'CardsViewModelBase.isLoading', context: context);

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

  late final _$getBucketsAsyncAction =
      AsyncAction('CardsViewModelBase.getBuckets', context: context);

  @override
  Future<dynamic> getBuckets() {
    return _$getBucketsAsyncAction.run(() => super.getBuckets());
  }

  late final _$CardsViewModelBaseActionController =
      ActionController(name: 'CardsViewModelBase', context: context);

  @override
  dynamic setLoading(bool val) {
    final _$actionInfo = _$CardsViewModelBaseActionController.startAction(
        name: 'CardsViewModelBase.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$CardsViewModelBaseActionController.endAction(_$actionInfo);
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
