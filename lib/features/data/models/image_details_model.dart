import 'package:lanars_task/features/domain/entities/image_details_entity.dart';

class ImageDetailsModel extends ImageDetailsEntity {
  const ImageDetailsModel({required super.id,
    required super.imageUrl,
    required super.width,
    required super.height,
    required super.likes,
    required super.description,
    required super.userName});

  factory ImageDetailsModel.fromJson(Map<String, dynamic> json) =>
      ImageDetailsModel(
        id: json["id"],
        imageUrl: json["urls"]["small"],
        width: json["width"],
        height: json["height"],
        likes: json["likes"],
        description: json["description"],
        userName: json["user"]["name"],
      );

}
