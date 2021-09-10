import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buttonContent(String buttonText, Color buttonColor) {
  return SizedBox(
    width: double.infinity,
    child: Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
