import 'package:flutter/material.dart';

import '../texts/text_widget.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    Key? key,
    required this.iconData,
    required this.text,
    required this.addBackButton,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final bool addBackButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (addBackButton)
          const Positioned(
            top: 0,
            left: 0,
            child: BackButton(color: Colors.white),
          ),
        Center(
          child: FittedBox(
            child: Column(
              children: [
                Icon(
                  iconData,
                  size: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                TextWidget(
                  text: text,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
