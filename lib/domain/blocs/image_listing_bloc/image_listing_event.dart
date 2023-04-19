part of 'image_listing_bloc.dart';

@immutable
abstract class ImageListingEvent {}

class LoadListEvent extends ImageListingEvent {
  final Completer? completer;
  final String? query;
  final int page;

  LoadListEvent({required this.page, this.query, this.completer});
}
