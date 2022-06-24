import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_request_query.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import 'package:rent_flutter_task/features/home/domain/repositories/account_repository.dart';
import 'package:rent_flutter_task/features/home/domain/usecases/get_all_accounts.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late MockAccountRepository mockAccountRepository;
  late GetAllAccountsUseCase getAllAccountsUseCase;
  late List<AccountEntityResponse> accountsResponse;
  const accountModelRequestQuery =
      AccountEntityRequestQuery('c', "{\"stateCode : 0\"}");

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    getAllAccountsUseCase = GetAllAccountsUseCase(mockAccountRepository);
    accountsResponse =
        (json.decode(fixture('accounts_response.json')) as List<dynamic>)
            .map((e) => AccountModelResponse.fromJson(e))
            .toList();
  });

  group('get all accounts', () {
    test('should get accounts from repository', () async {
      // arrange
      when(() => mockAccountRepository.getAllAccounts(accountModelRequestQuery))
          .thenAnswer((_) async => Right(accountsResponse));
      // act
      var result = await getAllAccountsUseCase(
          const GetAllAccountsParams(accountModelRequestQuery));
      // assert
      expect(result, Right(accountsResponse));
      verify(
          () => mockAccountRepository.getAllAccounts(accountModelRequestQuery));
      verifyNoMoreInteractions(mockAccountRepository);
    });

    test('should return ServerFailure when repository failed to get accounts',
        () async {
      // arrange
      when(() => mockAccountRepository.getAllAccounts(accountModelRequestQuery))
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      var result = await getAllAccountsUseCase(
          const GetAllAccountsParams(accountModelRequestQuery));
      // assert
      expect(result, Left(ServerFailure()));
      verify(
          () => mockAccountRepository.getAllAccounts(accountModelRequestQuery));
      verifyNoMoreInteractions(mockAccountRepository);
    });
  });
}
