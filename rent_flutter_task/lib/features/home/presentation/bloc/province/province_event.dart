import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProvinceEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllProvinceEvent extends ProvinceEvent {}
