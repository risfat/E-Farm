import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = const Color(0xFF222831),
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3)
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      elevation: 10000,
      content: Text(message, style: TextStyle(color: textColor)),
      duration: duration,
    ),
  );
}
