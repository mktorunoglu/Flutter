import 'package:flutter/material.dart';

class ProfilEkrani extends StatelessWidget {
  const ProfilEkrani({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Ekranı"),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Çıkış"),
            ),
          ],
        ),
      ),
    );
  }
}
