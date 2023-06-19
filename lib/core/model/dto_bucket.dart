// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_bucket.g.dart';

@JsonSerializable()
class DTOBucket extends BaseModel<DTOBucket> {
  @JsonKey(name: "_id")
  String? id;
  String? user_id;
  String? family_id;
  String? title;
  double? money;
  DateTime? created_at;
  DateTime? modified_at;
  int? is_deleted;
  DTOUser? user;
  double? credit_card_limit;
  double? credit_card_borrow;
  double? count;
  String? gold_type;
  String? currency_type;
  String? platform;
  int? type;
  int? show_my_assets;
  String? cekilecek_hesap_id;

  DTOBucket({
    this.created_at,
    this.id,
    this.is_deleted,
    this.modified_at,
    this.title,
    this.family_id,
    this.money,
    this.user,
    this.user_id,
    this.count,
    this.credit_card_borrow,
    this.credit_card_limit,
    this.currency_type,
    this.gold_type,
    this.platform,
    this.show_my_assets,
    this.type,
    this.cekilecek_hesap_id,
  });

  factory DTOBucket.fromJson(Map<String, dynamic> json) {
    return _$DTOBucketFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOBucketToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOBucketFromJson(json);
  }
}
