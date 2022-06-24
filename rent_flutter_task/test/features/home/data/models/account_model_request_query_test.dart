import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_request_query.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final accountModelRequestQuery = AccountModelRequestQuery(
      searchQuery: 'coffee', filterBy: json.encode({"stateCode": 0}));

  test('should return object subtype of AccountEntityRequestQuery', () {
    expect(accountModelRequestQuery, isA<Equatable>());
  });

  group('from json', () {
    test('should return a valid model when json is account query', () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('accounts_request_query.json'));
      // act
      final result = AccountModelRequestQuery.fromJson(jsonMap);

      // assert
      expect(result, accountModelRequestQuery);
    });
  });

  group('to json', () {
    test('should return a JSON map containing the proper data', () {
      // arrange
      final result = accountModelRequestQuery.toJson();

      // act
      const expectedMap = {
        "searchQuery": "coffee",
        "filterBy": "{\"stateCode\":0}"
      };

      // assert
      expect(result, expectedMap);
    });
  });
}
