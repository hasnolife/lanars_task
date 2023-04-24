import 'package:flutter/material.dart';
import 'package:lanars_task/domain/entity/image_details_model.dart';
import 'package:lanars_task/ui/widgets/interactive_image_widget.dart';

class ImageDetailsWidget extends StatelessWidget {
  const ImageDetailsWidget({
    super.key,
    required this.imageDetails,
  });

  final ImageDetailsModel imageDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InteractiveImageWidget(imageDetails: imageDetails),
        ),
        Text('Image author : ${imageDetails.userName}'),
        Text('Image size :  ${imageDetails.width} x ${imageDetails.width}'),
        Text('Image has ${imageDetails.likes} likes'),
      ],
    );
  }
}

