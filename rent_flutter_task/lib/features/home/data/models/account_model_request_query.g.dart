// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model_request_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModelRequestQuery _$AccountModelRequestQueryFromJson(
        Map<String, dynamic> json) =>
    AccountModelRequestQuery(
      searchQuery: json['searchQuery'] as String?,
      filterBy: json['filterBy'] as String?,
    );

Map<String, dynamic> _$AccountModelRequestQueryToJson(
        AccountModelRequestQuery instance) =>
    <String, dynamic>{
      'searchQuery': instance.searchQuery,
      'filterBy': instance.filterBy,
    };
