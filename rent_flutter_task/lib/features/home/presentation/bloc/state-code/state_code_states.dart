import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class StateCodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends StateCodeState {}

class Loading extends StateCodeState {}

class Loaded extends StateCodeState {
  final List<int> codes;

  Loaded({required this.codes});

  @override
  List<Object> get props => [codes];
}

class Error extends StateCodeState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
