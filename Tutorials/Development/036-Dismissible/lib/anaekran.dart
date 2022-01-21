import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  List ogeler = ["Bir", "İki", "Üç", "Dört", "Beş", "Altı"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ogeler.length,
        itemBuilder: (context, i) {
          return Dismissible(
            key: Key(ogeler[i]),
            onDismissed: (direction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${ogeler[i]} silindi."),
                ),
              );
              setState(() {
                ogeler.removeAt(i);
              });
            },
            background: Container(
              color: Colors.lightBlue,
              child: Icon(Icons.delete),
            ),
            child: ListTile(
              title: Text(ogeler[i]),
            ),
          );
        });
  }
}
