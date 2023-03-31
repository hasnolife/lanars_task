import 'package:lanars_task/domain/entity/image_model.dart';

class ImageDetailsModel extends ImageModel {
  final int width;
  final int height;
  final int likes;
  final String? description;
  final String userName;

  const ImageDetailsModel({
    required super.id,
    required super.imageUrl,
    required this.width,
    required this.height,
    required this.likes,
    required this.description,
    required this.userName,
  });
}