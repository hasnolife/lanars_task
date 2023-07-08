import 'package:lanars_task/core/errors/failure.dart';

mixin FailureParseMixin {
  String mapFailureToMessage(Object error) {
    switch (error.runtimeType) {
      case  ServerFailure : return '${error.runtimeType} try again';
      default: return 'Unknown failure. Try again later';
    }
  }


}