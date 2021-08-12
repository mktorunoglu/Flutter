import 'package:flutter/material.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  girisYap() {
    Navigator.pushNamed(context, "/ProfilSayfasiRotasi");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: girisYap,
              child: Text("Giriş Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
