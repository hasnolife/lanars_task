part of 'images_bloc.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();
}

class LoadImagesEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class ResetImagesEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}