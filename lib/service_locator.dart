import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lanars_task/features/data/data_sources/remote_data_source.dart';
import 'package:lanars_task/features/data/repositories/image_repository_impl.dart';
import 'package:lanars_task/features/domain/repositories/image_repository.dart';
import 'package:lanars_task/features/domain/use_cases/get_all_image.dart';
import 'package:lanars_task/features/domain/use_cases/search_image.dart';
import 'package:lanars_task/features/presentation/bloc/images_bloc/images_bloc.dart';
import 'package:lanars_task/features/presentation/bloc/search_bloc/search_images_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc and Cubit
  sl.registerFactory(() => ImagesBloc(getAllImages: sl()));
  sl.registerFactory(() => SearchImagesBloc(searchImages: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllImages(sl()));
  sl.registerLazySingleton(() => SearchImages(sl()));

  // Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}
