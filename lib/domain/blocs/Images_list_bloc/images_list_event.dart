part of 'images_list_bloc.dart';

@immutable
abstract class ImagesListEvent {}

class LoadListEvent extends ImagesListEvent {
  final Completer? completer;
  final String? query;

  LoadListEvent({this.query, this.completer});
}
