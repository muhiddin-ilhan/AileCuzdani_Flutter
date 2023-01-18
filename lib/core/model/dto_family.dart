// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_family.g.dart';

@JsonSerializable()
class DTOFamily extends BaseModel<DTOFamily> {
  @JsonKey(name: "_id")
  String? id;
  String? title;
  int? is_deleted;
  DateTime? created_at;
  DateTime? modified_at;
  int? period_day;
  List<DTOUser>? users;

  DTOFamily({
    this.created_at,
    this.id,
    this.is_deleted,
    this.modified_at,
    this.title,
    this.users,
    this.period_day,
  });

  factory DTOFamily.fromJson(Map<String, dynamic> json) {
    return _$DTOFamilyFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOFamilyToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOFamilyFromJson(json);
  }
}
