// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_total_values.g.dart';

@JsonSerializable()
class DTOTotalValues extends BaseModel<DTOTotalValues> {
  double? myAssetsSpecial;
  double? myAssetsAll;
  double? myAssetsAccount;
  double? myAssetsGold;
  double? myAssetsCurrency;
  double? myAssetsBorsa;
  double? myAssetsCoin;
  double? myBorrowsThisMonth;
  double? myBorrowsThisMonthCreditCards;
  double? myBorrowsThisMonthCredi;
  double? myBorrowsTotal;
  double? myBorrowsCredi;
  double? myBorrowsCreditCards;
  double? totalIncome;
  double? totalExpense;
  double? totalCount;

  DTOTotalValues({
    this.myAssetsAccount,
    this.myAssetsAll,
    this.myAssetsBorsa,
    this.myAssetsCoin,
    this.myAssetsCurrency,
    this.myAssetsGold,
    this.myAssetsSpecial,
    this.myBorrowsCredi,
    this.myBorrowsThisMonth,
    this.myBorrowsThisMonthCredi,
    this.myBorrowsThisMonthCreditCards,
    this.myBorrowsTotal,
    this.totalCount,
    this.totalExpense,
    this.totalIncome,
    this.myBorrowsCreditCards,
  });

  factory DTOTotalValues.fromJson(Map<String, dynamic> json) {
    return _$DTOTotalValuesFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOTotalValuesToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOTotalValuesFromJson(json);
  }
}
