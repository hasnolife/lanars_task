import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/image_listing_bloc/image_listing_bloc.dart';
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

class _ImagesListState extends State<ImagesList> {
  final scrollController = ScrollController();
  List<ImageModel> images = [];
  String searchQuery = '';

  void setScrollController() {
    final bloc = context.watch<ImageListingBloc>();
    scrollController.addListener(() {
      if (!bloc.isLoading &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        // setState(() {
        //   bloc.isLoading = true;
        // });
        bloc.add(LoadListEvent(page: bloc.page, query: searchQuery));
      }
    });
  }

  Future<void> refresh() async {
    images.clear();
    context.read<ImageListingBloc>().add(LoadListEvent(page: 1));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setScrollController();
    final bloc = context.read<ImageListingBloc>();
    final isLoading = context.select((ImageListingBloc bloc) => bloc.isLoading);

    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, state) {
        if (state is DataState) {
          images = List.from(state.imagesList);
          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              bloc.add(LoadListEvent(
                  page: 1, completer: completer, query: searchQuery));

              images = List.from(state.imagesList);
              return completer.future;
            },
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final imageData = images[index];
                    return ListTile(
                      key: ValueKey(index),
                      title: Image.network(imageData.imageUrl),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          MainNavigationRouteNames.details,
                          arguments: imageData.id,
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    onChanged: (value) {
                      searchQuery = value.trim();
                    },
                    onSubmitted: (value) {
                      searchQuery = value.trim();
                      images.clear();
                      bloc.add(LoadListEvent(page: 1, query: searchQuery));
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withAlpha(150),
                      border: const OutlineInputBorder(),
                      labelText: 'Search',
                    ),
                  ),
                ),
                if (isLoading)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
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
    );
  }
}
