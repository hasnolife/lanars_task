import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String imageUrl;
  final String id;

  const ImageEntity({
    required this.imageUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [imageUrl, id];
}