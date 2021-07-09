import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: TabBarView(
            children: [
              Ekran1(),
              Ekran2(),
              Ekran3(),
              Ekran4(),
            ],
          ),
          appBar: AppBar(
            title: Text("TabBar"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.directions_subway)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ekran1 extends StatelessWidget {
  const Ekran1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Ekran 1"),
      ),
    );
  }
}

class Ekran2 extends StatelessWidget {
  const Ekran2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Ekran 2"),
      ),
    );
  }
}

class Ekran3 extends StatelessWidget {
  const Ekran3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Ekran 3"),
      ),
    );
  }
}

class Ekran4 extends StatelessWidget {
  const Ekran4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Ekran 4"),
      ),
    );
  }
}
