import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/core/utils/extensions/pagination_scroll_mixin.dart';
import 'package:lanars_task/features/domain/entities/image_entity.dart';
import 'package:lanars_task/features/presentation/bloc/search_bloc/search_images_bloc.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';

class CustomSearchDelegate extends SearchDelegate with PaginationScrollMixin {
  CustomSearchDelegate() : super(searchFieldLabel: 'Searching for images...');
  String _prevQuery = '';
  final _suggestions = <String>[
    'Weather',
    'House',
    'Spase',
    'Computers',
    'Sport'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';

          showSuggestions(context);
          context.read<SearchImagesBloc>().add(ResetSearchImagesEvent());
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        tooltip: 'Back',
        onPressed: () => close(context, null));
  }

  _resetImages(BuildContext context) {
    _addEvent(context, ResetSearchImagesEvent());
  }

  void _searchImages(BuildContext context) {
    _addEvent(context, LoadSearchImagesEvent(searchQuery: query));
  }

  void _addEvent(BuildContext context, SearchImagesEvent event) {
    context.read<SearchImagesBloc>().add(event);
  }

  @override
  Widget buildResults(BuildContext context) {
    if (_prevQuery != query) {
      _prevQuery = query;
      _resetImages(context);
    }

    setScrollController(context, function: () => _searchImages(context));
    _searchImages(context);
    return BlocBuilder<SearchImagesBloc, SearchImagesState>(
      builder: (BuildContext context, state) {
        bool isLoading = false;
        var images = <ImageEntity>[];
        if (state is SearchImagesLoadingState && state.isFirstFetch) {
          return _buildLoading();
        } else if (state is SearchImagesLoadingState) {
          images = state.oldImages;
          isLoading = true;
        } else if (state is SearchImagesErrorState) {
          return ImageErrorWidget(
            onPressed: () => context
                .read<SearchImagesBloc>()
                .add(LoadSearchImagesEvent(searchQuery: query)),
            error: state.error,
          );
        } else if (state is SearchImagesDataState) {
          images = state.images;
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: images.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < images.length) {
              final imageData = images[index];
              return ListTile(
                key: ValueKey(imageData.id),
                title: Hero(
                  tag: imageData.id,
                  child: Image(
                    image: CachedNetworkImageProvider(
                      imageData.imageUrl,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                onTap: () {},
              );
            }
            jumpDownWhenLoading();
            return _buildLoading();
          },
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // if (query.isNotEmpty) {
    //   return Container();
    // }
    return ListView.separated(
      padding: const EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            query = _suggestions[index];
            showResults(context);
          },
          child: Text(
            _suggestions[index],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: _suggestions.length,
    );
  }
}
