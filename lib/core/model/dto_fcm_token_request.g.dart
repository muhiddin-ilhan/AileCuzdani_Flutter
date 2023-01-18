// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_fcm_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOFcmTokenRequest _$DTOFcmTokenRequestFromJson(Map<String, dynamic> json) =>
    DTOFcmTokenRequest(
      card_add_delete: json['card_add_delete'] as bool?,
      device_id: json['device_id'] as String?,
      family_leaving: json['family_leaving'] as bool?,
      family_request: json['family_request'] as bool?,
      family_updates: json['family_updates'] as bool?,
      fcm_token: json['fcm_token'] as String?,
      transaction_add_delete: json['transaction_add_delete'] as bool?,
      transaction_update: json['transaction_update'] as bool?,
      transfer_between_cards: json['transfer_between_cards'] as bool?,
    );

Map<String, dynamic> _$DTOFcmTokenRequestToJson(DTOFcmTokenRequest instance) =>
    <String, dynamic>{
      'transaction_update': instance.transaction_update,
      'transaction_add_delete': instance.transaction_add_delete,
      'family_request': instance.family_request,
      'family_leaving': instance.family_leaving,
      'family_updates': instance.family_updates,
      'card_add_delete': instance.card_add_delete,
      'transfer_between_cards': instance.transfer_between_cards,
      'fcm_token': instance.fcm_token,
      'device_id': instance.device_id,
    };
