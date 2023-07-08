import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/presentation/navigation/routes.dart';
import 'package:lanars_task/features/presentation/pages/home_page.dart';
import 'package:lanars_task/features/presentation/pages/image_details_page.dart';

class AppRouter {
  static final goRouter =
      GoRouter(initialLocation: RouteNames.homePage, routes: [
    GoRoute(
        path: RouteNames.homePage,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        }),
    GoRoute(
        path: RouteNames.detailsPage,
        builder: (BuildContext context, GoRouterState state) {
          return ImageDetailsPage(imageDetails: state.extra as ImageDetailsEntity);
        }),
  ]);
}
