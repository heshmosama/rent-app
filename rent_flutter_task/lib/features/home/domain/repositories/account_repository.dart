import 'package:dartz/dartz.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/account_model_request_query.dart';

abstract class AccountRepository {
  Future<Either<Failure, List<AccountEntityResponse>>> getAllAccounts(
      AccountModelRequestQuery accountModelRequestQuery);
  Future<Either<Failure, List<String>>> getAllProvince();
  Future<Either<Failure, List<int>>> getAllStateCodes();
}
