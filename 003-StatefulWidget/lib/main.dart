import 'package:flutter/material.dart';

void main() {
  String isim1 = 'Ali';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İlkel Blog Uygulaması',
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Uygulaması'),
      ),
      body: AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  String blogYazisi = "Bloğa Hoşgeldiniz.";

  martYazisiGoster() {
    setState(() {
      blogYazisi = "Mart Yazısına Hoşgeldiniz.";
    });
  }

  nisanYazisiGoster() {
    setState(() {
      blogYazisi = "Nisan Yazısına Hoşgeldiniz.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(blogYazisi),
          Text(blogYazisi),
          Text(blogYazisi),
          RaisedButton(
            onPressed: martYazisiGoster,
            child: Text('Mart Yazısı'),
          ),
          RaisedButton(
            onPressed: nisanYazisiGoster,
            child: Text('Nisan Yazısı'),
          )
        ],
      )),
    );
  }
}
