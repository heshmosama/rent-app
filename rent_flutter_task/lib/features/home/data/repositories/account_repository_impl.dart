import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rent_flutter_task/features/home/data/datasource/remote/soruce/accounts_datasource.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/features/home/domain/repositories/account_repository.dart';
import '../../../../core/error/exceptions.dart';

@LazySingleton(
  as: AccountRepository,
)
class AccountRepositoryImpl extends AccountRepository {
  final AccountsDataSource _accountsDataSource;
  final Logger? _logger;

  AccountRepositoryImpl(this._accountsDataSource, this._logger);

  @override
  Future<Either<Failure, List<AccountEntityResponse>>> getAllAccounts(
      AccountModelRequestQuery accountModelRequestQuery) async {
    try {
      var response =
          await _accountsDataSource.getAllAccounts(accountModelRequestQuery);
      return Right(response);
    } on ServerException catch (error) {
      _logger?.e('network error', error.message);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllProvince() async {
    try {
      var response = await _accountsDataSource.getAllProvince();
      return Right(response);
    } on ServerException catch (error) {
      _logger?.e('network error', error.message);
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<int>>> getAllStateCodes() async {
    try {
      var response = await _accountsDataSource.getAllStateCodes();
      return Right(response);
    } on ServerException catch (error) {
      _logger?.e('network error', error.message);
      return Left(ServerFailure());
    }
  }
}
