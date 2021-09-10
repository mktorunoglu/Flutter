import 'package:ezberdefteri2/component/snackbar.dart';
import 'package:ezberdefteri2/component/widget/bos_liste_uyari.dart';
import 'package:ezberdefteri2/component/widget/button_content.dart';
import 'package:ezberdefteri2/data/controller/ezber_controller.dart';
import 'package:ezberdefteri2/data/controller/kategori_controller.dart';
import 'package:ezberdefteri2/data/model/kategori_model.dart';
import 'package:ezberdefteri2/screen/ezberler_ekrani.dart';
import 'package:ezberdefteri2/screen/secenekler_ekrani.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int id = 0;
bool anlamGizleme = false;
Color color1 = Colors.blue;
Color color2 = Colors.white;
Color color3 = Colors.black;
bool karanlikMod = false;
int themeColor = 4280391411;

class KategorilerEkrani extends StatefulWidget {
  const KategorilerEkrani({Key? key}) : super(key: key);

  @override
  _KategorilerEkraniState createState() => _KategorilerEkraniState();
}

class _KategorilerEkraniState extends State<KategorilerEkrani> {
  bool appbarTitle = true;
  int kategoriSiralama = 0;
  List<Kategori> gosterilenList = [];
  List<Kategori> kategoriList = [];
  TextEditingController kategoriAdi = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadThemeColor();
    loadId();
    loadSiralama();
    loadAnlamGizleme();
    kategoriGoster();
  }

  void loadThemeColor() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      karanlikMod = (pref.getBool('karanlikMod') ?? false);
      if (karanlikMod) {
        color1 = Colors.black;
        color2 = Color(0xFF303030);
        color3 = Colors.white;
      } else {
        themeColor = (pref.getInt('themeColor') ?? 4280391411);
        color1 = Color(themeColor);
        color2 = Colors.white;
        color3 = Colors.black;
      }
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: color1,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    });
  }

  void loadId() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      id = (pref.getInt('id') ?? 0);
    });
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
      kategoriSiralama = (pref.getInt('kategoriSiralama') ?? 0);
    });
  }

  void setSiralama(int value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      kategoriSiralama = value;
      prefs.setInt('kategoriSiralama', kategoriSiralama);
    });
    kategoriAraGizle();
    kategoriSirala();
    Navigator.of(context).pop();
  }

  void loadAnlamGizleme() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      anlamGizleme = (pref.getBool('anlamGizleme') ?? false);
    });
  }

  bool bosListeKontrol() {
    if (gosterilenList.isEmpty && appbarTitle) {
      snackbarGoster(context, "Önce kategori eklemelisiniz.", 1000);
      return false;
    } else {
      return true;
    }
  }

  void kategoriAraButton() {
    if (bosListeKontrol()) {
      setState(() {
        if (appbarTitle == true) {
          appbarTitle = false;
        } else {
          appbarTitle = true;
          kategoriSirala();
        }
      });
    }
  }

  void kategoriAraGizle() {
    if (appbarTitle == false) {
      appbarTitle = true;
    }
  }

  void kategoriGoster() {
    Provider.of<KategoriController>(context, listen: false)
        .kategoriListele()
        .then((value) {
      setState(() {
        kategoriList = value.toList();
        kategoriSirala();
      });
    });
  }

  void kategoriSirala() {
    setState(() {
      gosterilenList = kategoriList.toList();
      if (kategoriSiralama != 0) {
        switch (kategoriSiralama) {
          case 1:
            gosterilenList = gosterilenList.reversed.toList();
            break;
          case 2:
            gosterilenList.sort((a, b) {
              return a.kategoriAdi
                  .toLowerCase()
                  .compareTo(b.kategoriAdi.toLowerCase());
            });
            break;
          case 3:
            gosterilenList.sort((a, b) {
              return a.kategoriAdi
                  .toLowerCase()
                  .compareTo(b.kategoriAdi.toLowerCase());
            });
            gosterilenList = gosterilenList.reversed.toList();
            break;
        }
      }
    });
  }

  void ekleDuzenleDialogButton(String islem, Kategori kategori) {
    if (kategoriAdi.text.isEmpty) {
      snackbarGoster(context, "Lütfen kategori ismi giriniz.", 1500);
    } else {
      switch (islem) {
        case "Ekle":
          if (!ayniKategoriKontrol()) {
            kategoriEkle();
          }
          break;
        case "Kaydet":
          if (kategoriAdi.text == kategori.kategoriAdi) {
            snackbarGoster(
                context, "Kategori ismi zaten " + kategoriAdi.text + ".", 1500);
          } else {
            if (!ayniKategoriKontrol()) {
              kategoriDuzenle(kategori);
            }
          }
          break;
      }
    }
  }

  bool ayniKategoriKontrol() {
    if (gosterilenList
        .where((element) =>
            element.kategoriAdi.toLowerCase() == kategoriAdi.text.toLowerCase())
        .isNotEmpty) {
      snackbarGoster(
          context, kategoriAdi.text + " isminde bir kategori zaten var.", 1500);
      return true;
    }
    return false;
  }

  void kategoriEkle() {
    incrementId();
    kategoriList.add(Kategori(id: id, kategoriAdi: kategoriAdi.text));
    Provider.of<KategoriController>(context, listen: false)
        .kategoriEkle(id, kategoriAdi.text);
    snackbarGoster(context, kategoriAdi.text + " kategorisi eklendi.", 1000);
    kategoriAraGizle();
    kategoriSirala();
    Navigator.pop(context);
  }

  void kategoriDuzenle(Kategori kategori) {
    String eskiKategoriAdi = kategori.kategoriAdi;
    int index = kategoriList.indexOf(kategori);
    kategoriList[index].kategoriAdi = kategoriAdi.text;
    Provider.of<KategoriController>(context, listen: false).kategoriGuncelle(
        Kategori(id: kategori.id, kategoriAdi: kategoriAdi.text));
    Navigator.of(context).pop();
    snackbarGoster(
        context,
        eskiKategoriAdi +
            " kategorisi " +
            kategoriAdi.text +
            " olarak kaydedildi.",
        1500);
    kategoriAraGizle();
    kategoriSirala();
  }

  void kategoriSil(Kategori kategori) {
    Provider.of<KategoriController>(context, listen: false)
        .kategoriSil(kategori.id);
    Provider.of<EzberController>(context, listen: false)
        .tumEzberleriSil(kategori.id);
    setState(() {
      gosterilenList.removeWhere((element) => element.id == kategori.id);
      kategoriList.removeWhere((element) => element.id == kategori.id);
    });
    Navigator.of(context).pop();
    snackbarGoster(
        context, kategori.kategoriAdi + " kategorisi silindi.", 1000);
    kategoriAraGizle();
  }

  void kategoriAra(String aranan) {
    kategoriSirala();
    setState(() {
      if (aranan.isNotEmpty) {
        gosterilenList = gosterilenList
            .where((element) => element.kategoriAdi
                .toLowerCase()
                .contains(aranan.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> islemDialog(
      String islemText, String iptalText, Kategori kategori) {
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
                  controller: kategoriAdi,
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: kategori.kategoriAdi,
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
                          padding: const EdgeInsets.only(right: 5),
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
                          padding: const EdgeInsets.only(left: 5),
                          child: InkWell(
                            onTap: () {
                              ekleDuzenleDialogButton(islemText, kategori);
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
      kategoriAdi.clear();
    });
  }

  Future<void> uyariDialog(String mesaj, String buttonText, Kategori kategori) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    mesaj,
                    style: TextStyle(
                      fontSize: 16,
                      color: color3,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
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
                            child: buttonContent("İptal", Colors.grey),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              kategoriSil(kategori);
                            },
                            child: buttonContent(buttonText, color1),
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
    );
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
                  groupValue: kategoriSiralama,
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
                  groupValue: kategoriSiralama,
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
                  groupValue: kategoriSiralama,
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
                  groupValue: kategoriSiralama,
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: karanlikMod ? color2 : color1,
        brightness: Brightness.dark,
        title: appbarTitle
            ? Text(
                "Kategoriler",
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            : TextFormField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (text) {
                  kategoriAra(text);
                },
                decoration: InputDecoration(
                  hintText: "Kategori ara",
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                appbarTitle ? Icons.search : Icons.cancel,
                size: 28,
              ),
              onPressed: kategoriAraButton,
              tooltip: "Kategori ara",
            ),
          ),
        ],
      ),
      body: Container(
        color: karanlikMod ? color1 : color2,
        child: gosterilenList.isEmpty
            ? bosListeUyari("kategori", appbarTitle)
            : ListView.builder(
                itemCount: gosterilenList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<EzberController>(
                              create: (BuildContext context) {
                                return EzberController();
                              },
                              child: EzberlerEkrani(
                                  kategoriId: gosterilenList[index].id,
                                  kategoriAdi:
                                      gosterilenList[index].kategoriAdi),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: karanlikMod ? color2 : color1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                child: Text(
                                  gosterilenList[index].kategoriAdi,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      islemDialog("Kaydet", "İptal",
                                          gosterilenList[index]);
                                      kategoriAdi.text =
                                          gosterilenList[index].kategoriAdi;
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    tooltip: "Kategoriyi düzenle",
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      uyariDialog(
                                          gosterilenList[index].kategoriAdi +
                                              " kategorisi silinecek.",
                                          "Sil",
                                          gosterilenList[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    tooltip: "Kategoriyi sil",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          islemDialog(
              "Ekle", "Kapat", Kategori(id: 0, kategoriAdi: "Kategori ekle"));
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
        backgroundColor: karanlikMod ? color2 : color1,
        tooltip: 'Kategori ekle',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: Container(
        color: karanlikMod ? color1 : color2,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: karanlikMod ? color2 : color1,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<EzberController>(
                            create: (BuildContext context) {
                              return EzberController();
                            },
                            child: SeceneklerEkrani(
                              kategoriId: 0,
                              kategoriAdi: "",
                              ezberSayisi: 0,
                              ezberlendiSayisi: 0,
                            ),
                          ),
                        ),
                      );
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
                    tooltip: "Kategorileri sırala",
                    onPressed: () {
                      if (bosListeKontrol()) {
                        siralamaDialog();
                      }
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
