
import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/domain/repositories/image_repository.dart';

abstract class SearchImageUseCase {
  Future<List<ImageDetailsEntity>> call(String query, int page);
}

class SearchImages extends SearchImageUseCase {
  final ImageRepository _imageRepository;

  SearchImages(this._imageRepository);

  @override
  Future<List<ImageDetailsEntity>> call(String query, int page) async =>
      await _imageRepository.searchImage(query, page);
}
