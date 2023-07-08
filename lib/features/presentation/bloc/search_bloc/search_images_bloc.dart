import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lanars_task/core/errors/failure.dart';
import 'package:lanars_task/core/utils/extensions/failure_parse_mixin.dart';
import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/domain/use_cases/search_image.dart';

part 'search_images_event.dart';

part 'search_images_state.dart';

class SearchImagesBloc extends Bloc<SearchImagesEvent, SearchImagesState>
    with FailureParseMixin {
  final SearchImages searchImages;
  int _page = 1;

  SearchImagesBloc({required this.searchImages})
      : super(SearchImagesEmptyState()) {
    on<LoadSearchImagesEvent>((event, emit) async {
      var oldImages = <ImageDetailsEntity>[];
      if (state is SearchImagesLoadingState) return;
      final currentState = state;
      if (currentState is SearchImagesDataState && _page > 1) {
        oldImages = currentState.images;
      }
      emit(SearchImagesLoadingState(
          oldImages: oldImages, isFirstFetch: _page == 1));
      try {
        final newImages = await searchImages(event.searchQuery, _page);
        final images = (state as SearchImagesLoadingState).oldImages
          ..addAll(newImages);
        _page++;
        emit(SearchImagesDataState(images: images));
      } catch (e) {
        emit(SearchImagesErrorState(mapFailureToMessage(e)));
      }
    });
    on<ResetSearchImagesEvent>((event, emit) {
      _page = 1;
    });
  }
}
