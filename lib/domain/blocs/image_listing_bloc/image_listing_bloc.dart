import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/entity/image_model.dart';
import 'package:lanars_task/services/api_client/images_api_client.dart';

part 'image_listing_event.dart';

part 'image_listing_state.dart';

class ImageListingBloc extends Bloc<ImageListingEvent, ImageListingState> {
  final ImagesApiClient apiClient;
  int page = 1;
  bool isLoading = false;
  List<ImageModel> _imagesList = [];
  ImageListingBloc({required this.apiClient}) : super(EmptyState()) {
    on<LoadListEvent>((event, emit) async {

      try {
        if (state is! DataState) {
          emit(LoadingState());
        }

        page = event.page;
        if (event.query != null && event.query!.isNotEmpty) {
          _imagesList = await apiClient.getImagesList(page, event.query);
        } else {
          _imagesList = await apiClient.getImagesList(page);
          page++;
        }
        emit(DataState(imagesList: _imagesList));
      } catch (e) {
        emit(ErrorState(e));
      } finally {
        isLoading = false;
        event.completer?.complete();
      }
    });

    add(LoadListEvent(page: page));
  }
}