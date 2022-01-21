import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';

Widget bosListeUyari(String item, bool aramaUyari) {
  if (!aramaUyari) {
    return Container(
      color: item == "ezber"
          ? color2
          : karanlikMod
              ? color1
              : color2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.info,
                    size: 28,
                    color: karanlikMod ? color3 : color1,
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Aranan isimde bir " + item + " yok.",
                      style: TextStyle(
                        color: color3,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } else {
    return Container(
      color: item == "kategori"
          ? karanlikMod
              ? color1
              : color2
          : color2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.info,
                size: 28,
                color: karanlikMod ? color3 : color1,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Henüz eklenmiş bir " + item + " yok.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color3,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Sağ alttaki ekleme butonundan " +
                          item +
                          " ekleyebilirsiniz.",
                      style: TextStyle(
                        color: color3,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
