import 'package:flutter/material.dart';

import '../texts/text_widget.dart';

class DismissibleContainer extends StatelessWidget {
  const DismissibleContainer({
    Key? key,
    required this.color,
    required this.iconData,
    required this.text,
    required this.direction,
  }) : super(key: key);

  final Color color;
  final IconData iconData;
  final String text;
  final String direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      color: color,
      child: Row(
        mainAxisAlignment: direction == "left"
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              TextWidget(
                text: text,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
