import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  veriEkle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .set({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("Yazı eklendi"));
  }

  veriGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .update({'baslik': t1.text, 'icerik': t2.text}).whenComplete(
            () => print("Yazı güncellendi"));
  }

  veriSil() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .delete()
        .whenComplete(() => print("Yazı silindi"));
  }

  veriListele() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()!['baslik'];
        gelenYaziIcerigi = gelenVeri.data()!['icerik'];
      });
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
              TextField(
                controller: t1,
              ),
              TextField(
                controller: t2,
              ),
              Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: veriEkle,
                    child: Text("Ekle"),
                  ),
                  ElevatedButton(
                    onPressed: veriGuncelle,
                    child: Text("Güncelle"),
                  ),
                  ElevatedButton(
                    onPressed: veriSil,
                    child: Text("Sil"),
                  ),
                  ElevatedButton(
                    onPressed: veriListele,
                    child: Text("Listele"),
                  ),
                ],
              ),
              Text(""),
              ListTile(
                title: Text(gelenYaziBasligi),
                subtitle: Text(gelenYaziIcerigi),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
