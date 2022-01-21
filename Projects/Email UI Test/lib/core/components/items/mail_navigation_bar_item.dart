import 'package:flutter/material.dart';

import '../texts/text_widget.dart';

class MailNavigationBarItem extends StatelessWidget {
  const MailNavigationBarItem({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool breakpointPortrait = screenWidth < 600;

    return Expanded(
      child: Padding(
        padding: breakpointPortrait
            ? const EdgeInsets.symmetric(vertical: 5)
            : EdgeInsets.zero,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              const SizedBox(height: 5),
              TextWidget(
                text: text,
                color: Colors.white,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
