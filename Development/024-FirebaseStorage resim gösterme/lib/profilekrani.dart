import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myapp/girisekrani.dart';
import 'package:myapp/yaziekrani.dart';
import 'package:image_picker/image_picker.dart';

import 'anasayfa.dart';

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
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Anasayfa()),
                    (route) => true);
              },
              icon: Icon(Icons.home)),
          IconButton(onPressed: cikisYap, icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => YaziEkrani()));
          }),
      body: ProfilTasarimi(),
    );
  }
}

class ProfilTasarimi extends StatefulWidget {
  const ProfilTasarimi({Key? key}) : super(key: key);

  @override
  _ProfilTasarimiState createState() => _ProfilTasarimiState();
}

class _ProfilTasarimiState extends State<ProfilTasarimi> {
  late File yuklenecekDosya;
  String indirmeBaglantisi = "";

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => baglantiAl());
  }

  kameradanYukle() async {
    var alinanDosya = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya!.path);
    });

    Reference referansYolu = FirebaseStorage.instance
        .ref()
        .child("ProfilResimleri")
        .child(FirebaseAuth.instance.currentUser!.email.toString())
        .child("profilResmi.png");

    UploadTask yuklemeGorevi = referansYolu.putFile(yuklenecekDosya);
    TaskSnapshot taskSnapshot = await yuklemeGorevi;
    String url = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      indirmeBaglantisi = url;
    });
  }

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("ProfilResimleri")
        .child(FirebaseAuth.instance.currentUser!.email.toString())
        .child("profilResmi.png")
        .getDownloadURL();

    setState(() {
      indirmeBaglantisi = baglanti;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            children: [
              ClipOval(
                  child: indirmeBaglantisi == ""
                      ? Text("Profil resmi yok.")
                      : Image.network(indirmeBaglantisi,
                          width: 100, height: 100, fit: BoxFit.cover)),
              Text(""),
              Text("Profil sayfasına giriş yapıldı."),
              Text(""),
              ElevatedButton(
                  onPressed: kameradanYukle,
                  child: Text("Kameradan resim yükle"))
            ],
          ),
        ),
      ),
    );
  }
}
