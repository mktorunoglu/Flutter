import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController t1 = TextEditingController();
  List alisverisListesi = [];

  elemanEkle() {
    setState(() {
      int liste_size = alisverisListesi.length;
      int same_record = 0;

      for (int i = 0; i < liste_size; i++) {
        if (t1.text == alisverisListesi[i]) {
          same_record++;
        }
      }

      if (t1.text != "" && same_record == 0) {
        alisverisListesi.add(t1.text);
      }
      t1.clear();
    });
  }

  elemanSil() {
    setState(() {
      alisverisListesi.remove(t1.text);
      t1.clear();
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
                    itemCount: alisverisListesi.length,
                    itemBuilder: (context, i) => ListTile(
                          title: Text(alisverisListesi[i]),
                          subtitle: Text("Alınacak malzeme"),
                          onTap: () => t1.text = alisverisListesi[i],
                        ))),
            TextField(
              controller: t1,
            ),
            Text(""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: elemanEkle,
                  child: Text("Ekle"),
                ),
                ElevatedButton(
                  onPressed: elemanSil,
                  child: Text("Sil"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
