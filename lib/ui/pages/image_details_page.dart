import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/image_details_bloc/image_details_bloc.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageDetailsBloc>();
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (state is DataState) {
            final imageDetails = state.imageDetails;
            return RefreshIndicator(
              onRefresh: () async => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(20.0),
                      minScale: 0.1,
                      maxScale: 3.0,
                      child: Image.network(
                        imageDetails.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Image.network(imageDetails.imageUrl),
                    Text('Image author : ${imageDetails.userName}'),
                    Text(
                        'Image size :  ${imageDetails.width} x ${imageDetails.width}'),
                    Text('Image has ${imageDetails.likes} likes'),
                  ],
                ),
              ),
            );
          }
          if (state is ErrorState) {
            return Container();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
