import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController t1 = TextEditingController();
  List mesajlar = [];

  mesajlariEkle() {
    setState(() {
      if (t1.text != "") {
        mesajlar.insert(0, t1.text);
        t1.clear();
      }
    });
  }

  mesajlariEkleEnter(mesaj) {
    setState(() {
      if (mesaj != "") {
        mesajlar.insert(0, mesaj);
        t1.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50.0),
      child: Center(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              reverse: true,
              itemCount: mesajlar.length,
              itemBuilder: (context, i) => Text(mesajlar[i]),
            )),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: t1,
                    onSubmitted: mesajlariEkleEnter,
                  ),
                ),
                Text("    "),
                ElevatedButton(
                  onPressed: mesajlariEkle,
                  child: Text("Gönder"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
