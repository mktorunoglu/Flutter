import 'dart:async';
import 'package:ezberdefteri2/component/dialog/ezberler_info_dialog.dart';
import 'package:ezberdefteri2/component/snackbar.dart';
import 'package:ezberdefteri2/component/widget/bos_liste_uyari.dart';
import 'package:ezberdefteri2/data/controller/ezber_controller.dart';
import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/ezberler_ekrani.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:ezberdefteri2/screen/secenekler_ekrani.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EzberlendiEkrani extends StatefulWidget {
  const EzberlendiEkrani(
      {Key? key, required this.kategoriId, required this.kategoriAdi})
      : super(key: key);

  final int kategoriId;
  final String kategoriAdi;

  @override
  _EzberlendiEkraniState createState() => _EzberlendiEkraniState();
}

class _EzberlendiEkraniState extends State<EzberlendiEkrani> {
  bool appbarTitle = true;
  List<Ezber> gosterilenList = [];
  List<Ezber> ezberList = [];
  List<double> opacity = [];

  @override
  void initState() {
    super.initState();
    ezberGoster();
  }

  void incrementId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = (prefs.getInt('id') ?? 0) + 1;
      prefs.setInt('id', id);
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

  void ezberAraButton() {
    setState(() {
      if (appbarTitle == true) {
        appbarTitle = false;
      } else {
        appbarTitle = true;
        ezberSirala();
      }
    });
  }

  void ezberAraGizle() {
    if (appbarTitle == false) {
      appbarTitle = true;
      ezberSirala();
    }
  }

  void ezberGoster() {
    Provider.of<EzberController>(context, listen: false)
        .ezberListele(widget.kategoriId, 1)
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

  void bosListeKontrol() {
    if (ezberList.isEmpty) {
      snackbarGoster(context, "Ezberlenenler sayfasında ezber kalmadı.", 1500);
      Navigator.of(context).pop();
    }
  }

  void ezberGeriYukle(Ezber ezber) {
    incrementId();
    Provider.of<EzberController>(context, listen: false).ezberSil(ezber.id);
    Provider.of<EzberController>(context, listen: false)
        .ezberEkle(id, ezber.kategoriId, 0, ezber.ezber, ezber.anlam);
    setState(() {
      gosterilenList.removeWhere((element) => element.id == ezber.id);
      ezberList.removeWhere((element) => element.id == ezber.id);
    });
    ezberAraGizle();
    bosListeKontrol();
  }

  void ezberSil(Ezber ezber) {
    Provider.of<EzberController>(context, listen: false).ezberSil(ezber.id);
    setState(() {
      gosterilenList.removeWhere((element) => element.id == ezber.id);
      ezberList.removeWhere((element) => element.id == ezber.id);
    });
    snackbarGoster(context, "Ezber silindi.", 500);
    ezberAraGizle();
    bosListeKontrol();
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
                "Ezberlenenler",
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
                                      primary: Colors.grey.shade300,
                                    ),
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
                                            fontSize: 14,
                                            color: color3,
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
                        ezberGeriYukle(gosterilenList[index]);
                      } else if (direction == DismissDirection.startToEnd) {
                        ezberSil(gosterilenList[index]);
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
                                Icons.delete,
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
                                Icons.settings_backup_restore,
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
      bottomNavigationBar: BottomAppBar(
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
                    List<Ezber> ezberlerList = [];
                    Provider.of<EzberController>(context, listen: false)
                        .ezberListele(widget.kategoriId, 0)
                        .then((value) {
                      ezberlerList = value.toList();
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
                              ezberSayisi: ezberlerList.length,
                              ezberlendiSayisi: ezberList.length,
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
                    siralamaDialog();
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
              Padding(
                padding: const EdgeInsets.all(5),
                child: IconButton(
                  icon: const Icon(
                    Icons.info,
                    size: 28,
                  ),
                  tooltip: "Yardım",
                  onPressed: () {
                    EzberlerInfoDialog.ezberlerInfoDialog(context, true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
