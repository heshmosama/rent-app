import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../../models/account_model_response.dart';
import '../service/accounts_network_service.dart';
import 'accounts_datasource.dart';

@LazySingleton(
  as: AccountsDataSource,
)
class AccountDataSourceImpl implements AccountsDataSource {
  final AccountService _accountService;

  const AccountDataSourceImpl(this._accountService);

  @override
  Future<List<AccountModelResponse>> getAllAccounts(
      AccountModelRequestQuery accountModelRequestQuery) async {
    try {
      return await _accountService.getAllAccounts(accountModelRequestQuery);
    } on DioError catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<String>> getAllProvince() async {
    try {
      return await _accountService.getAllProvince();
    } on DioError catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<int>> getAllStateCodes() async {
    try {
      return await _accountService.getAllStateCode();
    } on DioError catch (error) {
      throw ServerException(error.message);
    }
  }
}
