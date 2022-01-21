import 'package:flutter/material.dart';

class SnackbarClass {
  static void showSnackbar(
    BuildContext context,
    IconData iconData,
    String message,
    Color backgroundColor,
    int durationSeconds,
  ) {
    SnackBar snackbar = SnackBar(
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: durationSeconds),
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(
            iconData,
            size: 22,
            color: Colors.white,
          ),
          const SizedBox(width: 20),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
