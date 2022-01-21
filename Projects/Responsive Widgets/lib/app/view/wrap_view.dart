import 'package:flutter/material.dart';

class WrapPage extends StatelessWidget {
  const WrapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wrap"),
      ),
      body: Wrap(
        children: List.generate(
          10,
          (index) => Container(
            margin: const EdgeInsets.all(10),
            height: 100,
            width: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
