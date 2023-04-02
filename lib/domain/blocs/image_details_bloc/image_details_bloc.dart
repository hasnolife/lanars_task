
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/api_client/image_details_api_client.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';

part 'image_details_event.dart';
part 'image_details_state.dart';

class ImageDetailsBloc extends Bloc<ImageDetailsEvent, ImageDetailsState> {
  ImageDetailsBloc({required this.imageId, required this.apiClient}) : super(EmptyState()) {
    on<LoadDetailsEvent>((event, emit) async{
      try {
        final imageDetails = await apiClient.getImageDetails(imageId);
        emit(DataState(imageDetails: imageDetails));
      } catch (e) {
        emit(ErrorState(e));
      }
    });
    add(LoadDetailsEvent(imageId: imageId));
  }
  final ImageDetailsApiClient apiClient;
  final String imageId;
}
