// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOBucket _$DTOBucketFromJson(Map<String, dynamic> json) => DTOBucket(
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
      money: (json['money'] as num?)?.toDouble(),
      user: json['user'] == null
          ? null
          : DTOUser.fromJson(json['user'] as Map<String, dynamic>),
      user_id: json['user_id'] as String?,
      count: (json['count'] as num?)?.toDouble(),
      credit_card_borrow: (json['credit_card_borrow'] as num?)?.toDouble(),
      credit_card_limit: (json['credit_card_limit'] as num?)?.toDouble(),
      currency_type: json['currency_type'] as String?,
      gold_type: json['gold_type'] as String?,
      platform: json['platform'] as String?,
      show_my_assets: json['show_my_assets'] as int?,
      type: json['type'] as int?,
      cekilecek_hesap_id: json['cekilecek_hesap_id'] as String?,
      credit_card_last_pay_month: json['credit_card_last_pay_month'] as int?,
      credit_card_pay_day: json['credit_card_pay_day'] as int?,
    );

Map<String, dynamic> _$DTOBucketToJson(DTOBucket instance) => <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'family_id': instance.family_id,
      'title': instance.title,
      'money': instance.money,
      'created_at': instance.created_at?.toIso8601String(),
      'modified_at': instance.modified_at?.toIso8601String(),
      'is_deleted': instance.is_deleted,
      'user': instance.user,
      'credit_card_limit': instance.credit_card_limit,
      'credit_card_borrow': instance.credit_card_borrow,
      'count': instance.count,
      'gold_type': instance.gold_type,
      'currency_type': instance.currency_type,
      'platform': instance.platform,
      'type': instance.type,
      'show_my_assets': instance.show_my_assets,
      'credit_card_pay_day': instance.credit_card_pay_day,
      'credit_card_last_pay_month': instance.credit_card_last_pay_month,
      'cekilecek_hesap_id': instance.cekilecek_hesap_id,
    };
