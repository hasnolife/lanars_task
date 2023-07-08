import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/domain/repositories/image_repository.dart';

abstract class GetAllImageUseCase {
  Future<List<ImageDetailsEntity>> call(int page);
}

class GetAllImages extends GetAllImageUseCase {
  final ImageRepository _imageRepository;

  GetAllImages(this._imageRepository);

  @override
  Future<List<ImageDetailsEntity>> call(int page) async =>
      await _imageRepository.getAllImages(page);
}
