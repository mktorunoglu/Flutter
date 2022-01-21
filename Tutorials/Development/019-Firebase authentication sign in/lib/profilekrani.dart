import 'package:flutter/material.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({Key? key}) : super(key: key);

  @override
  _ProfilEkraniState createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Ekranı"),
      ),
      body: Center(
        child: Container(
          child: Text("Profil sayfasına giriş yapıldı."),
        ),
      ),
    );
  }
}
