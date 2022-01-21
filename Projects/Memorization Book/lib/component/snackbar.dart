import 'package:flutter/material.dart';

void snackbarGoster(BuildContext context, String mesaj, int milliseconds) {
  snackbarGizle(context);
  final snackBar = SnackBar(
    content: Text(
      mesaj,
      style: TextStyle(fontSize: 16),
    ),
    duration: Duration(milliseconds: milliseconds),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void snackbarGizle(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
