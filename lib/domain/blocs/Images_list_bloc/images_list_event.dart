part of 'images_list_bloc.dart';

@immutable
abstract class ImagesListEvent {}

class LoadListEvent extends ImagesListEvent {
  final Completer? completer;

  LoadListEvent({this.completer});
}
