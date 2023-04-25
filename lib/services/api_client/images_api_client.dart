import 'package:lanars_task/configuration/configuration.dart';
import 'package:lanars_task/domain/entity/image_model.dart';
import 'package:lanars_task/services/api_client/api_client.dart';

class ImagesApiClient extends ApiClient {
  ImagesApiClient(super.dio);

  Future<List<ImageModel>> getImagesList(int page,
      [String? searchQuery]) async {
    final isSearchMode = searchQuery != null && searchQuery.trim().isNotEmpty;
    final url =
        isSearchMode ? Configuration.searchImagesUrl : Configuration.imagesUrl;

    var queryParameters = {
      'client_id': Configuration.accessKey,
      'page': page,
    };
    if (isSearchMode) {
      queryParameters.addAll({'query': searchQuery});
    }

    final response = await getData(url, queryParameters);

    final data = (isSearchMode ? response.data["results"] : response.data)
        as List<dynamic>;

    final imagesList = data.map((imageData) {
      return ImageModel.fromJson(imageData);
    }).toList();

    return imagesList;
  }
}