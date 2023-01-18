// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_report_item.g.dart';

@JsonSerializable()
class DTOReportItem extends BaseModel<DTOReportItem> {
  String? id;
  String? title;
  double? expense;
  double? income;
  bool? is_expense;

  DTOReportItem({
    this.expense,
    this.income,
    this.title,
    this.is_expense,
    this.id,
  });

  factory DTOReportItem.fromJson(Map<String, dynamic> json) {
    return _$DTOReportItemFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOReportItemToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOReportItemFromJson(json);
  }
}
