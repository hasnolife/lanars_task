import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/features/presentation/bloc/search_bloc/search_images_bloc.dart';
import 'package:lanars_task/service_locator.dart' as di;
import 'package:lanars_task/features/presentation/bloc/images_bloc/images_bloc.dart';
import 'package:lanars_task/features/presentation/navigation/router_config.dart';

class UnsplashApp extends StatelessWidget {
  const UnsplashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagesBloc>(
          create: (context) => di.sl()..add(LoadImagesEvent()),
        ),
        BlocProvider<SearchImagesBloc>(
          create: (context) => di.sl(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Unsplash Client',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter.goRouter,
      ),
    );
  }
}
