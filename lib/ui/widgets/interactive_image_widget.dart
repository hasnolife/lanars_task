import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class InteractiveImageWidget extends StatelessWidget {
  const InteractiveImageWidget({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! > 20) {
          Navigator.of(context).pop();
        }
      },
      child: PhotoView(
        backgroundDecoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        imageProvider: CachedNetworkImageProvider(
          imageUrl,
        ),
      ),
    );
  }
}
