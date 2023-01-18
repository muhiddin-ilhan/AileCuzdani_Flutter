// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOResponse _$DTOResponseFromJson(Map<String, dynamic> json) => DTOResponse(
      access_token: json['access_token'] as String?,
      data: json['data'],
      message: json['message'] as String?,
      success: json['success'] as bool?,
      paging: json['paging'] == null
          ? null
          : DTOPaging.fromJson(json['paging'] as Map<String, dynamic>),
      totalValues: json['totalValues'] == null
          ? null
          : DTOTotalValues.fromJson(
              json['totalValues'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DTOResponseToJson(DTOResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'access_token': instance.access_token,
      'data': instance.data,
      'paging': instance.paging,
      'totalValues': instance.totalValues,
    };
