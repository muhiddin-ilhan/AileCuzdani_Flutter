// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DTOPaging _$DTOPagingFromJson(Map<String, dynamic> json) => DTOPaging(
      hasNextPage: json['hasNextPage'] as bool?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      limit: json['limit'] as int?,
      nextPage: json['nextPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
      prevPage: json['prevPage'] as int?,
      totalDocs: json['totalDocs'] as int?,
      totalPages: json['totalPages'] as int?,
    );

Map<String, dynamic> _$DTOPagingToJson(DTOPaging instance) => <String, dynamic>{
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'pagingCounter': instance.pagingCounter,
      'hasPrevPage': instance.hasPrevPage,
      'hasNextPage': instance.hasNextPage,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
    };
