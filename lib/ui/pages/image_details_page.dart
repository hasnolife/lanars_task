import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lanars_task/domain/blocs/image_details_bloc/image_details_bloc.dart';
import 'package:lanars_task/ui/widgets/image_error_widget.dart';
import 'package:lanars_task/ui/widgets/image_details_card.dart';

class ImageDetailsPage extends StatelessWidget {
  const ImageDetailsPage({super.key, required this.imageId});

  final String imageId;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ImageDetailsBloc>();
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        builder: (BuildContext context, state) {
          if (state is DataState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Dismissible(
                direction: DismissDirection.down,
                onDismissed: (_) {
                  Navigator.of(context).pop();
                },
                key: const Key('key'),
                child: ImageDetailsCard(imageDetails: state.imageDetails),
              ),
            );
          }
          if (state is ErrorState) {
            return ImageErrorWidget(
              onPressed: () => bloc.add(LoadDetailsEvent(imageId: imageId)),
              error: state.error,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
