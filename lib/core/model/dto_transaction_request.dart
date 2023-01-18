// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_transaction_request.g.dart';

@JsonSerializable()
class DTOTransactionRequest extends BaseModel<DTOTransactionRequest> {
  String? words;
  String? bucket_id;
  int? is_expense;
  String? user_id;
  String? sort;
  DateTime? start_date;
  DateTime? finish_date;
  int? start_price;
  int? end_price;
  int? page;
  int? limit;
  String? category;

  DTOTransactionRequest({
    this.bucket_id,
    this.end_price,
    this.finish_date,
    this.is_expense,
    this.sort,
    this.start_date,
    this.start_price,
    this.user_id,
    this.words,
    this.limit,
    this.page,
    this.category,
  });

  factory DTOTransactionRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOTransactionRequestFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOTransactionRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOTransactionRequestFromJson(json);
  }
}
