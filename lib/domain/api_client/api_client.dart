import 'package:dio/dio.dart';
import 'package:lanars_task/configuration/configuration.dart';
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
}
