import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        PopupMenuButton(
          icon: Icon(Icons.settings),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Settings"),
            ),
            PopupMenuItem(
              child: Text("Flutter.io"),
            ),
            PopupMenuItem(
              child: Text("Google.com"),
            ),
          ],
        ),
      ]),
    );
  }
}
