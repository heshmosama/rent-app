import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_model_request_query.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class AccountModelRequestQuery extends Equatable {
  @JsonKey(name: 'searchQuery')
  final String? searchQuery;
  @JsonKey(name: 'filterBy')
  final String? filterBy;

  const AccountModelRequestQuery({this.searchQuery, this.filterBy});

  factory AccountModelRequestQuery.fromJson(Map<String, dynamic> json) =>
      _$AccountModelRequestQueryFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelRequestQueryToJson(this);

  @override
  List<Object?> get props => [searchQuery, filterBy];
}
