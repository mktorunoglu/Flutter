import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profilekrani.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance.collection("Kullanicilar").doc(t1.text).set({
        'KullaniciEposta': t1.text,
        'KullaniciSifre': t2.text
      }).whenComplete(
          () => print("Kullanıcı bilgileri veritabanına da kaydedilmiştir."));
    });
  }

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilEkrani()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            children: [
              TextFormField(
                controller: t1,
              ),
              TextFormField(
                controller: t2,
              ),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: kayitOl,
                    child: Text("Kayıt ol"),
                  ),
                  ElevatedButton(
                    onPressed: girisYap,
                    child: Text("Giriş Yap"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
