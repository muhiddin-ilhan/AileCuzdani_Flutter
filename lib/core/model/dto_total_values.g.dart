// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_total_values.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOTotalValues _$DTOTotalValuesFromJson(Map<String, dynamic> json) =>
    DTOTotalValues(
      myAssetsAccount: (json['myAssetsAccount'] as num?)?.toDouble(),
      myAssetsAll: (json['myAssetsAll'] as num?)?.toDouble(),
      myAssetsBorsa: (json['myAssetsBorsa'] as num?)?.toDouble(),
      myAssetsCoin: (json['myAssetsCoin'] as num?)?.toDouble(),
      myAssetsCurrency: (json['myAssetsCurrency'] as num?)?.toDouble(),
      myAssetsGold: (json['myAssetsGold'] as num?)?.toDouble(),
      myAssetsSpecial: (json['myAssetsSpecial'] as num?)?.toDouble(),
      myBorrowsCredi: (json['myBorrowsCredi'] as num?)?.toDouble(),
      myBorrowsThisMonth: (json['myBorrowsThisMonth'] as num?)?.toDouble(),
      myBorrowsThisMonthCredi:
          (json['myBorrowsThisMonthCredi'] as num?)?.toDouble(),
      myBorrowsThisMonthCreditCards:
          (json['myBorrowsThisMonthCreditCards'] as num?)?.toDouble(),
      myBorrowsTotal: (json['myBorrowsTotal'] as num?)?.toDouble(),
      totalCount: (json['totalCount'] as num?)?.toDouble(),
      totalExpense: (json['totalExpense'] as num?)?.toDouble(),
      totalIncome: (json['totalIncome'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DTOTotalValuesToJson(DTOTotalValues instance) =>
    <String, dynamic>{
      'myAssetsSpecial': instance.myAssetsSpecial,
      'myAssetsAll': instance.myAssetsAll,
      'myAssetsAccount': instance.myAssetsAccount,
      'myAssetsGold': instance.myAssetsGold,
      'myAssetsCurrency': instance.myAssetsCurrency,
      'myAssetsBorsa': instance.myAssetsBorsa,
      'myAssetsCoin': instance.myAssetsCoin,
      'myBorrowsThisMonth': instance.myBorrowsThisMonth,
      'myBorrowsThisMonthCreditCards': instance.myBorrowsThisMonthCreditCards,
      'myBorrowsThisMonthCredi': instance.myBorrowsThisMonthCredi,
      'myBorrowsTotal': instance.myBorrowsTotal,
      'myBorrowsCredi': instance.myBorrowsCredi,
      'totalIncome': instance.totalIncome,
      'totalExpense': instance.totalExpense,
      'totalCount': instance.totalCount,
    };
