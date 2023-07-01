import 'package:lanars_task/features/domain/entities/image_entity.dart';

abstract class ImageRepository {
  Future<List<ImageEntity>> getAllImages(int page);

  Future<List<ImageEntity>> searchImage(String searchQuery, int page);
}
