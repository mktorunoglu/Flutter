import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  snackbarGoster() {
    final snackBar = SnackBar(
      content: Text("Mesaj silindi."),
      action: SnackBarAction(
        label: "Geri al",
        onPressed: () {
          print("Silme işlemi geri alındı.");
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drawer Menu"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("Mesajı sil"),
            onPressed: snackbarGoster,
          ),
        ),
      ),
    );
  }
}
