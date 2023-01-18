// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_create_transaction_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOCreateTransactionRequest _$DTOCreateTransactionRequestFromJson(
        Map<String, dynamic> json) =>
    DTOCreateTransactionRequest(
      bucket_id: json['bucket_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      title: json['title'] as String?,
      category: json['category'] as String?,
      transaction_id: json['transaction_id'] as String?,
    );

Map<String, dynamic> _$DTOCreateTransactionRequestToJson(
        DTOCreateTransactionRequest instance) =>
    <String, dynamic>{
      'bucket_id': instance.bucket_id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'date': instance.date?.toIso8601String(),
      'category': instance.category,
      'transaction_id': instance.transaction_id,
    };
