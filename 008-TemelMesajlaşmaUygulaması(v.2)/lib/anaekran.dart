import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  List<MesajBalonu> mesajListesi = [];
  TextEditingController t1 = TextEditingController();

  listeyeEkle() {
    setState(() {
      MesajBalonu mesajBalonu = MesajBalonu(mesaj: t1.text);
      mesajListesi.insert(0, mesajBalonu);
      t1.clear();
    });
  }

  Widget metinGirisAlani() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: t1,
            ),
          ),
          IconButton(
            onPressed: listeyeEkle,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: mesajListesi.length,
              itemBuilder: (context, i) => mesajListesi[i],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          metinGirisAlani(),
        ],
      ),
    );
  }
}

String isim = "Kullanıcı";

class MesajBalonu extends StatelessWidget {
  String mesaj;
  MesajBalonu({Key? key, required this.mesaj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(isim[0]),
          ),
          Text("    "),
          Column(
            children: [
              Text(isim),
              Text(mesaj),
            ],
          ),
        ],
      ),
    );
  }
}
