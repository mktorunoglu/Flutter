import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatelessWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anasayfa"),),
      body: Yazilar(),
    );
  }
}

class Yazilar extends StatefulWidget {
  @override
    _YazilarState createState() => _YazilarState();
}

class _YazilarState extends State<Yazilar> {
  final Stream<QuerySnapshot> yazilar = FirebaseFirestore.instance.collection('Yazilar').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: yazilar,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong.');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return new ListTile(
              title: new Text(data['baslik']),
              subtitle: new Text(data['icerik']),
            );
          }).toList(),
        );
      },
    );
  }
}
