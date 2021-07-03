import 'package:flutter/material.dart';
import 'profilekrani.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

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
                controller: t1,
                decoration: InputDecoration(hintText: "Kullanıcı Adı"),
              ),
              TextFormField(
                controller: t2,
                decoration: InputDecoration(hintText: "Şifre"),
              ),
              Text(""),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilEkrani(
                        kullaniciAdi: t1.text,
                        sifre: t2.text,
                      ),
                    ),
                  );
                },
                child: Text("Giriş"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
