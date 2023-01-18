// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_total_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOTotalValues _$DTOTotalValuesFromJson(Map<String, dynamic> json) =>
    DTOTotalValues(
      totalCount: (json['totalCount'] as num?)?.toDouble(),
      totalExpense: (json['totalExpense'] as num?)?.toDouble(),
      totalIncome: (json['totalIncome'] as num?)?.toDouble(),
      currentMonthExpense: (json['currentMonthExpense'] as num?)?.toDouble(),
      currentMonthIncome: (json['currentMonthIncome'] as num?)?.toDouble(),
      lastMonthBalance: (json['lastMonthBalance'] as num?)?.toDouble(),
      totalBalance: (json['totalBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DTOTotalValuesToJson(DTOTotalValues instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'totalExpense': instance.totalExpense,
      'totalIncome': instance.totalIncome,
      'totalBalance': instance.totalBalance,
      'lastMonthBalance': instance.lastMonthBalance,
      'currentMonthExpense': instance.currentMonthExpense,
      'currentMonthIncome': instance.currentMonthIncome,
    };
