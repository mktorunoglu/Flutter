import 'package:flutter/material.dart';
import 'profilekrani.dart';

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({Key? key}) : super(key: key);

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilEkrani(),
                  ),
                );
              },
              child: Text("Giriş"),
            )
          ],
        ),
      ),
    );
  }
}
