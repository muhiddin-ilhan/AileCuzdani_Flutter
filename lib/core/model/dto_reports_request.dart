// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_reports_request.g.dart';

@JsonSerializable()
class DTOReportsRequest extends BaseModel<DTOReportsRequest> {
  String? start_year;
  String? end_year;
  String? start_month;
  String? end_month;
  String? day;

  DTOReportsRequest({
    this.day,
    this.end_month,
    this.end_year,
    this.start_month,
    this.start_year,
  });

  factory DTOReportsRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOReportsRequestFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOReportsRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOReportsRequestFromJson(json);
  }
}
