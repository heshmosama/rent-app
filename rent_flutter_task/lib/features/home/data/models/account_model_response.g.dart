// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModelResponse _$AccountModelResponseFromJson(
        Map<String, dynamic> json) =>
    AccountModelResponse(
      mName: json['name'] as String?,
      mAccountId: json['accountId'] as String?,
      mAccountNumber: json['accountNumber'] as String?,
      mAddressCity: json['addressCity'] as String?,
      mAddressComposite: json['addressComposite'] as String?,
      mAddressCountry: json['addressCountry'] as String?,
      mAddressLine1: json['addressLine1'] as String?,
      mAddressPostalCode: json['addressPostalCode'] as String?,
      mAddressStateOrProvince: json['addressStateOrProvince'] as String?,
      mEmail: json['email'] as String?,
      mPhone: json['phone'] as String?,
      mStateCode: (json['stateCode'] as num?)?.toDouble(),
      mImageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$AccountModelResponseToJson(
        AccountModelResponse instance) =>
    <String, dynamic>{
      'name': instance.mName,
      'accountId': instance.mAccountId,
      'accountNumber': instance.mAccountNumber,
      'addressCity': instance.mAddressCity,
      'addressComposite': instance.mAddressComposite,
      'addressCountry': instance.mAddressCountry,
      'addressLine1': instance.mAddressLine1,
      'addressPostalCode': instance.mAddressPostalCode,
      'addressStateOrProvince': instance.mAddressStateOrProvince,
      'email': instance.mEmail,
      'phone': instance.mPhone,
      'stateCode': instance.mStateCode,
      'imageUrl': instance.mImageUrl,
    };
