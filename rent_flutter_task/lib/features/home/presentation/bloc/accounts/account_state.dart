import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';

@immutable
abstract class AccountState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends AccountState {}

class Loading extends AccountState {}

class Loaded extends AccountState {
  final List<AccountEntityResponse> accounts;

  Loaded({required this.accounts});

  @override
  List<Object> get props => [accounts];
}

class Error extends AccountState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
