import 'package:flutter/material.dart';
import 'package:lanars_task/ui/navigation/main_navigation.dart';

class UnsplashApp extends StatelessWidget {
  const UnsplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return MaterialApp(
      title: 'Unsplash Client',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: mainNavigation.routes,
      initialRoute: MainNavigationRouteNames.mainScreen,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}