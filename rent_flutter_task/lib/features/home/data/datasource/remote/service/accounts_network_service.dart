import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rent_flutter_task/core/utils/constants.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';
import 'package:retrofit/retrofit.dart';
part 'accounts_network_service.g.dart';

@RestApi()
@LazySingleton()
abstract class AccountService {
  @factoryMethod
  factory AccountService(Dio dio) = _AccountService;

  @GET(get_all_accouonts_endpoint)
  Future<List<AccountModelResponse>> getAllAccounts(
      @Queries() AccountModelRequestQuery accountModelRequestQuery);

  @GET(get_all_state_or_province)
  Future<List<String>> getAllProvince();

  @GET(get_all_state_code)
  Future<List<int>> getAllStateCode();
}
