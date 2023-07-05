import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/image_details_bloc/image_details_bloc.dart';
import 'package:lanars_task/domain/entity/image_model.dart';
import 'package:lanars_task/features/domain/entities/image_entity.dart';
import 'package:lanars_task/ui/widgets/image_details_widget.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';
import 'package:lanars_task/ui/widgets/interactive_image_widget.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({super.key, required this.imageModel});

  final ImageEntity imageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Hero(
            tag: imageModel.id,
            child: ImageDetailsFormWidget(
              image: InteractiveImageWidget(
                imageUrl: imageModel.imageUrl,
              ),
              description: [
                // Text('Image author : ${imageDetails.userName}'),
                // Text('Image size :  ${imageDetails.width} x ${imageDetails.width}'),
                // Text('Image has ${imageDetails.likes} likes'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
