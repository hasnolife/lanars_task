import 'package:flutter/material.dart';
import 'package:lanars_task/ui/widgets/images_list.dart';

class ImageListingPage extends StatelessWidget {
  const ImageListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: ImagesList()),
    );
  }
}