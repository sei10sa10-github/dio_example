import 'package:dio/dio.dart';
import 'package:dio_example/bloc/home_bloc.dart';
import 'package:dio_example/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dio = _createDio();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(dio: dio),
        child: Home()
      ),
    );
  }

  Dio _createDio() {
    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      responseType: ResponseType.plain
    );

    final dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) async {
        dio.lock();
        print('dio.lock');
        await Future.delayed(Duration(milliseconds: 1000));
        print('dio.unlock');
        dio.unlock();
        return options;
      },
      onResponse: (response) async {
        print('status == ${response.statusCode}');
      },
      onError: (e) async {
        print('status == ${e.response.statusCode}');
      }
    ));
    return dio;
  }
}