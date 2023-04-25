import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/image_listing_bloc/image_listing_bloc.dart';
import 'package:lanars_task/domain/entity/image_model.dart';
import 'package:lanars_task/ui/navigation/main_navigation.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';
import 'package:lanars_task/ui/widgets/search_widget.dart';

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
  late ImageListingBloc bloc;
  String searchQuery = '';

  void _onScroll() {
    if (!bloc.isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      setState(() {});
      _loadImages(page: bloc.page, query: searchQuery);
    }
  }

  void _searchImage(String value) {
    _loadImages(page: 1, query: searchQuery);
  }

  void _loadImages(
      {required int page, Completer? completer, String query = ''}) {
    _updateSearchQuery(query);
    bloc.add(LoadListEvent(
      page: page,
      completer: completer,
      query: searchQuery,
    ));
  }

  void _updateSearchQuery(String value) {
    searchQuery = value.trim();
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ImageListingBloc>();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((ImageListingBloc bloc) => bloc.isLoading);

    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, state) {
        if (state is DataState) {
          images = state.imagesList;
          return RefreshIndicator(
            onRefresh: () async {
              final completer = Completer();
              _loadImages(page: 1, completer: completer, query: searchQuery);

              return completer.future;
            },
            child: Stack(
              children: [
                buildImageListView(),
                buildSearchImage(),
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
            onPressed: () => _loadImages(page: 1),
            error: state.error,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  ListView buildImageListView() {
    return ListView.builder(
      controller: scrollController,
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageData = images[index];
        return ListTile(
          key: ValueKey(index),
          title: Hero(
            tag: imageData.id,
            child: Image(
              image: CachedNetworkImageProvider(
                imageData.imageUrl,
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              MainNavigationRouteNames.details,
              arguments: imageData,
            );
          },
        );
      },
    );
  }

  Widget buildSearchImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SearchWidget(
        onChanged: (value) {
          _updateSearchQuery(value);
        },
        onSubmitted: (value) {
          _searchImage(value);
        },
      ),
    );
  }
}

