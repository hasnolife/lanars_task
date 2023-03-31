import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/api_client/api_client.dart';
import 'package:lanars_task/domain/entity/image_model.dart';

part 'images_list_event.dart';

part 'images_list_state.dart';

class ImagesListBloc extends Bloc<ImagesListEvent, ImagesListState> {
  ImagesListBloc() : super(EmptyState()) {
    on<LoadListEvent>((event, emit) async {
      try {
        if (state is! DataState) {
          emit(LoadingState());
        }
        List<ImageModel> imagesList = [];
        if (event.query != null && event.query!.isNotEmpty) {
          imagesList = await _apiClient.getSearchList(event.query!);
        } else {
          imagesList = await _apiClient.getImagesList();
        }
        emit(DataState(imagesList: imagesList));
      } catch (e) {
        emit(ErrorState(e));
      } finally {
        event.completer?.complete();
      }
    });

    add(LoadListEvent());
  }

  final _apiClient = ApiClient();
}
