import 'package:lanars_task/features/domain/entities/image_entity.dart';

class ImageDetailsEntity extends ImageEntity {
  final int width;
  final int height;
  final int likes;
  final String? description;
  final String userName;

  const ImageDetailsEntity({
    required super.id,
    required super.imageUrl,
    required this.width,
    required this.height,
    required this.likes,
    required this.description,
    required this.userName,
  });

  @override
  List<Object?> get props =>
      super.props + [width, height, likes, description, userName];
}
