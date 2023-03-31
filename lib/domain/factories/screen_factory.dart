import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/Images_list_bloc/images_list_bloc.dart';
import 'package:lanars_task/domain/blocs/image_details_bloc/image_details_bloc.dart';
import 'package:lanars_task/ui/pages/image_details_page.dart';
import 'package:lanars_task/ui/pages/images_list_page.dart';

class ScreenFactory {
  Widget makeImageListPage() {
    return BlocProvider<ImagesListBloc>(
      create: (_) => ImagesListBloc(),
      child: const ImagesListPage(),
    );
  }
  Widget makeImageDetailsPage(String imageId) {
    return BlocProvider<ImageDetailsBloc>(
      create: (_) => ImageDetailsBloc(imageId),
      child: const ImageDetailsPage(),
    );
  }

}