import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/Image_listing_bloc/Image_listing_bloc.dart';
import 'package:lanars_task/domain/blocs/image_details_bloc/image_details_bloc.dart';
import 'package:lanars_task/service_locator.dart';
import 'package:lanars_task/ui/pages/image_details_page.dart';
import 'package:lanars_task/ui/pages/image_listing_page.dart';

class PageBuilder {
  Widget makeImageListPage() {
    return BlocProvider<ImageListingBloc>(
      create: (_) => ImageListingBloc(apiClient: sl()),
      child: const ImageListingPage(),
    );
  }

  Widget makeImageDetailsPage(String imageId) {
    return BlocProvider<ImageDetailsBloc>(
      create: (_) => ImageDetailsBloc(
        imageId: imageId,
        apiClient: sl(),
      ),
      child: ImageDetailsPage(imageId: imageId),
    );
  }
}
