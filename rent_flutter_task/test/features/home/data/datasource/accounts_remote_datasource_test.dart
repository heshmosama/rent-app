import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rent_flutter_task/core/error/exceptions.dart';
import 'package:rent_flutter_task/features/home/data/datasource/remote/service/accounts_network_service.dart';
import 'package:rent_flutter_task/features/home/data/datasource/remote/soruce/account_datasource_impl.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRetrofitClient extends Mock implements AccountService {}

void main() {
  late AccountDataSourceImpl dataSource;
  late MockRetrofitClient mockHttpClient;
  late List<AccountModelResponse> accountsResponse;
  const accountModelRequestQuery = AccountModelRequestQuery(
      searchQuery: 'c', filterBy: "{\"stateCode : 0\"}");
  const List<String> provinceResponse = ['WA'];
  const List<int> stateCodeResponse = [0];
  setUpAll(() async {
    // configureDependencies(Environment.test);
    registerFallbackValue(Uri());
    mockHttpClient = MockRetrofitClient();
    dataSource = AccountDataSourceImpl(mockHttpClient);
    accountsResponse =
        (json.decode(fixture('accounts_response.json')) as List<dynamic>)
            .map((e) => AccountModelResponse.fromJson(e))
            .toList();
  });

  group('get accounts', () {
    test("should get accounts", () async {
      when(() => mockHttpClient.getAllAccounts(accountModelRequestQuery))
          .thenAnswer((_) async => accountsResponse);

      await dataSource.getAllAccounts(accountModelRequestQuery);

      verify(() => mockHttpClient.getAllAccounts(accountModelRequestQuery));
      verifyNoMoreInteractions(mockHttpClient);
    });

    test(
      'should return List<AccountModelResponse> when the response is 200 (success)',
      () async {
        // arrange
        when(
          () => mockHttpClient.getAllAccounts(accountModelRequestQuery),
        ).thenAnswer(
          (_) async => accountsResponse,
        );
        // act
        final response =
            await dataSource.getAllAccounts(accountModelRequestQuery);
        // assert
        expect(response, accountsResponse);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other (unsuccess)',
      () async {
        // arrange
        when(() => mockHttpClient.getAllAccounts(accountModelRequestQuery))
            .thenThrow(
          DioError(
            response: Response(
              data: 'Something went wrong',
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        // act
        final call = dataSource.getAllAccounts;

        // assert
        expect(
          () => call(accountModelRequestQuery),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('get all province', () {
    test("should get all provinces", () async {
      when(() => mockHttpClient.getAllProvince())
          .thenAnswer((_) async => provinceResponse);

      await dataSource.getAllProvince();

      verify(() => mockHttpClient.getAllProvince());
    });

    test('should return List<String> when the response is 200 (success)',
        () async {
      // arrange
      when(
        () => mockHttpClient.getAllProvince(),
      ).thenAnswer(
        (_) async => provinceResponse,
      );
      // act
      final response = await dataSource.getAllProvince();
      // assert
      expect(response, provinceResponse);
    });

    test(
      'should throw a ServerException when the response code is 404 or other (unsuccess)',
      () async {
        // arrange
        when(() => mockHttpClient.getAllProvince()).thenThrow(
          DioError(
            response: Response(
              data: 'Something went wrong',
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        // act
        final call = dataSource.getAllProvince;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });

  group('gat all state codes', () {
    test("should get all state code", () async {
      when(() => mockHttpClient.getAllStateCode())
          .thenAnswer((_) async => stateCodeResponse);

      await dataSource.getAllStateCodes();

      verify(() => mockHttpClient.getAllStateCode());
    });

    test('should return List<int> when the response is 200 (success)',
        () async {
      // arrange
      when(
        () => mockHttpClient.getAllStateCode(),
      ).thenAnswer(
        (_) async => stateCodeResponse,
      );
      // act
      final response = await dataSource.getAllStateCodes();
      // assert
      expect(response, stateCodeResponse);
    });

    test(
      'should throw a ServerException when the response code is 404 or other (unsuccess)',
      () async {
        // arrange
        when(() => mockHttpClient.getAllStateCode()).thenThrow(
          DioError(
            response: Response(
              data: 'Something went wrong',
              statusCode: 404,
              requestOptions: RequestOptions(path: ''),
            ),
            requestOptions: RequestOptions(path: ''),
          ),
        );
        // act
        final call = dataSource.getAllStateCodes;

        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
