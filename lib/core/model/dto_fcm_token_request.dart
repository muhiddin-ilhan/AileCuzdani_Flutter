// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_fcm_token_request.g.dart';

@JsonSerializable()
class DTOFcmTokenRequest extends BaseModel<DTOFcmTokenRequest> {
  bool? transaction_update;
  bool? transaction_add_delete;
  bool? family_request;
  bool? family_leaving;
  bool? family_updates;
  bool? card_add_delete;
  bool? transfer_between_cards;
  String? fcm_token;
  String? device_id;

  DTOFcmTokenRequest({
    this.card_add_delete,
    this.device_id,
    this.family_leaving,
    this.family_request,
    this.family_updates,
    this.fcm_token,
    this.transaction_add_delete,
    this.transaction_update,
    this.transfer_between_cards,
  });

  factory DTOFcmTokenRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOFcmTokenRequestFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOFcmTokenRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOFcmTokenRequestFromJson(json);
  }
}
