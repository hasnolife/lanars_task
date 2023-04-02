import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/api_client/images_api_client.dart';
import 'package:lanars_task/domain/entity/image_model.dart';

part 'images_list_event.dart';

part 'images_list_state.dart';

class ImagesListBloc extends Bloc<ImagesListEvent, ImagesListState> {
  final ImagesApiClient apiClient;
  int page = 1;

  ImagesListBloc({required this.apiClient}) : super(EmptyState()) {
    on<LoadListEvent>((event, emit) async {
      try {
        if (state is! DataState) {
          emit(LoadingState());
        }
        List<ImageModel> imagesList = [];
        page = event.page;
        if (event.query != null && event.query!.isNotEmpty) {
          imagesList = await apiClient.getImagesList(page, event.query!);
        } else {
          imagesList.addAll(await apiClient.getImagesList(page));
          page++;
        }
        emit(DataState(imagesList: imagesList));
      } catch (e) {
        emit(ErrorState(e));
      } finally {
        event.completer?.complete();
      }
    });

    add(LoadListEvent(page: page));
  }
}