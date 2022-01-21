import 'package:flutter/material.dart';
import 'girisekrani.dart';
import 'profilekrani.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => GirisEkrani(),
        "/ProfilSayfasiRotasi": (context) => ProfilEkrani(),
      },
    );
  }
}
