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
    if (t1.text == "admin" && t2.text == "1234") {
      Navigator.pushNamed(
        context,
        "/ProfilSayfasiRotasi",
        arguments: VeriModeli(
          kullaniciAdi: t1.text,
          sifre: t2.text,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Yanlış kullanıcı adı veya şifre!"),
            content: new Text("Lütfen giriş bilgileriniz gözden geçiriniz."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(100),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: "Kullanıcı Adı"),
                controller: t1,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Şifre"),
                controller: t2,
              ),
              Text(""),
              ElevatedButton(
                onPressed: girisYap,
                child: Text("Giriş Yap"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
