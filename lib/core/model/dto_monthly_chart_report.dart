// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_monthly_chart_report.g.dart';

@JsonSerializable()
class DTOMonthlyChartReport extends BaseModel<DTOMonthlyChartReport> {
  double? expense_1;
  double? income_1;
  double? expense_2;
  double? income_2;
  double? expense_3;
  double? income_3;
  double? expense_4;
  double? income_4;
  double? expense_5;
  double? income_5;
  double? expense_6;
  double? income_6;
  double? expense_7;
  double? income_7;
  double? expense_8;
  double? income_8;
  double? expense_9;
  double? income_9;
  double? expense_10;
  double? income_10;
  double? expense_11;
  double? income_11;
  double? expense_12;
  double? income_12;

  DTOMonthlyChartReport({
    this.expense_1,
    this.expense_10,
    this.expense_11,
    this.expense_12,
    this.expense_2,
    this.expense_3,
    this.expense_4,
    this.expense_5,
    this.expense_6,
    this.expense_7,
    this.expense_8,
    this.expense_9,
    this.income_1,
    this.income_10,
    this.income_11,
    this.income_12,
    this.income_2,
    this.income_3,
    this.income_4,
    this.income_5,
    this.income_6,
    this.income_7,
    this.income_8,
    this.income_9,
  });

  factory DTOMonthlyChartReport.fromJson(Map<String, dynamic> json) {
    return _$DTOMonthlyChartReportFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOMonthlyChartReportToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOMonthlyChartReportFromJson(json);
  }
}
