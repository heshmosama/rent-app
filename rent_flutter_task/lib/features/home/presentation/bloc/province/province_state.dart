import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProvinceState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends ProvinceState {}

class Loading extends ProvinceState {}

class Loaded extends ProvinceState {
  final List<String> provinces;

  Loaded({required this.provinces});

  @override
  List<Object> get props => [provinces];
}

class Error extends ProvinceState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
