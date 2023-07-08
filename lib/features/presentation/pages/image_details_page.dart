import 'package:flutter/material.dart';
import 'package:lanars_task/features/domain/entities/image_details_entity.dart';
import 'package:lanars_task/features/presentation/widgets/image_details_widget.dart';
import 'package:lanars_task/features/presentation/widgets/interactive_image_widget.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({super.key, required this.imageDetails});

  final ImageDetailsEntity imageDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Hero(
            tag: imageDetails.id,
            child: ImageDetailsFormWidget(
              image: InteractiveImageWidget(
                imageUrl: imageDetails.imageUrl,
              ),
              description: [
                Text('Image author : ${imageDetails.userName}'),
                Text('Image size :  ${imageDetails.width} x ${imageDetails.width}'),
                Text('Image has ${imageDetails.likes} likes'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
