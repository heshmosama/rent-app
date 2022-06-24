import 'package:flutter/material.dart';
import 'package:rent_flutter_task/core/utils/constants.dart';
import '../error/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return server_failure_message;
    default:
      return 'Unexpected error';
  }
}

Center buildLoadingWidget() => const Center(
      child:
          SizedBox(width: 24, height: 24, child: CircularProgressIndicator()),
    );

showSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
