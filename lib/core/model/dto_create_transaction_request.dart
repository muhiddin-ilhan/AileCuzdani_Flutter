// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_create_transaction_request.g.dart';

@JsonSerializable()
class DTOCreateTransactionRequest extends BaseModel<DTOCreateTransactionRequest> {
  String? bucket_id;
  String? title;
  String? description;
  double? price;
  DateTime? date;
  String? category;
  String? transaction_id;

  DTOCreateTransactionRequest({
    this.bucket_id,
    this.date,
    this.description,
    this.price,
    this.title,
    this.category,
    this.transaction_id,
  });

  factory DTOCreateTransactionRequest.fromJson(Map<String, dynamic> json) {
    return _$DTOCreateTransactionRequestFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOCreateTransactionRequestToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOCreateTransactionRequestFromJson(json);
  }
}
