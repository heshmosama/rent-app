import 'dart:convert';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rent_flutter_task/features/home/data/models/account_model_response.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const accountModelResponse = AccountModelResponse(
      mName: 'name',
      mAccountId: '1',
      mAccountNumber: "123",
      mAddressCity: "cairo",
      mAddressComposite: "egypt, cairo",
      mAddressCountry: 'egypt',
      mAddressLine1: "cairo",
      mAddressPostalCode: "99494",
      mAddressStateOrProvince: "949",
      mEmail: 'hesham@gamil.com',
      mPhone: "94949499494",
      mStateCode: 494);

  test("should be subtype of AccountEntityResponse", () {
    expect(accountModelResponse, isA<AccountEntityResponse>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON is array of accounts',
      () async {
        // arrange
        final List<dynamic> jsonMap =
            json.decode(fixture('accounts_response.json'));
        // act
        final result =
            jsonMap.map((e) => AccountModelResponse.fromJson(e)).toList();

        // assert
        expect(result, [accountModelResponse]);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = accountModelResponse.toJson();
        // assert
        const expectedMap = {
          "name": "name",
          "email": "hesham@gamil.com",
          "phone": "94949499494",
          "addressComposite": "egypt, cairo",
          "accountNumber": "123",
          "stateCode": 494,
          "addressCity": "cairo",
          "addressLine1": "cairo",
          "addressStateOrProvince": "949",
          "addressPostalCode": "99494",
          "accountId": "1",
          "addressCountry": "egypt"
        };
        expect(result, expectedMap);
      },
    );
  });
}
