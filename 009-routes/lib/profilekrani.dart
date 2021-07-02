import 'package:flutter/material.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({Key? key}) : super(key: key);

  @override
  _ProfilEkraniState createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  cikisYap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Ekranı"),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: cikisYap,
              child: Text("Çıkış Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
