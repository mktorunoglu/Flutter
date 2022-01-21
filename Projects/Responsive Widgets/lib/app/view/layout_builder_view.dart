import 'package:flutter/material.dart';

class LayoutBuilderPage extends StatelessWidget {
  const LayoutBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LayoutBuilder"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Container(
              height: 200,
              width: 200,
              color: Colors.green,
            );
          } else {
            return Container(
              height: 200,
              width: 200,
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
