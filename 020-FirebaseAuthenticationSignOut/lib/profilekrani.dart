import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/girisekrani.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({Key? key}) : super(key: key);

  @override
  _ProfilEkraniState createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  cikisYap() {
    FirebaseAuth.instance.signOut().then((deger) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => GirisEkrani()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Ekranı"),
        actions: [
          IconButton(onPressed: cikisYap, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            children: [
              Text("Profil sayfasına giriş yapıldı."),
            ],
          ),
        ),
      ),
    );
  }
}
