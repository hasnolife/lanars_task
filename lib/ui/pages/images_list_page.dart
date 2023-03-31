import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/Images_list_bloc/images_list_bloc.dart';

class ImagesListPage extends StatelessWidget {
  const ImagesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ImagesListBloc();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          bloc.add(LoadListEvent(completer: completer));
          return completer.future;
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, state) {
            if (state is DataState) {
              return ListView.builder(
                itemCount: state.imagesList.length,
                itemBuilder: (context, index) {
                  final imageData = state.imagesList[index];
                 return ListTile(
                   title: Image.network(imageData.imageUrl),
                   // subtitle: Text(imageData.description ?? ''),

                 );
                },
              );
            }
            if (state is ErrorState) {
              return Container();
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
