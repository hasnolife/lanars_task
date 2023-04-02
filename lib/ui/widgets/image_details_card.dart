
import 'package:flutter/material.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';

class ImageDetailsCard extends StatelessWidget {
  const ImageDetailsCard({
    super.key,
    required this.imageDetails,
  });

  final ImageDetailsModel imageDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InteractiveViewer(
          child: Image.network(
            imageDetails.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        Text('Image author : ${imageDetails.userName}'),
        Text(
            'Image size :  ${imageDetails.width} x ${imageDetails.width}'),
        Text('Image has ${imageDetails.likes} likes'),
      ],
    );
  }
}
