import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/Images_list_bloc/images_list_bloc.dart';
import 'package:lanars_task/domain/entity/image_model.dart';
import 'package:lanars_task/ui/navigation/main_navigation.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';

class ImagesList extends StatefulWidget {
  const ImagesList({
    super.key,
  });

  @override
  State<ImagesList> createState() => _ImagesListState();
}

final scrollController = ScrollController();
List<ImageModel> images = [];

class _ImagesListState extends State<ImagesList> {
  void setScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          final bloc = context.read<ImagesListBloc>();

          bloc.add(LoadListEvent(page: bloc.page));
          scrollController.initialScrollOffset;
        }
      }
    });
  }

  Future<void> refresh() async {
    images.clear();
    context.read<ImagesListBloc>().add(LoadListEvent(page: 1));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImagesListBloc>();
    setScrollController();
    return RefreshIndicator(
      onRefresh: () async {
        final completer = Completer();
        bloc.add(LoadListEvent(page: 1, completer: completer));
        return completer.future;
      },
      child: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (state is DataState) {
            images = state.imagesList;
            return Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: images.length,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    onChanged: (value) =>
                        bloc.add(LoadListEvent(page: 1, query: value.trim())),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(150),
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
              onPressed: () => bloc.add(LoadListEvent(page: 1)),
              error: state.error,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
