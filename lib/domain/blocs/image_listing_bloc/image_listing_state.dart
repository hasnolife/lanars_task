part of 'image_listing_bloc.dart';

@immutable
abstract class ImageListingState {}

class EmptyState extends ImageListingState {}
class ErrorState extends ImageListingState {
  final Object? error;

  ErrorState(this.error);
}

class DataState extends ImageListingState {
  final List<ImageModel> imagesList;

  DataState({
    required this.imagesList,
  });
}

class LoadingState extends ImageListingState {}
