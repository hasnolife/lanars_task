import 'package:dio/dio.dart';
import 'package:lanars_task/configuration/configuration.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';
import 'package:lanars_task/domain/entity/image_model.dart';

class ApiClient {
  final Dio _dio = Dio();

  // ApiClient(this._dio);

  Future<List<ImageModel>> getImagesList() async {
    final response = await _dio.get(Configuration.imageListUrl,
        queryParameters: {'client_id': Configuration.accessKey});

    final data = response.data as List<dynamic>;
    final imagesList = data.map((imageData) {
      final smallUrl = imageData["urls"]["small"];
      final id = imageData["id"];

      return ImageModel(
        imageUrl: smallUrl,
        id: id,
      );
    }).toList();

    return imagesList;
  }

  Future<ImageDetailsModel> getImageDetails(String imageId) async {
    final response = await _dio.get('${Configuration.imageListUrl}/$imageId',
        queryParameters: {'client_id': Configuration.accessKey});

    final data = response.data as Map<String, dynamic>;
    final imageUrl = data["urls"]["full"];
    final width = data["width"];
    final height = data["height"];
    final likes = data["likes"];
    final description = data["description"];
    final userName = data["user"]["name"];

    return ImageDetailsModel(id: imageId,
      imageUrl: imageUrl,
      width: width,
      height: height,
      likes: likes,
      description: description,
      userName: userName,);
  }

}
