import 'package:flutter/material.dart';
import 'package:lanars_task/ui/navigation/main_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash Client',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      routes: MainNavigation.routes,
      initialRoute: MainNavigationRouteNames.mainScreen,
    );
  }
}