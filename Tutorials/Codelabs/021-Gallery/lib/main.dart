import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(testWidget);
}

Widget testWidget = new MediaQuery(
  data: new MediaQueryData(),
  child: new MaterialApp(home: new FadeThroughTransitionDemo()),
);

class FadeThroughTransitionDemo extends StatefulWidget {
  const FadeThroughTransitionDemo({Key? key}) : super(key: key);

  @override
  _FadeThroughTransitionDemoState createState() =>
      _FadeThroughTransitionDemoState();
}

class _FadeThroughTransitionDemoState extends State<FadeThroughTransitionDemo> {
  int _pageIndex = 0;
  final _pageList = <Widget>[
    _AlbumsPage(),
    _PhotosPage(),
    _SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text("Gallery"),
            Text(
              "Alt sekmelerde gezinme",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          child,
          animation,
          secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pageList[_pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (selectedIndex) {
          setState(() {
            _pageIndex = selectedIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.photo_library),
            label: "Fotoğraflar",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.photo),
            label: "Albümler",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: "Ara",
          ),
        ],
      ),
    );
  }
}

class _ExampleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: Card(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black26,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: FlutterLogo(size: 128),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Fotoğraf",
                        style: textTheme.bodyText1,
                      ),
                      Text(
                        "2021_08_11",
                        style: textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              splashColor: Colors.black38,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _AlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          3,
          (index) => Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ExampleCard(),
                _ExampleCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ExampleCard(),
        _ExampleCard(),
      ],
    );
  }
}

class _SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: FlutterLogo(size: 128),
          title: Text("Fotoğraf" + ' ${index + 1}'),
          subtitle: Text("2021_08_11"),
        );
      },
      itemCount: 10,
    );
  }
}
