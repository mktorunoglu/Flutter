import 'package:flutter/material.dart';
import 'main.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  girisYap() {
    Navigator.pushNamed(
      context,
      "/ProfilSayfasiRotasi",
      arguments: VeriModeli(
        kullaniciAdi: t1.text,
        sifre: t2.text,
      ),
    );
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
            TextFormField(
              controller: t1,
            ),
            TextFormField(
              controller: t2,
            ),
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

