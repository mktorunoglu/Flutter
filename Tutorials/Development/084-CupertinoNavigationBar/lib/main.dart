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
      title: 'CupertinoApp',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _tabs = [HomeTab(), SettingTab()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey.withOpacity(0.5),
        middle: const Text('CupertinoNavigationBar'),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          return _tabs[index];
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Text("Home Screen"),
        ],
      ),
    );
  }
}

class SettingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Container(height: 20, color: CupertinoColors.systemRed),
          Container(height: 20, color: CupertinoColors.systemGreen),
          Container(height: 20, color: CupertinoColors.systemBlue),
          Container(height: 20, color: CupertinoColors.systemYellow),
          Text("Settings Screen"),
        ],
      ),
    );
  }
}
