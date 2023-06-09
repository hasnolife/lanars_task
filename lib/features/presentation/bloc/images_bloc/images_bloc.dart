import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lanars_task/core/errors/failure.dart';
import 'package:lanars_task/core/utils/extensions/failure_parse_mixin.dart';
import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/domain/use_cases/get_all_image.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> with FailureParseMixin {
  final GetAllImages getAllImages;
  int _page = 1;

  ImagesBloc({required this.getAllImages}) : super(EmptyState()) {
    on<LoadImagesEvent>((event, emit) async {
      var oldImages = <ImageDetailsEntity>[];
      if (state is LoadingState) return;
      final currentState = state;
      // when page is 1 we don't need to add images to old list
      if (currentState is DataState && _page > 1) {
        oldImages = currentState.images;
      }
      emit(LoadingState(oldImages: oldImages, isFirstFetch: _page == 1));
      try {

        final newImages = await getAllImages(_page);
        final images = (state as LoadingState).oldImages..addAll(newImages);
        _page++;
        emit(DataState(images: images));
      } catch (e) {
        emit(ErrorState(mapFailureToMessage(e)));
      }
    });
    on<ResetImagesEvent>((event, emit) {
      _page = 1;
      add(LoadImagesEvent());
    });
  }
}
