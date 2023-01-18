// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

import '../base/base_model.dart';

part 'dto_paging.g.dart';

@JsonSerializable()
class DTOPaging extends BaseModel<DTOPaging> {
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  int? prevPage;
  int? nextPage;

  DTOPaging({
    this.hasNextPage,
    this.hasPrevPage,
    this.limit,
    this.nextPage,
    this.page,
    this.pagingCounter,
    this.prevPage,
    this.totalDocs,
    this.totalPages,
  });

  factory DTOPaging.fromJson(Map<String, dynamic> json) {
    return _$DTOPagingFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DTOPagingToJson(this);
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DTOPagingFromJson(json);
  }
}
