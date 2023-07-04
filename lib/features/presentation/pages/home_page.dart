import 'package:flutter/material.dart';
import 'package:lanars_task/features/presentation/widgets/custom_search_delegate.dart';
import 'package:lanars_task/features/presentation/widgets/images_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
          )
        ],
      ),
      body: SafeArea(child: ImagesList()),
    );
  }
}
