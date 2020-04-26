import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HomeEvent extends Equatable {
}

class HomeEventRequestData extends HomeEvent {

  final String q;

  HomeEventRequestData({@required this.q});

  @override
  List<Object> get props => [q];
}