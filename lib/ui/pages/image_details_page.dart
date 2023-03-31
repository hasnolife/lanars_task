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
            return ListView();
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
