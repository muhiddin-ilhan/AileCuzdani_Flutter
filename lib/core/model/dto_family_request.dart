// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_family_request.g.dart';

@JsonSerializable()
class DTOFamilyRequest extends BaseModel<DTOFamilyRequest> {
  @JsonKey(name: "_id")
  String? id;
  String? requestor_id;
  String? family_id;
  DateTime? created_at;
  DTOUser? users;

  DTOFamilyRequest({
    this.created_at,
    this.requestor_id,
    this.family_id,
    this.id,
    this.users,
  });

  factory DTOFamilyRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOFamilyRequestFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOFamilyRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOFamilyRequestFromJson(json);
  }
}
