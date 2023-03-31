part of 'images_list_bloc.dart';

@immutable
abstract class ImagesListState {}

class EmptyState extends ImagesListState {}
class ErrorState extends ImagesListState {
  final Object? error;

  ErrorState(this.error);
}

class DataState extends ImagesListState {
  final List<ImageModel> imagesList;

  DataState({
    required this.imagesList,
  });
}

class LoadingState extends ImagesListState {}
