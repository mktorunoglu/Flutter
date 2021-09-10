import 'package:ezberdefteri2/data/controller/ezber_controller.dart';
import 'package:ezberdefteri2/data/controller/kategori_controller.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ezber Defteri",
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<KategoriController>(
            create: (context) => KategoriController(),
          ),
          ChangeNotifierProvider<EzberController>(
            create: (context) => EzberController(),
          ),
        ],
        child: KategorilerEkrani(),
      ),
    );
  }
}
