// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOTransaction _$DTOTransactionFromJson(Map<String, dynamic> json) =>
    DTOTransaction(
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
      user: json['user'] == null
          ? null
          : DTOUser.fromJson(json['user'] as Map<String, dynamic>),
      user_id: json['user_id'] as String?,
      bucket: json['bucket'] == null
          ? null
          : DTOBucket.fromJson(json['bucket'] as Map<String, dynamic>),
      bucket_id: json['bucket_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      is_expense: json['is_expense'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$DTOTransactionToJson(DTOTransaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'family_id': instance.family_id,
      'bucket_id': instance.bucket_id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'date': instance.date?.toIso8601String(),
      'is_expense': instance.is_expense,
      'created_at': instance.created_at?.toIso8601String(),
      'modified_at': instance.modified_at?.toIso8601String(),
      'is_deleted': instance.is_deleted,
      'user': instance.user,
      'bucket': instance.bucket,
    };
