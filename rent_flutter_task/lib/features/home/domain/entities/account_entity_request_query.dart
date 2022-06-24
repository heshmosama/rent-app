import '../../data/models/account_model_request_query.dart';

class AccountEntityRequestQuery extends AccountModelRequestQuery {
  final String? eSearchQuery;

  final String? eFilterBy;

  const AccountEntityRequestQuery(
    this.eSearchQuery,
    this.eFilterBy,
  ) : super(searchQuery: eSearchQuery, filterBy: eFilterBy);
}
