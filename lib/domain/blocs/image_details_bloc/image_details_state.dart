part of 'image_details_bloc.dart';

@immutable
abstract class ImageDetailsState {}

class EmptyState extends ImageDetailsState {}
class ErrorState extends ImageDetailsState {
  final Object? error;

  ErrorState(this.error);
}

class DataState extends ImageDetailsState {
  final ImageDetailsModel imageDetails;

  DataState({
    required this.imageDetails,
  });
}

class LoadingState extends ImageDetailsState {}

