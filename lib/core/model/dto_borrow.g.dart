// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_borrow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOBorrow _$DTOBorrowFromJson(Map<String, dynamic> json) => DTOBorrow(
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
      last_paid_month: json['last_paid_month'] as int?,
      monthly_price: (json['monthly_price'] as num?)?.toDouble(),
      paid_taksit: json['paid_taksit'] as int?,
      pay_day: json['pay_day'] as int?,
      total_borrow: (json['total_borrow'] as num?)?.toDouble(),
      total_taksit_count: json['total_taksit_count'] as int?,
      user_id: json['user_id'] as String?,
      user: json['user'] == null
          ? null
          : DTOUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DTOBorrowToJson(DTOBorrow instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'family_id': instance.family_id,
      'user': instance.user,
      'title': instance.title,
      'monthly_price': instance.monthly_price,
      'total_borrow': instance.total_borrow,
      'pay_day': instance.pay_day,
      'last_paid_month': instance.last_paid_month,
      'paid_taksit': instance.paid_taksit,
      'total_taksit_count': instance.total_taksit_count,
      'created_at': instance.created_at?.toIso8601String(),
      'modified_at': instance.modified_at?.toIso8601String(),
      'is_deleted': instance.is_deleted,
    };
