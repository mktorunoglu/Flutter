import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      home: CarouselDemo(),
    );
  }
}

class CarouselDemo extends StatelessWidget {
  CarouselDemo({Key? key}) : super(key: key);
  static const List<String> fileNames = [
    'assets/eat_cape_town_sm.jpg',
    'assets/eat_new_orleans_sm.jpg'
  ];

  final List<Widget> images =
      fileNames.map((file) => Image.asset(file, fit: BoxFit.cover)).toList();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AspectRatio(
            aspectRatio: 1,
            child: Carousel(itemBuilder: widgetBuilder),
          ),
        ),
      ),
    );
  }

  Widget widgetBuilder(BuildContext context, int index) {
    return images[index % images.length];
  }
}

typedef OnCurrentItemChangedCallback = void Function(int currentItem);

class Carousel extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  const Carousel({Key? key, required this.itemBuilder}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController _controller;
  late int _currentPage;
  bool _pageHasChanged = false;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _controller = PageController(
      viewportFraction: .85,
      initialPage: _currentPage,
    );
  }

  @override
  Widget build(context) {
    var size = MediaQuery.of(context).size;
    return PageView.builder(
      onPageChanged: (value) {
        setState(() {
          _pageHasChanged = true;
          _currentPage = value;
        });
      },
      controller: _controller,
      itemBuilder: (context, index) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          var result = _pageHasChanged ? _controller.page! : _currentPage * 1.0;
          var value = result - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
          return Center(
            child: SizedBox(
              height: Curves.easeOut.transform(value) * size.height,
              width: Curves.easeOut.transform(value) * size.width,
              child: child,
            ),
          );
        },
        child: widget.itemBuilder(context, index),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}