// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_paging.dart';
import 'package:aile_cuzdani/core/model/dto_total_values.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_response.g.dart';

@JsonSerializable()
class DTOResponse extends BaseModel<DTOResponse> {
  bool? success;
  String? message;
  String? access_token;
  dynamic data;
  DTOPaging? paging;
  DTOTotalValues? totalValues;

  DTOResponse({
    this.access_token,
    this.data,
    this.message,
    this.success,
    this.paging,
    this.totalValues,
  });

  factory DTOResponse.fromJson(Map<String, dynamic> json) {
    return _$DTOResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOResponseToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOResponseFromJson(json);
  }
}
