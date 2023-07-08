part of 'search_images_bloc.dart';

abstract class SearchImagesState extends Equatable {
  const SearchImagesState();
}

class SearchImagesEmptyState extends SearchImagesState {
  @override
  List<Object> get props => [];
}

class SearchImagesDataState extends SearchImagesState {
  final List<ImageDetailsEntity> images;

  @override
  List<Object> get props => [images];

  const SearchImagesDataState({
    required this.images,
  });
}
class SearchImagesErrorState extends SearchImagesState {
  final Object? error;

  const SearchImagesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
class SearchImagesLoadingState extends SearchImagesState {
  final List<ImageDetailsEntity> oldImages;
  final bool isFirstFetch;

  @override
  List<Object> get props => [oldImages, isFirstFetch];

  const SearchImagesLoadingState({
    required this.oldImages,
    this.isFirstFetch = false,
  });
}
