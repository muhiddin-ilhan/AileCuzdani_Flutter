// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOFamily _$DTOFamilyFromJson(Map<String, dynamic> json) => DTOFamily(
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      id: json['_id'] as String?,
      is_deleted: json['is_deleted'] as int?,
      modified_at: json['modified_at'] == null
          ? null
          : DateTime.parse(json['modified_at'] as String),
      title: json['title'] as String?,
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => DTOUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      period_day: json['period_day'] as int?,
    );

Map<String, dynamic> _$DTOFamilyToJson(DTOFamily instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'is_deleted': instance.is_deleted,
      'created_at': instance.created_at?.toIso8601String(),
      'modified_at': instance.modified_at?.toIso8601String(),
      'period_day': instance.period_day,
      'users': instance.users,
    };
