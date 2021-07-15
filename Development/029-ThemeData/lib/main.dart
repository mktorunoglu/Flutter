import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[500],
        accentColor: Colors.red[700],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
              fontFamily: 'Hind',
            ),
            bodyText2: TextStyle(fontSize: 40.5, fontStyle: FontStyle.italic)),
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ThemeData"),
      ),
      floatingActionButton: Theme(
        data: ThemeData(accentColor: Colors.yellow),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Text 1", style: Theme.of(context).textTheme.headline1,),
              Text("Text 2"),
              Text("Text 3"),
              ElevatedButton(onPressed: null, child: Text("Button"))
            ],
          ),
        ),
      ),
    );
  }
}
