

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/api_client/api_client.dart';
import 'package:lanars_task/domain/entity/image_model.dart';

part 'images_list_event.dart';
part 'images_list_state.dart';

class ImagesListBloc extends Bloc<ImagesListEvent, ImagesListState> {
  ImagesListBloc() : super(EmptyState()) {
    on<LoadListEvent>((event, emit) async{
      if (state is! DataState) {
        emit(LoadingState());
      }
      final imagesList = await _apiClient.getImagesList();
      emit(DataState(imagesList: imagesList));
    });
    add(LoadListEvent());
  }
  final _apiClient = ApiClient();
}
