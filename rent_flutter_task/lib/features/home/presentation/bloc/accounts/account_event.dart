import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_request_query.dart';

@immutable
abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllAccounts extends AccountEvent {
  final AccountEntityRequestQuery accountEntityRequestQuery;

  GetAllAccounts(this.accountEntityRequestQuery);

  @override
  List<Object> get props => [accountEntityRequestQuery];
}
