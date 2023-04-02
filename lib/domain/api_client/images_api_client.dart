import 'package:lanars_task/configuration/configuration.dart';
import 'package:lanars_task/domain/api_client/api_client.dart';
import 'package:lanars_task/domain/entity/image_model.dart';

class ImagesApiClient extends ApiClient {
  ImagesApiClient(super.dio);

  Future<List<ImageModel>> getImagesList(int page,
      [String? searchQuery]) async {
    final isSearchMode = searchQuery != null && searchQuery.trim().isNotEmpty;
    final url = isSearchMode
        ? Configuration.unsplashUrl +
            Configuration.searchHeader +
            Configuration.imageListHeader
        : Configuration.unsplashUrl + Configuration.imageListHeader;

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
