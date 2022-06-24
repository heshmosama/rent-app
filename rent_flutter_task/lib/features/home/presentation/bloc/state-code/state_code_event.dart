import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class StateCodeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllStateCodeEvent extends StateCodeEvent {}
