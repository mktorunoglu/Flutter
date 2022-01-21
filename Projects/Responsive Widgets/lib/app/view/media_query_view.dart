import 'package:flutter/material.dart';

class MediaQueryPage extends StatelessWidget {
  const MediaQueryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("MediaQuery"),
      ),
      body: screenWidth > 600
          ? Container(
              height: 200,
              width: 200,
              color: Colors.green,
            )
          : Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
    );
  }
}
