import 'package:flutter/material.dart';
import 'package:lanars_task/ui/widgets/my_app.dart';
import 'service_locator.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}
