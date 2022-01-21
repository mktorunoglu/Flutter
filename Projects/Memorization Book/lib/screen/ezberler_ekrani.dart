import 'dart:async';
import 'package:ezberdefteri2/component/widget/bos_liste_uyari.dart';
import 'package:ezberdefteri2/component/dialog/alistirma_dialog.dart';
import 'package:ezberdefteri2/component/dialog/ezberler_info_dialog.dart';
import 'package:ezberdefteri2/component/snackbar.dart';
import 'package:ezberdefteri2/component/widget/button_content.dart';
import 'package:ezberdefteri2/data/controller/ezber_controller.dart';
import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/ezberlendi_ekrani.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:ezberdefteri2/screen/secenekler_ekrani.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:need_resume/need_resume.dart';

int ezberSiralama = 0;

class EzberlerEkrani extends StatefulWidget {
  const EzberlerEkrani(
      {Key? key, required this.kategoriId, required this.kategoriAdi})
      : super(key: key);

  final int kategoriId;
  final String kategoriAdi;

  @override
  _EzberlerEkraniState createState() => _EzberlerEkraniState();
}

class _EzberlerEkraniState extends ResumableState<EzberlerEkrani> {
  bool appbarTitle = true;
  List<Ezber> gosterilenList = [];
  List<Ezber> ezberList = [];
  TextEditingController ezberText = TextEditingController();
  TextEditingController anlamText = TextEditingController();
  List<double> opacity = [];
  int ezberlendiSayisi = 0;

  @override
  void initState() {
    super.initState();
    icerikYenile();
  }

  @override
  void onResume() {
    icerikYenile();
  }

  void icerikYenile() {
    loadSiralama();
    ezberGoster();
    ezberlendiSayisiHesapla();
  }

