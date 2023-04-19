import 'package:dio/dio.dart';


class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response<dynamic>> getData(url,
      [Map<String, dynamic>? queryParameters]) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }
}
