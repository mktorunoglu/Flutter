import 'dart:math';
import 'package:ezberdefteri2/component/dialog/alistirma_dialog.dart';
import 'package:ezberdefteri2/component/widget/button_content.dart';
import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/cevaplar_ekrani.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';

class AlistirmaKarisikEzber extends StatefulWidget {
  const AlistirmaKarisikEzber({Key? key, required this.ezberList})
      : super(key: key);

  final List<Ezber> ezberList;

  @override
  _AlistirmaKarisikEzberState createState() => _AlistirmaKarisikEzberState();
}

class _AlistirmaKarisikEzberState extends State<AlistirmaKarisikEzber> {
  int index = 0;
  List<Ezber> alistirmaList = [];
  int sayac = 0;
  int ezberSayisi = 0;
  Random random = new Random();
  String sayacAlistirma = "";
  String ezber = "";
  String anlam = "";
  bool buttonActive = false;
  double opacity = 0;
  Duration duration = Duration(milliseconds: 500);
  List<Ezber> dogruList = [];
  List<Ezber> yanlisList = [];
  bool icerikGizle = false;

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
      duration = Duration.zero;
      opacity = 0;
    });
    sayac = 0;
    dogruList = [];
    yanlisList = [];
    alistirmaList = widget.ezberList.toList();
    alistirmaOlustur();
  }

  void cevapIslem() {
    alistirmaList.removeAt(index);
    if (alistirmaList.isNotEmpty) {
      setState(() {
        buttonActive = false;
        duration = Duration.zero;
        opacity = 0;
      });
      alistirmaOlustur();
    } else {
      setState(() {
        icerikGizle = true;
      });
      sonucDialog();
    }
  }

  void yanlisCevap() {
    setState(() {
      yanlisList.add(alistirmaList[index]);
    });
    cevapIslem();
  }

  void dogruCevap() {
    setState(() {
      dogruList.add(alistirmaList[index]);
    });
    cevapIslem();
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
                borderRadius: BorderRadius.all(Radius.circular(20))),
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
                                    yanlisCevapList: [],
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
        title: Text(
          "Alıştırma",
          style: TextStyle(fontSize: 18),
        ),
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
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Text(
                        sayacAlistirma,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color3,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ezber,
                              style: TextStyle(
                                color: karanlikMod ? color3 : color1,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            AnimatedOpacity(
                              duration: duration,
                              opacity: opacity,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  anlam,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: karanlikMod
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              yanlisList.length.toString(),
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: buttonActive ? yanlisCevap : null,
                              child: Text(
                                "Yanlış",
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: color1,
                          ),
                          onPressed: buttonActive
                              ? null
                              : () {
                                  setState(() {
                                    duration = Duration(milliseconds: 500);
                                    opacity = 1;
                                    buttonActive = true;
                                  });
                                },
                          child: Text(
                            anlamCalis
                                ? "Karşılığını göster"
                                : "Anlamını göster",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              dogruList.length.toString(),
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: buttonActive ? dogruCevap : null,
                              child: Text(
                                "Doğru",
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                            ),
                          ],
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
