import 'package:equatable/equatable.dart';

class AccountEntityResponse extends Equatable {
  final String? name;

  final String? phone;

  final String? accountId;

  final String? accountNumber;

  final String? addressCity;

  final String? addressComposite;

  final String? addressCountry;

  final String? addressLine1;

  final String? addressPostalCode;

  final String? addressStateOrProvince;

  final String? email;

  final double? stateCode;
  final String? imageUrl;

  const AccountEntityResponse(
      {this.name,
      this.accountId,
      this.accountNumber,
      this.addressCity,
      this.addressComposite,
      this.addressCountry,
      this.addressLine1,
      this.addressPostalCode,
      this.addressStateOrProvince,
      this.email,
      this.phone,
      this.stateCode,
      this.imageUrl});

  @override
  List<Object?> get props => [
        name,
        accountId,
        accountNumber,
        addressCity,
        addressComposite,
        addressCountry,
        addressLine1,
        addressPostalCode,
        addressStateOrProvince,
        email,
        phone,
        stateCode,
        imageUrl
      ];
}
