// ignore_for_file: non_constant_identifier_names

import 'package:aile_cuzdani/core/model/dto_bucket.dart';
import 'package:aile_cuzdani/core/model/dto_user.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_transaction.g.dart';

@JsonSerializable()
class DTOTransaction extends BaseModel<DTOTransaction> {
  @JsonKey(name: "_id")
  String? id;
  String? user_id;
  String? family_id;
  String? bucket_id;
  String? title;
  String? description;
  String? category;
  double? price;
  DateTime? date;
  int? is_expense;
  DateTime? created_at;
  DateTime? modified_at;
  int? is_deleted;
  DTOUser? user;
  DTOBucket? bucket;

  DTOTransaction({
    this.created_at,
    this.id,
    this.is_deleted,
    this.modified_at,
    this.title,
    this.family_id,
    this.user,
    this.user_id,
    this.bucket,
    this.bucket_id,
    this.date,
    this.description,
    this.is_expense,
    this.price,
    this.category,
  });

  factory DTOTransaction.fromJson(Map<String, dynamic> json) {
    return _$DTOTransactionFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOTransactionToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOTransactionFromJson(json);
  }
}
