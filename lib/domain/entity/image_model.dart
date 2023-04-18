class ImageModel {
  final String imageUrl;
  final String id;

  const ImageModel({
    required this.imageUrl,
    required this.id,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageUrl: json["urls"]["small"],
      id: json["id"],
    );
  }
}
