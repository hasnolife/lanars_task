import 'package:lanars_task/core/errors/exceptions.dart';
import 'package:lanars_task/core/errors/failure.dart';
import 'package:lanars_task/features/data/data_sources/remote_data_source.dart';
import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  final RemoteDataSource remoteDataSource;

  @override
  Future<List<ImageDetailsEntity>> getAllImages(int page) async {
    try {
      return await remoteDataSource.getAllImages(page);
    } on ServerException catch (e) {
      throw ServerFailure();
    }
  }

  @override
  Future<List<ImageDetailsEntity>> searchImage(String searchQuery, int page) async {
    try {
      return await remoteDataSource.searchImages(searchQuery, page);
    } on ServerException catch (e) {
      throw ServerFailure();
    }
  }

  const ImageRepositoryImpl({
    required this.remoteDataSource,
  });
}
