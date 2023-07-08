import 'package:lanars_task/core/errors/failure.dart';

mixin FailureParseMixin {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case  ServerFailure : return '${failure.runtimeType} try again';
      default: return 'Unknown failure. Try again later';
    }
  }


}