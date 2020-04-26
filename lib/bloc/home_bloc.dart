import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_example/bloc/home_event.dart';
import 'package:dio_example/bloc/home_state.dart';
import 'package:dio_example/models/post.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Dio dio;

  HomeBloc({@required this.dio});

  @override
  HomeState get initialState => HomeStateInitializing();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventRequestData) {
      yield HomeStateLoading();

      Response response;

      try {
        response = await dio.get('https://jsonplaceholder.typicode.com/posts');
      } on DioError catch (_) {
        yield HomeStateError(errorMessage: 'Something wrong happened');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<Post> result = [];
        var decoded = json.decode(response.data);
        for (var item in decoded) {
          final post = Post.fromDecoded(item);
          result.add(post);
        }
        yield HomeStateSuccess(result: result);
      } else {
        final message = response.statusMessage;
        yield HomeStateError(errorMessage: message);
      }
    }
  }
}
