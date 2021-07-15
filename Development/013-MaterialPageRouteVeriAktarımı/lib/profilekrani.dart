import 'package:flutter/material.dart';

class ProfilEkrani extends StatefulWidget {
  String kullaniciAdi, sifre;
  ProfilEkrani({
    Key? key,
    required this.kullaniciAdi,
    required this.sifre,
  }) : super(key: key);

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
      body: Container(
        child: Column(
          children: [
            Text(widget.kullaniciAdi),
            Text(widget.sifre),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Çıkış"),
            ),
          ],
        ),
      ),
    );
  }
}
