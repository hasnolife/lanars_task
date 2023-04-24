import 'package:flutter/material.dart';


class ImageDetailsFormWidget extends StatelessWidget {
  const ImageDetailsFormWidget({
    super.key,
    required this.image,
    this.description,
  });

  final Widget image;
  final List<Widget>? description;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: image,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children:
          description ?? [const CircularProgressIndicator()],),
        )
      ],
    );
  }
}
