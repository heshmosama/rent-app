import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/core/utils/constants.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_request_query.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_accounts.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/accounts/account_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/accounts/account_state.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/accounts/accounts_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetAllAccountsUseCase extends Mock implements GetAllAccountsUseCase {}

void main() {
  late MockGetAllAccountsUseCase mockGetAllAccountsUseCase;
  late AccountsBloc accountsBloc;
  late List<AccountEntityResponse> accountsResponse;
  const accountModelRequestQuery =
      AccountEntityRequestQuery('c', "{\"stateCode : 0\"}");

  setUp(() {
    mockGetAllAccountsUseCase = MockGetAllAccountsUseCase();
    accountsBloc = AccountsBloc(mockGetAllAccountsUseCase, null);
    accountsResponse =
        (json.decode(fixture('accounts_response.json')) as List<dynamic>)
            .map((e) => AccountModelResponse.fromJson(e))
            .toList();
  });

  void setUpMockGetAllAccountsSuccess() => when(() => mockGetAllAccountsUseCase(
          const GetAllAccountsParams(accountModelRequestQuery)))
      .thenAnswer((_) async => Right(accountsResponse));
  group('get all accounts', () {
    test('should call use-case to get data', () async {
      // arrange
      setUpMockGetAllAccountsSuccess();
      // act
      accountsBloc.add(GetAllAccounts(accountModelRequestQuery));
      await untilCalled(() => mockGetAllAccountsUseCase(
          const GetAllAccountsParams(accountModelRequestQuery)));
      // assert
      verify(() => mockGetAllAccountsUseCase(
          const GetAllAccountsParams(accountModelRequestQuery)));
    });

    test(
      'should emit [Error] when the input is invalid',
      () {
        // arrange
        when(() => mockGetAllAccountsUseCase(
                const GetAllAccountsParams(accountModelRequestQuery)))
            .thenAnswer((invocation) async => Left(ServerFailure()));

        // assert later
        var expected = [
          Loading(),
          Error(message: server_failure_message),
        ];
        expectLater(accountsBloc.stream, emitsInOrder(expected));
        // act
        accountsBloc.add(GetAllAccounts(accountModelRequestQuery));
      },
    );

    test(
      'should emit [loaded] when the input is valide',
      () {
        // arrange
        setUpMockGetAllAccountsSuccess();

        // assert later
        var expected = [
          Loading(),
          Loaded(accounts: accountsResponse),
        ];
        expectLater(accountsBloc.stream, emitsInOrder(expected));
        // act
        accountsBloc.add(GetAllAccounts(accountModelRequestQuery));
      },
    );
  });
}
