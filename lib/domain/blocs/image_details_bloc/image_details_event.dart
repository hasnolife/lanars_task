part of 'image_details_bloc.dart';

@immutable
abstract class ImageDetailsEvent {}

class LoadDetailsEvent extends ImageDetailsEvent {
  final String imageId;

  LoadDetailsEvent({
    required this.imageId,
  });
}