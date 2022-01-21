import 'package:flutter/material.dart';

void main() {
  runApp(testWidget);
}

Widget testWidget = new MediaQuery(
  data: new MediaQueryData(),
  child: new MaterialApp(home: new MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key, MaterialApp? home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FlutterLogo(size: 128),
          ],
        ),
      ),
    );
  }
}
