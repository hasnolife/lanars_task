import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart' as dio;
import 'package:lanars_task/domain/api_client/api_client.dart';
import 'package:lanars_task/domain/api_client/image_details_api_client.dart';
import 'package:lanars_task/domain/api_client/images_api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton(() => ImagesApiClient(sl()));
  sl.registerLazySingleton(() => ImageDetailsApiClient(sl()));

  sl.registerLazySingleton<ApiClient>(
          () => ApiClient(sl()));

  sl.registerLazySingleton(() => dio.Dio());
}