import 'dart:math';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(testWidget);
}

Widget testWidget = new MediaQuery(
  data: new MediaQueryData(),
  child: new MaterialApp(home: new SharedYAxisTransitionDemo()),
);

class SharedYAxisTransitionDemo extends StatefulWidget {
  const SharedYAxisTransitionDemo({Key? key}) : super(key: key);

  @override
  _SharedYAxisTransitionDemoState createState() =>
      _SharedYAxisTransitionDemoState();
}

class _SharedYAxisTransitionDemoState extends State<SharedYAxisTransitionDemo>
    with SingleTickerProviderStateMixin {
  bool _isAlphabetical = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  final _recentList = ListView(
    key: UniqueKey(),
    children: [
      for (int i = 0; i < 10; i++) _AlbumTile((i + 1).toString()),
    ],
  );

  final _alphabeticalList = ListView(
    key: UniqueKey(),
    children: [
      for (final letter in _alphabet) _AlbumTile(letter),
    ],
  );

  static const _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text("Sorting"),
            Text(
              "Liste sıralama",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text("10 albüm"),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: InkWell(
                  customBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  onTap: () {
                    if (!_isAlphabetical) {
                      _controller.reset();
                      _controller.animateTo(0.5);
                    } else {
                      _controller.animateTo(1);
                    }
                    setState(() {
                      _isAlphabetical = !_isAlphabetical;
                    });
                  },
                  child: Row(
                    children: [
                      Text(_isAlphabetical ? "A'dan Z'ye" : "Son çalınan"),
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(_controller.view),
                        child: const Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageTransitionSwitcher(
              reverse: _isAlphabetical,
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.vertical,
                  child: child,
                );
              },
              child: _isAlphabetical ? _alphabeticalList : _recentList,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlbumTile extends StatelessWidget {
  const _AlbumTile(this._title);
  final String _title;

  @override
  Widget build(BuildContext context) {
    final randomNumberGenerator = Random();
    return Column(
      children: [
        ListTile(
          leading: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
              color: Colors.grey,
            ),
            child: FlutterLogo(
              size: 128,
            ),
          ),
          title: Text("Albüm $_title"),
          subtitle: Text("Sanatçı $_title"),
          trailing: Text(
            '${(randomNumberGenerator.nextInt(50) + 10).toString()} '
            "dk.",
          ),
        ),
        const Divider(height: 20, thickness: 1),
      ],
    );
  }
}
