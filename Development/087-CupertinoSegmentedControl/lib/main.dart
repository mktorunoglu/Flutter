import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'CupertinoSegmentedControl',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('CupertinoSegmentedControl'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoSegmentedControl(
              children: {
                'a': Container(
                  color:
                      _selectedValue == 'a' ? Colors.blue[100] : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('A'),
                ),
                'b': Container(
                  color:
                      _selectedValue == 'b' ? Colors.blue[100] : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('B'),
                ),
                'c': Container(
                  color:
                      _selectedValue == 'c' ? Colors.blue[100] : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('C'),
                ),
                'd': Container(
                  color:
                      _selectedValue == 'd' ? Colors.blue[100] : Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('D'),
                ),
              },
              onValueChanged: (String value) {
                setState(() {
                  _selectedValue = value;
                });
              },
            ),
            SizedBox(height: 30),
            _selectedValue != null
                ? Text(
                    _selectedValue!,
                    style: TextStyle(fontSize: 50),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
