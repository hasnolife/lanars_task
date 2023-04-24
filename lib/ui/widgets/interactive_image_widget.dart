import 'package:flutter/material.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';
import 'package:photo_view/photo_view.dart';

class InteractiveImageWidget extends StatelessWidget {
  const InteractiveImageWidget({
    required this.imageDetails,
    super.key,
  });

  final ImageDetailsModel imageDetails;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageDetails.id,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! > 20) {
            Navigator.of(context).pop();
          }
        },
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          imageProvider: NetworkImage(
            imageDetails.imageUrl,
          ),
        ),
      ),
    );
  }
}
