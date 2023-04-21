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

  void setScrollController() {
    final bloc = context.watch<ImageListingBloc>();
    scrollController.addListener(() {
      if (!bloc.isLoading &&
          scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        bloc.isLoading = true;
        bloc.add(LoadListEvent(page: bloc.page));
      }
    });
  }

  Future<void> refresh() async {
    images.clear();
    context.read<ImageListingBloc>().add(LoadListEvent(page: 1));
  }

@override
  void didChangeDependencies() {
  setScrollController();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageListingBloc>();

    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, state) {
        if (state is DataState) {
          images.addAll(state.imagesList);
          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              images.clear();
              bloc.add(LoadListEvent(page: 1, completer: completer));
              await completer.future;
            },
            child: Stack(
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: images.length + 1,
                  itemBuilder: (context, index) {
                    if (index == images.length) {
                      if (bloc.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                    final imageData = images[index];
                    return ListTile(
                        key: ValueKey(index),
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
