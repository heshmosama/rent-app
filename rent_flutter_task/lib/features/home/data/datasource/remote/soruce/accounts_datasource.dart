import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';

abstract class AccountsDataSource {
  Future<List<AccountModelResponse>> getAllAccounts(
      AccountModelRequestQuery accountModelRequestQuery);

  Future<List<String>> getAllProvince();

  Future<List<int>> getAllStateCodes();
}
