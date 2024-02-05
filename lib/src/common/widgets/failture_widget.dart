import 'package:flutter/material.dart';
import 'package:kdigital_test/src/common/utils/exceptions/network_exception.dart';
import 'package:kdigital_test/src/common/widgets/error_button.dart';
import 'package:kdigital_test/src/common/widgets/error_image.dart';
import 'package:kdigital_test/src/common/widgets/error_text.dart';

class FailureWidget extends StatelessWidget {
  final Object? error;
  final Function()? errorButtonCallback;

  const FailureWidget({
    super.key,
    this.error,
    this.errorButtonCallback,
  });

  String? getErrorMessage(Object? err, BuildContext context) {
    if (err == null) {
      return null;
    }

    switch (err.runtimeType) {
      case RemoteDataProviderException:
        return 'Remote data source exception. \nPlease try again.';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var errorMessage = getErrorMessage(error, context);
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const ErrorImage(),
              ErrorText(text: errorMessage),
              const Spacer(),
              ErrorButton(onPressed: errorButtonCallback),
            ],
          ),
        ),
      ),
    );
  }
}
