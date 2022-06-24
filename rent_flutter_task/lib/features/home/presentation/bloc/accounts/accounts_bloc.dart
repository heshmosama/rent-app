import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_accounts.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/builders.dart';
import 'account_event.dart';
import 'account_state.dart';

@lazySingleton
class AccountsBloc extends Bloc<AccountEvent, AccountState> {
  final GetAllAccountsUseCase _getAllAccounts;
  final Logger? _logger;

  AccountsBloc(this._getAllAccounts, this._logger) : super(Empty()) {
    on<GetAllAccounts>((event, emit) => mapEventToState(emit, event));
  }

  void mapEventToState(Emitter<AccountState> emit, GetAllAccounts event) async {
    emit(Loading());
    var response = await _getAllAccounts
        .call(GetAllAccountsParams(event.accountEntityRequestQuery));
    _logger?.d('response', response);
    var failureOrData = await _eitherLoadedOrErrorState(response);
    emit(failureOrData);
  }

  Future<AccountState> _eitherLoadedOrErrorState(
    Either<Failure, List<AccountEntityResponse>> failureOrTrivia,
  ) async =>
      failureOrTrivia.fold(
        (failure) => Error(message: mapFailureToMessage(failure)),
        (accounts) => Loaded(accounts: accounts),
      );
}
