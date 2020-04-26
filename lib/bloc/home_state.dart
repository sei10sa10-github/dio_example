import 'package:dio_example/models/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class HomeState extends Equatable {
}

class HomeStateInitializing extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeStateLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeStateSuccess extends HomeState {

  final List<Post> result;

  HomeStateSuccess({@required this.result});

  @override
  List<Object> get props => [result];
}

class HomeStateError extends HomeState {

  final String errorMessage;

  HomeStateError({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}