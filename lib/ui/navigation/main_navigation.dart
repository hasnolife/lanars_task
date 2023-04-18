import 'package:flutter/material.dart';
import 'package:lanars_task/ui/navigation/page_builder.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const details = '/details';
}

class MainNavigation {
  static final _screenFactory = PageBuilder();
  final routes = {
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeImageListPage(),
    // MainNavigationRouteNames.details: (_) => _screenFactory.makeImageDetailsPage(),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.details:
        final arguments = settings.arguments;
        final imageId = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeImageDetailsPage(imageId),
        );
      default:
        const widget = Text('Navigation Error');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}