// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOUser _$DTOUserFromJson(Map<String, dynamic> json) => DTOUser(
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      email: json['email'] as String?,
      family_id: json['family_id'] as String?,
      id: json['_id'] as String?,
      is_deleted: json['is_deleted'] as int?,
      modified_at: json['modified_at'] == null
          ? null
          : DateTime.parse(json['modified_at'] as String),
      name: json['name'] as String?,
      phone_number: json['phone_number'] as String?,
      surname: json['surname'] as String?,
      family: json['family'] == null
          ? null
          : DTOFamily.fromJson(json['family'] as Map<String, dynamic>),
      password: json['password'] as String?,
    );

Map<String, dynamic> _$DTOUserToJson(DTOUser instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('surname', instance.surname);
  writeNotNull('email', instance.email);
  writeNotNull('phone_number', instance.phone_number);
  val['password'] = instance.password;
  val['is_deleted'] = instance.is_deleted;
  val['created_at'] = instance.created_at?.toIso8601String();
  val['modified_at'] = instance.modified_at?.toIso8601String();
  val['family_id'] = instance.family_id;
  val['family'] = instance.family;
  return val;
}
