import 'package:flutter/material.dart';
import 'main.dart';

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
  VeriModeli gelenArgumanlar = ModalRoute.of(context)!.settings.arguments as VeriModeli;
  
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
            Text(gelenArgumanlar.kullaniciAdi),
            Text(gelenArgumanlar.sifre),
          ],
        ),
      ),
    );
  }
}
