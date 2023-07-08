part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
}

class EmptyState extends ImagesState {
  @override
  List<Object> get props => [];
}

class ErrorState extends ImagesState {
  final Object? error;

  @override
  List<Object?> get props => [error];

  ErrorState(this.error);
}

class DataState extends ImagesState {
  final List<ImageDetailsEntity> images;

  @override
  List<Object> get props => [images];

  DataState({
    required this.images,
  });
}

class LoadingState extends ImagesState {
  final List<ImageDetailsEntity> oldImages;
  final bool isFirstFetch;

  @override
  List<Object> get props => [oldImages, isFirstFetch];

  LoadingState({required this.oldImages, this.isFirstFetch = false});

}

