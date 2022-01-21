import 'dart:math';
import 'package:ezberdefteri2/component/dialog/alistirma_dialog.dart';
import 'package:ezberdefteri2/component/widget/button_content.dart';
import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/cevaplar_ekrani.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';

class AlistirmaYazarakCalis extends StatefulWidget {
  const AlistirmaYazarakCalis({Key? key, required this.ezberList})
      : super(key: key);

  final List<Ezber> ezberList;

  @override
  _AlistirmaYazarakCalisState createState() => _AlistirmaYazarakCalisState();
}

class _AlistirmaYazarakCalisState extends State<AlistirmaYazarakCalis> {
  List<Ezber> alistirmaList = [];
  int ezberSayisi = 0;
  Random random = new Random();
  int index = 0;
  int sayac = 0;
  String sayacAlistirma = "";
  String ezber = "";
  String anlam = "";
  bool buttonActive = false;
  List<Ezber> dogruList = [];
  List<Ezber> yanlisList = [];
  TextEditingController cevapText = TextEditingController();
  bool icerikGizle = false;
  List yanlisCevapList = [];
  bool cevap = false;

  @override
  void initState() {
    super.initState();
    alistirmaList = widget.ezberList.toList();
    ezberSayisi = alistirmaList.length;
    alistirmaOlustur();
  }

  void alistirmaOlustur() {
    index = random.nextInt(alistirmaList.length);
    sayac++;
    setState(() {
      sayacAlistirma = sayac.toString() + " / " + ezberSayisi.toString();
      if (anlamCalis) {
        ezber = alistirmaList[index].anlam;
        anlam = alistirmaList[index].ezber;
      } else {
        ezber = alistirmaList[index].ezber;
        anlam = alistirmaList[index].anlam;
      }
    });
  }

  void alistirmaTekrarBaslat() {
    Navigator.pop(context);
    setState(() {
      icerikGizle = false;
      buttonActive = false;
      cevapText.clear();
    });
    sayac = 0;
    dogruList = [];
    yanlisList = [];
    yanlisCevapList = [];
    alistirmaList = widget.ezberList.toList();
    alistirmaOlustur();
  }

  void cevapKontrol() {
    setState(() {
      if (cevapText.text.toLowerCase() == anlam.toLowerCase()) {
        dogruList.add(alistirmaList[index]);
        cevap = true;
      } else {
        yanlisList.add(alistirmaList[index]);
        yanlisCevapList.add(cevapText.text);
        cevap = false;
      }
    });
    alistirmaList.removeAt(index);
    if (alistirmaList.isNotEmpty) {
      setState(() {
        buttonActive = false;
        cevapText.clear();
      });
      alistirmaOlustur();
    } else {
      setState(() {
        icerikGizle = true;
      });
      sonucDialog();
    }
  }

  Future<void> sonucDialog() {
    String mesaj;
    if (dogruList.isEmpty) {
      mesaj = "Hiçbirini bilemedin.";
    } else if (yanlisList.isEmpty) {
      mesaj = "Tebrikler! Hepsini bildin.";
    } else {
      mesaj = ezberSayisi.toString() +
          " ezberden " +
          dogruList.length.toString() +
          " tanesini bildin.";
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: color2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
                    child: Text(
                      mesaj,
                      style: TextStyle(
                        color: color3,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  yanlisList.isEmpty
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CevaplarEkrani(
                                    dogruYanlis: false,
                                    cevapList: yanlisList,
                                    yanlisCevapList: yanlisCevapList,
                                  ),
                                ),
                              );
                            },
                            child: buttonContent(
                                "Yanlış cevaplananları gör", Colors.redAccent),
                          ),
                        ),
                  dogruList.isEmpty
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CevaplarEkrani(
                                    dogruYanlis: true,
                                    cevapList: dogruList,
                                    yanlisCevapList: [],
                                  ),
                                ),
                              );
                            },
                            child: buttonContent(
                                "Doğru cevaplananları gör", Colors.green),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:
                          buttonContent("Ezber ekranına dön", Colors.blueGrey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: InkWell(
                      onTap: alistirmaTekrarBaslat,
                      child: buttonContent("Tekrar başlat", Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        brightness: Brightness.dark,
        title: Text("Alıştırma"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: "Geri dön",
        ),
      ),
      body: Container(
        color: color2,
        child: icerikGizle
            ? Container(color: color2)
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: sayac < 2
                              ? SizedBox.shrink()
                              : Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.info,
                                          color: color1,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Önceki cevabın ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: color3,
                                      ),
                                    ),
                                    cevap
                                        ? Text(
                                            "doğru",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          )
                                        : Text(
                                            "yanlış",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                    Text(
                                      ".",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: color3,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        Text(
                          sayacAlistirma,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color3,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              ezber,
                              style: TextStyle(
                                color: karanlikMod ? color3 : color1,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextFormField(
                            cursorColor: karanlikMod ? color3 : color1,
                            controller: cevapText,
                            decoration: new InputDecoration(
                              hintText: anlamCalis
                                  ? "Karşılığını yazınız"
                                  : "Anlamını yazınız",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: karanlikMod ? color3 : color1),
                              ),
                            ),
                            style: TextStyle(
                              color: color3,
                              fontSize: 16,
                            ),
                            autofocus: true,
                            onChanged: (text) {
                              setState(() {
                                buttonActive = text.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: buttonActive ? cevapKontrol : null,
                          icon: Icon(
                            Icons.send,
                            size: 28,
                          ),
                          color: karanlikMod ? color3 : color1,
                          tooltip: "Gönder",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
