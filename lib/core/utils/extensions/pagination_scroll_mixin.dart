import 'dart:async';

import 'package:flutter/cupertino.dart';

mixin PaginationScrollMixin {
  final scrollController = ScrollController();

  /// Adds a listener to [scrollController] and set [Function] when it at edge
  ///  scrollController.addListener(() {
  ///       if (scrollController.position.atEdge) {
  ///         if (scrollController.position.pixels != 0) {
  ///           function();
  ///        }
  ///       }
  void setScrollController(BuildContext context,
      {required VoidCallback function}) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          function();
        }
      }
    });
  }

  /// Jump down when new page is loading.
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
