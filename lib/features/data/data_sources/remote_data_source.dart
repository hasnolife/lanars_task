import 'package:dio/dio.dart';
import 'package:lanars_task/configuration/configuration.dart';
import 'package:lanars_task/core/errors/exceptions.dart';
import 'package:lanars_task/features/data/models/image_details_model.dart';

abstract class RemoteDataSource {
  /// Calls to 'https://api.unsplash.com/photos' endpoint.
  ///
  /// Throw [ServerException] for all error codes.
  Future<List<ImageDetailsModel>> getAllImages(int page);

  /// Calls to 'https://api.unsplash.com/search' endpoint.
  ///
  /// Throw [ServerException] for all error codes.
  Future<List<ImageDetailsModel>> searchImages(String query, int page);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final Dio _dio;

  RemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  Future<List<ImageDetailsModel>> _getImages(String url, Map<String, dynamic> queryParameters) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      final data = response.data as List;
      return data
          .map((imageDetailData) => ImageDetailsModel.fromJson(imageDetailData))
          .toList();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageDetailsModel>> getAllImages(int page) async {
    final queryParameters = {
      'client_id': Configuration.accessKey,
      'page': page,
    };
    return _getImages(Configuration.imagesUrl, queryParameters);
  }

  @override
  Future<List<ImageDetailsModel>> searchImages(String query, int page) async {
    final queryParameters = {
      'client_id': Configuration.accessKey,
      'page': page,
      'query': query,
    };
    return _getImages(Configuration.searchImagesUrl, queryParameters);
  }
}
