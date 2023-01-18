// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_family.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_user.g.dart';

@JsonSerializable()
class DTOUser extends BaseModel<DTOUser> {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(includeIfNull: false)
  String? name;
  @JsonKey(includeIfNull: false)
  String? surname;
  @JsonKey(includeIfNull: false)
  String? email;
  @JsonKey(includeIfNull: false)
  String? phone_number;
  String? password;
  int? is_deleted;
  DateTime? created_at;
  DateTime? modified_at;
  String? family_id;
  DTOFamily? family;

  DTOUser({
    this.created_at,
    this.email,
    this.family_id,
    this.id,
    this.is_deleted,
    this.modified_at,
    this.name,
    this.phone_number,
    this.surname,
    this.family,
    this.password,
  });

  factory DTOUser.fromJson(Map<String, dynamic> json) {
    return _$DTOUserFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOUserToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOUserFromJson(json);
  }
}