  void incrementId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getInt('id') ?? 0) + 1;
      prefs.setInt('id', id);
    });
  }

  void loadSiralama() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      ezberSiralama = (pref.getInt('ezberSiralama') ?? 0);
    });
  }

  void setSiralama(int value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ezberSiralama = value;
      prefs.setInt('ezberSiralama', ezberSiralama);
    });
    ezberAraGizle();
    ezberSirala();
    Navigator.of(context).pop();
  }

  bool bosListeKontrol() {
    if (gosterilenList.isEmpty && appbarTitle) {
      snackbarGoster(context, "Önce ezber eklemelisiniz.", 1000);
      return false;
    } else {
      return true;
    }
  }

  void ezberAraButton() {
    if (bosListeKontrol()) {
      setState(() {
        if (appbarTitle == true) {
          appbarTitle = false;
        } else {
          appbarTitle = true;
          ezberSirala();
        }
      });
    }
  }

  void ezberAraGizle() {
    if (appbarTitle == false) {
      appbarTitle = true;
    }
  }

  void ezberGoster() {
    Provider.of<EzberController>(context, listen: false)
        .ezberListele(widget.kategoriId, 0)
        .then((value) {
      setState(() {
        ezberList = value.toList();
        ezberSirala();
        if (anlamGizleme) {
          opacity = List.generate(gosterilenList.length, (index) => 1);
        } else {
          opacity = List.generate(gosterilenList.length, (index) => 0.0);
        }
      });
    });
  }

  void ezberlendiSayisiHesapla() {
    Provider.of<EzberController>(context, listen: false)
        .ezberListele(widget.kategoriId, 1)
        .then((value) {
      setState(() {
        ezberlendiSayisi = value.length;
      });
    });
  }

  void ezberSirala() {
    setState(() {
      gosterilenList = ezberList.toList();
      if (ezberSiralama != 0) {
        switch (ezberSiralama) {
          case 1:
            gosterilenList = gosterilenList.reversed.toList();
            break;
          case 2:
            gosterilenList.sort((a, b) {
              return a.ezber.toLowerCase().compareTo(b.ezber.toLowerCase());
            });
            break;
          case 3:
            gosterilenList.sort((a, b) {
              return a.ezber.toLowerCase().compareTo(b.ezber.toLowerCase());
            });
            gosterilenList = gosterilenList.reversed.toList();
            break;
        }
      }
    });
  }

  void ekleDuzenleDialogButton(String islem, Ezber ezber) {
    if (ezberText.text.isEmpty || anlamText.text.isEmpty) {
      snackbarGoster(context, "Lütfen ezber ve anlamını giriniz.", 1500);
    } else {
      switch (islem) {
        case "Ekle":
          ezberEkle();
          break;
        case "Kaydet":
          ezberDuzenle(ezber);
          break;
      }
    }
  }

  void ezberEkle() {
    incrementId();
    ezberList.add(Ezber(
        id: id,
        kategoriId: widget.kategoriId,
        ezberlendi: 0,
        ezber: ezberText.text,
        anlam: anlamText.text));
    Provider.of<EzberController>(context, listen: false)
        .ezberEkle(id, widget.kategoriId, 0, ezberText.text, anlamText.text);
    snackbarGoster(context, "Ezber eklendi.", 500);
    ezberAraGizle();
    ezberSirala();
    if (anlamGizleme) {
      opacity = List.generate(gosterilenList.length, (index) => 1);
    } else {
      opacity = List.generate(gosterilenList.length, (index) => 0.0);
    }
    ezberText.clear();
    anlamText.clear();
  }

  void ezberDuzenle(Ezber ezber) {
    int index = ezberList.indexOf(ezber);
    ezberList[index].ezber = ezberText.text;
    ezberList[index].anlam = anlamText.text;
    Provider.of<EzberController>(context, listen: false).ezberGuncelle(Ezber(
        id: ezber.id,
        kategoriId: ezber.kategoriId,
        ezberlendi: ezber.ezberlendi,
        ezber: ezberText.text,
        anlam: anlamText.text));
    Navigator.of(context).pop();
    snackbarGoster(context, "Ezber güncellendi.", 500);
    ezberAraGizle();
    ezberSirala();
  }

  void ezberEzberlendi(Ezber ezber) {
    incrementId();
    Provider.of<EzberController>(context, listen: false).ezberSil(ezber.id);
    Provider.of<EzberController>(context, listen: false)
        .ezberEkle(id, ezber.kategoriId, 1, ezber.ezber, ezber.anlam);
    setState(() {
      gosterilenList.removeWhere((element) => element.id == ezber.id);
      ezberList.removeWhere((element) => element.id == ezber.id);
    });
    ezberlendiSayisiHesapla();
    ezberAraGizle();
  }

  void ezberAra(String aranan) {
    ezberSirala();
    setState(() {
      if (aranan.isNotEmpty) {
        gosterilenList = gosterilenList
            .where((element) =>
                element.ezber.toLowerCase().contains(aranan.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> islemDialog(String islemText, String iptalText, Ezber ezber) {
    FocusNode ezberFocus = new FocusNode();
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: karanlikMod ? color3 : color1,
                  controller: ezberText,
                  autofocus: true,
                  focusNode: ezberFocus,
                  decoration: InputDecoration(
                    hintText: ezber.ezber,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: karanlikMod ? color3 : color1),
                    ),
                  ),
                  style: TextStyle(
                    color: color3,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  cursorColor: karanlikMod ? color3 : color1,
                  controller: anlamText,
                  decoration: InputDecoration(
                    hintText: ezber.anlam,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: karanlikMod ? color3 : color1),
                    ),
                  ),
                  style: TextStyle(
                    color: color3,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: buttonContent(iptalText, Colors.grey),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              ekleDuzenleDialogButton(islemText, ezber);
                              FocusScope.of(context).requestFocus(ezberFocus);
                            },
                            child: buttonContent(islemText, color1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      ezberText.clear();
      anlamText.clear();
    });
  }

  Future<void> siralamaDialog() {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: SingleChildScrollView(
            child: Column(
              children: [
                RadioListTile(
                  activeColor: karanlikMod ? Colors.white : color1,
                  title: Text(
                    'Eski - Yeni',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color3,
                      fontSize: 16,
                    ),
                  ),
                  value: 0,
                  groupValue: ezberSiralama,
                  onChanged: (value) {
                    setSiralama(0);
                  },
                ),
                RadioListTile(
                  activeColor: karanlikMod ? Colors.white : color1,
                  title: Text(
                    'Yeni - Eski',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color3,
                      fontSize: 16,
                    ),
                  ),
                  value: 1,
                  groupValue: ezberSiralama,
                  onChanged: (value) {
                    setSiralama(1);
                  },
                ),
                RadioListTile(
                  activeColor: karanlikMod ? Colors.white : color1,
                  title: Text(
                    'A - Z',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color3,
                      fontSize: 16,
                    ),
                  ),
                  value: 2,
                  groupValue: ezberSiralama,
                  onChanged: (value) {
                    setSiralama(2);
                  },
                ),
                RadioListTile(
                  activeColor: karanlikMod ? Colors.white : color1,
                  title: Text(
                    'Z - A',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color3,
                      fontSize: 16,
                    ),
                  ),
                  value: 3,
                  groupValue: ezberSiralama,
                  onChanged: (value) {
                    setSiralama(3);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void anlamGoster(int index) {
      if (opacity[index] == 0.0) {
        setState(() {
          opacity[index] = 1;
          Timer(Duration(seconds: 3), () {
            setState(() {
              opacity[index] = 0.0;
            });
          });
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        brightness: Brightness.dark,
        title: appbarTitle
            ? Text(
                widget.kategoriAdi,
                style: TextStyle(fontSize: 18),
              )
            : TextFormField(
                autofocus: true,
                onChanged: (text) {
                  ezberAra(text);
                },
                decoration: InputDecoration(
                  hintText: "Ezber ara",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                cursorColor: Colors.white,
              ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: IconButton(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                appbarTitle ? Icons.search : Icons.cancel,
                size: 28,
              ),
              onPressed: ezberAraButton,
              tooltip: "Ezber ara",
            ),
          ),
        ],
      ),
      body: gosterilenList.isEmpty
          ? bosListeUyari("ezber", appbarTitle)
          : Container(
              color: color2,
              child: ListView.separated(
                itemCount: gosterilenList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    child: ListTile(
                      title: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.grey.shade300),
                                    onPressed: anlamGizleme
                                        ? null
                                        : () {
                                            anlamGoster(index);
                                          },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        gosterilenList[index].ezber,
                                        style: TextStyle(
                                          color: color1,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 500),
                                  opacity: opacity[index],
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          gosterilenList[index].anlam,
                                          style: TextStyle(
                                            color: color3,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: anlamGizleme
                          ? null
                          : () {
                              anlamGoster(index);
                            },
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        islemDialog("Kaydet", "İptal", gosterilenList[index]);
                        ezberText.text = gosterilenList[index].ezber;
                        anlamText.text = gosterilenList[index].anlam;
                      } else if (direction == DismissDirection.startToEnd) {
                        ezberEzberlendi(gosterilenList[index]);
                      }
                    },
                    background: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        color: color1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.done_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        color: color1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 0,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          islemDialog(
            "Ekle",
            "Kapat",
            Ezber(
              id: 0,
              kategoriId: 0,
              ezberlendi: 0,
              ezber: "Ezber",
              anlam: "Anlamı",
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
        backgroundColor: color1,
        tooltip: 'Ezber ekle',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Container(
        color: color2,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: color1,
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.settings,
                      size: 28,
                    ),
                    tooltip: "Seçenekler",
                    onPressed: () {
                      List<Ezber> ezberlendiList = [];
                      Provider.of<EzberController>(context, listen: false)
                          .ezberListele(widget.kategoriId, 1)
                          .then((value) {
                        ezberlendiList = value.toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<EzberController>(
                              create: (BuildContext context) {
                                return EzberController();
                              },
                              child: SeceneklerEkrani(
                                kategoriId: widget.kategoriId,
                                kategoriAdi: widget.kategoriAdi,
                                ezberSayisi: ezberList.length,
                                ezberlendiSayisi: ezberlendiList.length,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.sort_by_alpha,
                      size: 28,
                    ),
                    tooltip: "Ezberleri sırala",
                    onPressed: () {
                      if (bosListeKontrol()) {
                        siralamaDialog();
                      }
                    },
                  ),
                ),
                true
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.picture_as_pdf),
                        tooltip: "PDF olarak kaydet",
                        onPressed: () {},
                      ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.done_outline,
                          size: 28,
                        ),
                        tooltip: "Ezberlenenler",
                        onPressed: () {
                          Provider.of<EzberController>(context, listen: false)
                              .ezberListele(widget.kategoriId, 1)
                              .then((value) {
                            if (value.isEmpty) {
                              snackbarGoster(context,
                                  "Ezberlenenler sayfasında ezber yok.", 1500);
                            } else {
                              push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<EzberController>(
                                    create: (BuildContext context) {
                                      return EzberController();
                                    },
                                    child: EzberlendiEkrani(
                                      kategoriId: widget.kategoriId,
                                      kategoriAdi: widget.kategoriAdi,
                                    ),
                                  ),
                                ),
                              );
                            }
                          });
                        },
                      ),
                    ),
                    ezberlendiSayisi == 0
                        ? SizedBox.shrink()
                        : Positioned(
                            right: 3,
                            top: 8,
                            child: new Container(
                              padding: EdgeInsets.all(3),
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 15,
                                minHeight: 15,
                              ),
                              child: new Text(
                                ezberlendiSayisi.toString(),
                                style: new TextStyle(
                                  color: Colors.black,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.quiz,
                      size: 28,
                    ),
                    tooltip: "Alıştırma",
                    onPressed: () {
                      if (bosListeKontrol()) {
                        AlistirmaDialog.alistirmaDialog(context, ezberList);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.info,
                      size: 28,
                    ),
                    tooltip: "Yardım",
                    onPressed: () {
                      EzberlerInfoDialog.ezberlerInfoDialog(context, false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
