// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOTransactionRequest _$DTOTransactionRequestFromJson(
        Map<String, dynamic> json) =>
    DTOTransactionRequest(
      bucket_id: json['bucket_id'] as String?,
      end_price: json['end_price'] as int?,
      finish_date: json['finish_date'] == null
          ? null
          : DateTime.parse(json['finish_date'] as String),
      is_expense: json['is_expense'] as int?,
      sort: json['sort'] as String?,
      start_date: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      start_price: json['start_price'] as int?,
      user_id: json['user_id'] as String?,
      words: json['words'] as String?,
      limit: json['limit'] as int?,
      page: json['page'] as int?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$DTOTransactionRequestToJson(
        DTOTransactionRequest instance) =>
    <String, dynamic>{
      'words': instance.words,
      'bucket_id': instance.bucket_id,
      'is_expense': instance.is_expense,
      'user_id': instance.user_id,
      'sort': instance.sort,
      'start_date': instance.start_date?.toIso8601String(),
      'finish_date': instance.finish_date?.toIso8601String(),
      'start_price': instance.start_price,
      'end_price': instance.end_price,
      'page': instance.page,
      'limit': instance.limit,
      'category': instance.category,
    };
