// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_family_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOFamilyRequest _$DTOFamilyRequestFromJson(Map<String, dynamic> json) =>
    DTOFamilyRequest(
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      requestor_id: json['requestor_id'] as String?,
      family_id: json['family_id'] as String?,
      id: json['_id'] as String?,
      users: json['users'] == null
          ? null
          : DTOUser.fromJson(json['users'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DTOFamilyRequestToJson(DTOFamilyRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'requestor_id': instance.requestor_id,
      'family_id': instance.family_id,
      'created_at': instance.created_at?.toIso8601String(),
      'users': instance.users,
    };
