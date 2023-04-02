import 'package:lanars_task/configuration/configuration.dart';
import 'package:lanars_task/domain/api_client/api_client.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';

class ImageDetailsApiClient extends ApiClient {
  ImageDetailsApiClient(super.dio);

  Future<ImageDetailsModel> getImageDetails(String imageId) async {
    final url =
        '${Configuration.unsplashUrl}${Configuration.imageListHeader}/$imageId';
    final queryParameters = {'client_id': Configuration.accessKey};
    final response = await getData(url, queryParameters);
    final data = response.data as Map<String, dynamic>;
    final imageUrl = data["urls"]["small"];
    final width = data["width"];
    final height = data["height"];
    final likes = data["likes"];
    final description = data["description"];
    final userName = data["user"]["name"];

    return ImageDetailsModel(
      id: imageId,
      imageUrl: imageUrl,
      width: width,
      height: height,
      likes: likes,
      description: description,
      userName: userName,
    );
  }
}