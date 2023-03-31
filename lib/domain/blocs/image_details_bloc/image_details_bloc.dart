
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/api_client/api_client.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';

part 'image_details_event.dart';
part 'image_details_state.dart';

class ImageDetailsBloc extends Bloc<ImageDetailsEvent, ImageDetailsState> {
  ImageDetailsBloc(this.imageId) : super(EmptyState()) {
    on<LoadDetailsEvent>((event, emit) async{
      final imageDetails = await _apiClient.getImageDetails(imageId);
      emit(DataState(imageDetails: imageDetails));
    });
    add(LoadDetailsEvent(imageId: imageId));
  }
  final _apiClient = ApiClient();
  final String imageId;
}
