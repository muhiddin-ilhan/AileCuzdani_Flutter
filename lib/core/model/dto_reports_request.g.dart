// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_reports_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOReportsRequest _$DTOReportsRequestFromJson(Map<String, dynamic> json) =>
    DTOReportsRequest(
      day: json['day'] as String?,
      end_month: json['end_month'] as String?,
      end_year: json['end_year'] as String?,
      start_month: json['start_month'] as String?,
      start_year: json['start_year'] as String?,
    );

Map<String, dynamic> _$DTOReportsRequestToJson(DTOReportsRequest instance) =>
    <String, dynamic>{
      'start_year': instance.start_year,
      'end_year': instance.end_year,
      'start_month': instance.start_month,
      'end_month': instance.end_month,
      'day': instance.day,
    };
