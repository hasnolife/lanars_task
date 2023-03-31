import 'package:lanars_task/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const mainScreen = '/';
  static const details = '/details';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  static final routes = {
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeImageListPage(),
    MainNavigationRouteNames.details: (_) => _screenFactory.makeImageDetailsPage(),
  };

}