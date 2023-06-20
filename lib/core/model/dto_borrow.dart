// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_borrow.g.dart';

@JsonSerializable()
class DTOBorrow extends BaseModel<DTOBorrow> {
  @JsonKey(name: "_id")
  String? id;
  String? user_id;
  String? family_id;
  DTOUser? user;
  String? title;
  double? monthly_price;
  double? total_borrow;
  int? pay_day;
  int? last_paid_month;
  int? paid_taksit;
  int? total_taksit_count;
  DateTime? created_at;
  DateTime? modified_at;
  int? is_deleted;

  DTOBorrow({
    this.created_at,
    this.id,
    this.is_deleted,
    this.modified_at,
    this.title,
    this.family_id,
    this.last_paid_month,
    this.monthly_price,
    this.paid_taksit,
    this.pay_day,
    this.total_borrow,
    this.total_taksit_count,
    this.user_id,
    this.user,
  });

  factory DTOBorrow.fromJson(Map<String, dynamic> json) {
    return _$DTOBorrowFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOBorrowToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOBorrowFromJson(json);
  }
}
