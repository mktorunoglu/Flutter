import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyState createState() {
    return _MyState();
  }
}

class _MyState extends State<MyApp> {
  double val1 = 1;
  double val2 = 1;
  double val3 = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Flutter Slider"),
        ),
        body: Container(
          child: Column(
            children: [
              Slider(
                value: val1,
                onChanged: (value) {
                  setState(() {
                    val1 = value;
                  });
                },
              ),
              Text(val1.toString()),
              Slider(
                value: val2,
                onChanged: (value) {
                  setState(() {
                    val2 = value;
                  });
                },
                min: 0,
                max: 10,
              ),
              Text(val2.toString()),
              Slider(
                value: val3,
                onChanged: (value) {
                  setState(() {
                    val3 = value;
                  });
                },
                min: 0,
                max: 10,
                divisions: 10,
              ),
              Text(val3.toString()),
              Slider(
                value: val3,
                onChanged: (value) {
                  setState(() {
                    val3 = value;
                  });
                },
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: Colors.green,
                inactiveColor: Colors.green[100],
              ),
              Text(val3.toString()),
              Slider(
                value: val3,
                onChanged: (value) {
                  setState(() {
                    val3 = value;
                  });
                },
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: Colors.green,
                inactiveColor: Colors.green[100],
                label: val3.round().toString(),
              ),
              Text(val3.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
