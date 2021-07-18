import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Basic Flutter Layout Concepts',
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.end,
      //mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlueBox(),
        BlueBox(),
        BlueBox(),
      ],
    );
  }
}

class BlueBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}
