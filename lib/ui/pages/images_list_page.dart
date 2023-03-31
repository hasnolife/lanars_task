import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/Images_list_bloc/images_list_bloc.dart';
import 'package:lanars_task/ui/navigation/main_navigation.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';

class ImagesListPage extends StatelessWidget {
  const ImagesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImagesListBloc>();
    return Scaffold(
      appBar: AppBar(),
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
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: state.imagesList.length,
                    itemBuilder: (context, index) {
                      final imageData = state.imagesList[index];
                      return ListTile(
                          title: Image.network(imageData.imageUrl),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              MainNavigationRouteNames.details,
                              arguments: imageData.id,
                            );
                          });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) =>
                          bloc.add(LoadListEvent(query: value.trim())),
                      // controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withAlpha(235),
                        border: const OutlineInputBorder(),
                        labelText: 'Search',
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ErrorState) {
              return ImageErrorWidget(
                onPressed: () => bloc.add(LoadListEvent()),
                error: state.error,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
