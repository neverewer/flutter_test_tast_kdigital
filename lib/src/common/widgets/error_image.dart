import 'package:flutter/material.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/error.png',
      width: 270,
      height: 270,
    );
  }
}
