// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOBucket _$DTOBucketFromJson(Map<String, dynamic> json) => DTOBucket(
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      id: json['_id'] as String?,
      is_deleted: json['is_deleted'] as int?,
      modified_at: json['modified_at'] == null
          ? null
          : DateTime.parse(json['modified_at'] as String),
      title: json['title'] as String?,
      family_id: json['family_id'] as String?,
      money: (json['money'] as num?)?.toDouble(),
      user: json['user'] == null
          ? null
          : DTOUser.fromJson(json['user'] as Map<String, dynamic>),
      user_id: json['user_id'] as String?,
    );

Map<String, dynamic> _$DTOBucketToJson(DTOBucket instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'family_id': instance.family_id,
      'title': instance.title,
      'money': instance.money,
      'created_at': instance.created_at?.toIso8601String(),
      'modified_at': instance.modified_at?.toIso8601String(),
      'is_deleted': instance.is_deleted,
      'user': instance.user,
    };
