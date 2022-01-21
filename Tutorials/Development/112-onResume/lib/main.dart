import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends ResumableState<FirstScreen> {
  @override
  void onReady() {
    print('First screen is ready!');
  }

  @override
  void onResume() {
    print('Second screen is resumed!');
  }

  @override
  void onPause() {
    print('First screen is paused!');
  }

  void goToSecondScreen() {
    push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Go to second screen'),
          onPressed: () {
            goToSecondScreen();
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends ResumableState<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Go back'),
          onPressed: () {
            goBack();
          },
        ),
      ),
    );
  }

  void goBack() {
    Navigator.pop(context);
  }
}
