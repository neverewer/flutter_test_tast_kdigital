import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? text;

  const ErrorText({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'Oh! Something went wrong. \nPlease try again.',
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF313341),
      ),
    );
  }
}
