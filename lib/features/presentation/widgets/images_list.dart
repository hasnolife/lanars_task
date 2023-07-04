import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/features/domain/entities/image_entity.dart';
import 'package:lanars_task/features/presentation/bloc/images_bloc/images_bloc.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';

class ImagesList extends StatelessWidget {
  final _scrollController = ScrollController();

  ImagesList({super.key});

  void _setScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          context.read<ImagesBloc>().add(LoadImagesEvent());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _setScrollController(context);

    return BlocBuilder<ImagesBloc, ImagesState>(
      builder: (BuildContext context, state) {
        bool isLoading = false;
        var images = <ImageEntity>[];
        if (state is LoadingState && state.isFirstFetch) {
          return _buildLoading();
        } else if (state is LoadingState) {
          images = state.oldImages;
          isLoading = true;
        } else if (state is ErrorState) {
          return ImageErrorWidget(
            onPressed: () => context.read<ImagesBloc>().add(LoadImagesEvent()),
            error: state.error,
          );
        } else if (state is DataState) {
          images = state.images;
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ImagesBloc>().add(ResetImagesEvent());
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: images.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < images.length) {
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
                  onTap: () {},
                );
              }
              Timer(const Duration(milliseconds: 30), () {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });
              return _buildLoading();
            },
          ),
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
}
