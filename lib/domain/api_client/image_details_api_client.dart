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
    final json = response.data as Map<String, dynamic>;

    return ImageDetailsModel.fromJson(json);
  }
}
