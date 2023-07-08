import 'package:lanars_task/features/domain/entities/image_details_entity.dart';

abstract class ImageRepository {
  Future<List<ImageDetailsEntity>> getAllImages(int page);

  Future<List<ImageDetailsEntity>> searchImage(String searchQuery, int page);
}
