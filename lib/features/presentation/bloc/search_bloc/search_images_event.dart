part of 'search_images_bloc.dart';

abstract class SearchImagesEvent extends Equatable {
  const SearchImagesEvent();
}

class LoadSearchImagesEvent extends SearchImagesEvent {
  final String searchQuery;

  @override
  List<Object> get props => [searchQuery];

  const LoadSearchImagesEvent({
    required this.searchQuery,
  });
}

class ResetSearchImagesEvent extends SearchImagesEvent {
  @override
  List<Object> get props => [];
}