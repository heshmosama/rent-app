import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:rent_flutter_task/core/usecase/base_usecase.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_request_query.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import 'package:rent_flutter_task/features/home/domain/repositories/account_repository.dart';

@lazySingleton
class GetAllAccountsUseCase
    implements BaseUseCase<List<AccountEntityResponse>, GetAllAccountsParams> {
  final AccountRepository _accountRepository;
  GetAllAccountsUseCase(this._accountRepository);
  @override
  Future<Either<Failure, List<AccountEntityResponse>>> call(
          GetAllAccountsParams params) async =>
      _accountRepository.getAllAccounts(params._accountEntityRequestQuery);
}

class GetAllAccountsParams extends Equatable {
  final AccountEntityRequestQuery _accountEntityRequestQuery;

  const GetAllAccountsParams(this._accountEntityRequestQuery);

  @override
  List<Object?> get props => [_accountEntityRequestQuery];
}
