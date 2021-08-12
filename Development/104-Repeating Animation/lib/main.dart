import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      home: RepeatingAnimationDemo(),
    );
  }
}

class RepeatingAnimationDemo extends StatefulWidget {
  const RepeatingAnimationDemo({Key? key}) : super(key: key);

  @override
  RepeatingAnimationDemoState createState() => RepeatingAnimationDemoState();
}

class RepeatingAnimationDemoState extends State<RepeatingAnimationDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<BorderRadius> _borderRadius;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..repeat(reverse: true);
    _borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(100.0),
      end: BorderRadius.circular(0.0),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repeating Animation')),
      body: Center(
        child: AnimatedBuilder(
          animation: _borderRadius,
          builder: (context, child) {
            return Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: _borderRadius.value,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
