import 'package:dio_example/bloc/home_bloc.dart';
import 'package:dio_example/bloc/home_event.dart';
import 'package:dio_example/bloc/home_state.dart';
import 'package:dio_example/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc _bloc;
  List<Post> items;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(HomeEventRequestData(q: ''));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dio Demo')),
      body: BlocBuilder<HomeBloc, HomeState>(
          bloc: _bloc,
          builder: (_, state) {
            if (state is HomeStateInitializing) {
              return Container();
            } else if (state is HomeStateLoading) {
              return _getLoadingIndicator();
            } else if (state is HomeStateError) {
              return _getErrorText(state.errorMessage);
            }

            items = (state as HomeStateSuccess).result;

            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(items[index].title),
                      subtitle: Text(items[index].body.substring(0, 50)));
                },
                separatorBuilder: (_, __) => Divider(),
                itemCount: items.length);
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () => _bloc.add(HomeEventRequestData(q: ''))),
    );
  }

  Widget _getLoadingIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _getErrorText(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: TextStyle(color: Colors.red, fontSize: 24),
      ),
    );
  }
}
