import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/exceptions.dart';
import 'package:rent_flutter_task/core/error/failures.dart';
import 'package:rent_flutter_task/features/home/data/datasource/remote/soruce/accounts_datasource.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';
import 'package:rent_flutter_task/features/home/data/repositories/account_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements AccountsDataSource {}

void main() {
  late AccountRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late List<AccountModelResponse> accountsResponse;
  const accountModelRequestQuery = AccountModelRequestQuery(
      searchQuery: 'c', filterBy: "{\"stateCode : 0\"}");

  const List<String> provinceResponse = ['WA'];
  const List<int> stateCodeResponse = [0];

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = AccountRepositoryImpl(mockRemoteDataSource, null);
    accountsResponse =
        (json.decode(fixture('accounts_response.json')) as List<dynamic>)
            .map((e) => AccountModelResponse.fromJson(e))
            .toList();
  });

  group('get Accounts', () {
    test(
        'should return List<AccountModelResponse> when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getAllAccounts(accountModelRequestQuery))
          .thenAnswer((invocation) async => accountsResponse);
      // act
      var result = await repository.getAllAccounts(accountModelRequestQuery);

      // assert
      verify(
          () => mockRemoteDataSource.getAllAccounts(accountModelRequestQuery));
      expect(result, equals(Right(accountsResponse)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(() => mockRemoteDataSource.getAllAccounts(accountModelRequestQuery))
          .thenThrow(ServerException('message'));
      //act
      var result = await repository.getAllAccounts(accountModelRequestQuery);

      verify(
          () => mockRemoteDataSource.getAllAccounts(accountModelRequestQuery));
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('get all province', () {
    test(
        'should return List<String> when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getAllProvince())
          .thenAnswer((invocation) async => provinceResponse);
      // act
      var result = await repository.getAllProvince();

      // assert
      verify(() => mockRemoteDataSource.getAllProvince());
      expect(result, equals(const Right(provinceResponse)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(() => mockRemoteDataSource.getAllProvince())
          .thenThrow(ServerException('message'));
      //act
      var result = await repository.getAllProvince();

      verify(() => mockRemoteDataSource.getAllProvince());
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('get all state codes', () {
    test(
        'should return List<int> when the call to remote data source is successful',
        () async {
      // arrange
      when(() => mockRemoteDataSource.getAllStateCodes())
          .thenAnswer((invocation) async => stateCodeResponse);
      // act
      var result = await repository.getAllStateCodes();

      // assert
      verify(() => mockRemoteDataSource.getAllStateCodes());
      expect(result, equals(const Right(stateCodeResponse)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(() => mockRemoteDataSource.getAllStateCodes())
          .thenThrow(ServerException('message'));
      //act
      var result = await repository.getAllStateCodes();

      verify(() => mockRemoteDataSource.getAllStateCodes());
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
