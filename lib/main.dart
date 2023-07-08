import 'package:flutter/material.dart';
import 'package:lanars_task/features/presentation/widgets/unsplash_app.dart';
import 'service_locator.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const UnsplashApp());
}
