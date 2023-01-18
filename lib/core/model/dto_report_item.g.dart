// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_report_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOReportItem _$DTOReportItemFromJson(Map<String, dynamic> json) =>
    DTOReportItem(
      expense: (json['expense'] as num?)?.toDouble(),
      income: (json['income'] as num?)?.toDouble(),
      title: json['title'] as String?,
      is_expense: json['is_expense'] as bool?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$DTOReportItemToJson(DTOReportItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'expense': instance.expense,
      'income': instance.income,
      'is_expense': instance.is_expense,
    };
