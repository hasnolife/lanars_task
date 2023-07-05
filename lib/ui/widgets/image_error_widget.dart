import 'package:flutter/material.dart';

class ImageErrorWidget extends StatelessWidget {
  const ImageErrorWidget({Key? key, required this.onPressed, this.error})
      : super(key: key);
  final Object? error;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Something went wrong',
              style: style.bodyMedium,
            ),
            Text(
              error.toString(),
              style: style.labelSmall,
            ),
            TextButton(
              onPressed: onPressed,
              child: const Text('Try again'),
            )
          ],
        ),
      ),
    );
  }
}