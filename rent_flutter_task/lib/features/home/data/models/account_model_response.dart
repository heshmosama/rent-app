import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/account_entity_response.dart';

part 'account_model_response.g.dart';

@JsonSerializable(ignoreUnannotated: false)
class AccountModelResponse extends AccountEntityResponse {
  @JsonKey(name: 'name')
  final String? mName;

  @JsonKey(name: 'accountId')
  final String? mAccountId;

  @JsonKey(name: 'accountNumber')
  final String? mAccountNumber;

  @JsonKey(name: 'addressCity')
  final String? mAddressCity;

  @JsonKey(name: 'addressComposite')
  final String? mAddressComposite;

  @JsonKey(name: 'addressCountry')
  final String? mAddressCountry;

  @JsonKey(name: 'addressLine1')
  final String? mAddressLine1;

  @JsonKey(name: 'addressPostalCode')
  final String? mAddressPostalCode;

  @JsonKey(name: 'addressStateOrProvince')
  final String? mAddressStateOrProvince;

  @JsonKey(name: 'email')
  final String? mEmail;

  @JsonKey(name: 'phone')
  final String? mPhone;

  @JsonKey(name: 'stateCode')
  final double? mStateCode;

  @JsonKey(name: 'imageUrl')
  final String? mImageUrl;

  const AccountModelResponse(
      {this.mName,
      this.mAccountId,
      this.mAccountNumber,
      this.mAddressCity,
      this.mAddressComposite,
      this.mAddressCountry,
      this.mAddressLine1,
      this.mAddressPostalCode,
      this.mAddressStateOrProvince,
      this.mEmail,
      this.mPhone,
      this.mStateCode,
      this.mImageUrl})
      : super(
            name: mName,
            accountId: mAccountId,
            accountNumber: mAccountNumber,
            addressCity: mAddressCity,
            addressComposite: mAddressComposite,
            addressCountry: mAddressCountry,
            addressLine1: mAddressLine1,
            addressPostalCode: mAddressPostalCode,
            addressStateOrProvince: mAddressStateOrProvince,
            email: mEmail,
            phone: mPhone,
            stateCode: mStateCode,
            imageUrl: mImageUrl);

  factory AccountModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelResponseToJson(this);
}
