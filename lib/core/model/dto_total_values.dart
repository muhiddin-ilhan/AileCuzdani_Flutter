// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_total_values.g.dart';

@JsonSerializable()
class DTOTotalValues extends BaseModel<DTOTotalValues> {
  double? totalCount;
  double? totalExpense;
  double? totalIncome;
  double? totalBalance;
  double? lastMonthBalance;
  double? currentMonthExpense;
  double? currentMonthIncome;

  DTOTotalValues({
    this.totalCount,
    this.totalExpense,
    this.totalIncome,
    this.currentMonthExpense,
    this.currentMonthIncome,
    this.lastMonthBalance,
    this.totalBalance,
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
