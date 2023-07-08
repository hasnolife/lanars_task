import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin PaginationScrollMixin<B extends Bloc> {
  final scrollController = ScrollController();

  /// Adds a listener to [scrollController] and call [event] when it at edge
  ///
  ///  scrollController.addListener(() {
  ///       if (scrollController.position.atEdge) {
  ///         if (scrollController.position.pixels != 0) {
  ///           context.read<MyBloc>().add(LoadDataEvent());
  ///        }
  ///       }
  void setScrollController(BuildContext context,
      event) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<B>().add(event);
        }
      }
    });
  }

  /// Jump at end of scrolling after short delay when new page is loading.
  ///
  ///     Timer(const Duration(milliseconds: 30), () {
  ///       scrollController.jumpTo(scrollController.position.maxScrollExtent);
  ///     });

  void jumpDownWhenLoading() {
    Timer(const Duration(milliseconds: 30), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}
