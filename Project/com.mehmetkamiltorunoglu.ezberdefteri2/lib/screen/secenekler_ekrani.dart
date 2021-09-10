import 'package:ezberdefteri2/component/dialog/hesap_islem_dialog.dart';
import 'package:ezberdefteri2/component/snackbar.dart';
import 'package:ezberdefteri2/component/widget/button_content.dart';
import 'package:ezberdefteri2/data/controller/ezber_controller.dart';
import 'package:ezberdefteri2/data/controller/kategori_controller.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeceneklerEkrani extends StatefulWidget {
  const SeceneklerEkrani(
      {Key? key,
      required this.kategoriId,
      required this.kategoriAdi,
      required this.ezberSayisi,
      required this.ezberlendiSayisi})
      : super(key: key);

  final int kategoriId;
  final String kategoriAdi;
  final int ezberSayisi;
  final int ezberlendiSayisi;

  @override
  _SeceneklerEkraniState createState() => _SeceneklerEkraniState();
}

class _SeceneklerEkraniState extends State<SeceneklerEkrani> {
  void setAnlamGizleme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      anlamGizleme = value;
      prefs.setBool('anlamGizleme', anlamGizleme);
    });
    yenidenBaslat();
    if (anlamGizleme) {
      snackbarGoster(
          context, "Ezber anlamları görünür olarak ayarlandı.", 1500);
    } else {
      snackbarGoster(
          context,
          "Ezber anlamları gizlendi. Anlamlarını görebilmek için ezberlere basmalısınız.",
          2500);
    }
  }

  void setKaranlikMod(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('karanlikMod', value);
    });
    yenidenBaslat();
  }

  void setThemeColor(int color) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('themeColor', color);
    });
    yenidenBaslat();
  }

  void yenidenBaslat() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<KategoriController>(
                create: (context) => KategoriController()),
            ChangeNotifierProvider<EzberController>(
                create: (context) => EzberController()),
          ],
          child: KategorilerEkrani(),
        ),
      ),
      (route) => false,
    );
  }

  void tumEzberleriTasi() {
    Provider.of<EzberController>(context, listen: false)
        .tumEzberleriTasi(widget.kategoriId);
    yenidenBaslat();
    snackbarGoster(
        context,
        widget.kategoriAdi +
            " kategorisindeki ezberlerin tümü ezberlenenler sayfasına taşındı.",
        2000);
  }

  void tumEzberlenenleriGeriYukle() {
    Provider.of<EzberController>(context, listen: false)
        .tumEzberlenenleriGeriYukle(widget.kategoriId);
    yenidenBaslat();
    snackbarGoster(
        context,
        widget.kategoriAdi +
            " kategorisindeki ezberlenenlerin tümü geri yüklendi.",
        1500);
  }

  void tumEzberlenenleriSil() {
    Provider.of<EzberController>(context, listen: false)
        .tumEzberlenenleriSil(widget.kategoriId);
    yenidenBaslat();
    snackbarGoster(
        context,
        widget.kategoriAdi + " kategorisindeki ezberlenenlerin tümü silindi.",
        1500);
  }

  void tumEzberleriSil() {
    Provider.of<EzberController>(context, listen: false)
        .tumEzberleriSil(widget.kategoriId);
    yenidenBaslat();
    snackbarGoster(context,
        widget.kategoriAdi + " kategorisindeki ezberlerin tümü silindi.", 1500);
  }

  Future<void> uyariDialog(String mesaj, String buttonText, int islem) {
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
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    mesaj,
                    style: TextStyle(
                      color: color3,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
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
                            switch (islem) {
                              case 0:
                                tumEzberleriTasi();
                                break;
                              case 1:
                                tumEzberlenenleriGeriYukle();
                                break;
                              case 2:
                                tumEzberlenenleriSil();
                                break;
                              case 3:
                                tumEzberleriSil();
                                break;
                            }
                          },
                          child: buttonContent(buttonText, color1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> temaRenkDialog() {
    List<Color> themeColorList = [
      Colors.orange,
      Colors.orange.shade900,
      Colors.red,
      Colors.red.shade900,
      Colors.lightGreen,
      Colors.green,
      Colors.lightGreen.shade900,
      Colors.green.shade900,
      Colors.teal,
      Colors.cyan,
      Colors.lightBlue,
      Colors.blue,
      Colors.blue.shade900,
      Colors.pinkAccent,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blueGrey,
      Colors.brown,
    ];
    int selectedIndex = 0;
    for (int i = 0; i < themeColorList.length; i++) {
      if (themeColor == themeColorList[i].value) {
        selectedIndex = i;
      }
    }
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          content: Container(
            height: 290,
            width: 200,
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(
                themeColorList.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      child: Container(
                        height: MediaQuery.of(context).size.width,
                        color: themeColorList[index],
                        child: selectedIndex == index
                            ? Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                      onTap: () {
                        if (selectedIndex == index) {
                          snackbarGoster(context,
                              "Zaten tema rengi olarak seçilmiş.", 1000);
                        } else {
                          setThemeColor(themeColorList[index].value);
                        }
                      },
                    ),
                  );
                },
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
        title: Text(
          "Seçenekler",
          style: TextStyle(fontSize: 18),
        ),
        backgroundColor: karanlikMod ? Colors.black : Colors.grey,
        brightness: Brightness.dark,
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
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Arayüz",
                        style: TextStyle(
                          color: color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Karanlık mod",
                              style: TextStyle(
                                color: color3,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: color1,
                            value: karanlikMod,
                            onChanged: (value) {
                              setKaranlikMod(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  karanlikMod
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Text(
                                      "Tema rengi",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: IconButton(
                                  onPressed: temaRenkDialog,
                                  icon: Icon(
                                    Icons.color_lens,
                                    color: color1,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  true
                      ? SizedBox.shrink()
                      : Divider(
                          color: Colors.grey,
                          indent: 100,
                          endIndent: 100,
                          thickness: 1,
                        ),
                  true
                      ? SizedBox.shrink()
                      : Row(
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Text(
                                    "Uygulama dili :",
                                    style: TextStyle(color: color3),
                                  ),
                                  Text(
                                    "   Türkçe",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.language,
                                color: color1,
                              ),
                            ),
                          ],
                        ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        "Ezberler",
                        style: TextStyle(
                          color: color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  widget.ezberSayisi == 0
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Kategorideki ezberlerin tümünü ezberlenenler sayfasına taşı.",
                                      style: TextStyle(
                                        color: color3,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    uyariDialog(
                                        widget.kategoriAdi +
                                            " kategorisindeki ezberlerin tümü ezberlenenler sayfasına taşınacak.",
                                        "Taşı",
                                        0);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Taşı",
                                      style: TextStyle(
                                        color: color1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  widget.ezberlendiSayisi == 0
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Kategorideki ezberlenenlerin tümünü geri yükle.",
                                      style: TextStyle(
                                        color: color3,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    uyariDialog(
                                        widget.kategoriAdi +
                                            " kategorisindeki ezberlenenlerin tümü geri yüklenecek.",
                                        "Geri yükle",
                                        1);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Geri yükle",
                                      style: TextStyle(
                                        color: color1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  widget.ezberlendiSayisi == 0
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Kategorideki ezberlenenlerin tümünü sil.",
                                      style: TextStyle(
                                        color: color3,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    uyariDialog(
                                        widget.kategoriAdi +
                                            " kategorisindeki ezberlenenlerin tümü silinecek.",
                                        "Sil",
                                        2);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Sil",
                                      style: TextStyle(
                                        color: color1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  widget.ezberSayisi == 0
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Kategorideki ezberlerin tümünü sil.",
                                      style: TextStyle(
                                        color: color3,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    uyariDialog(
                                        widget.kategoriAdi +
                                            " kategorisindeki ezberlerin tümü silinecek.",
                                        "Sil",
                                        3);
                                  },
                                  child: Center(
                                    child: Text(
                                      "Sil",
                                      style: TextStyle(
                                        color: color1,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  widget.ezberSayisi == 0 && widget.ezberlendiSayisi == 00
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            color: Colors.grey,
                            indent: 100,
                            endIndent: 100,
                            thickness: 1,
                          ),
                        ),
                  Row(
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Ezberlerin anlamlarını gizleme.",
                            style: TextStyle(
                              color: color3,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Transform.scale(
                          scale: 0.7,
                          child: CupertinoSwitch(
                            activeColor: color1,
                            value: anlamGizleme,
                            onChanged: (value) {
                              setAnlamGizleme(value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  true
                      ? SizedBox.shrink()
                      : Divider(
                          color: Colors.grey,
                          indent: 100,
                          endIndent: 100,
                          thickness: 1,
                        ),
                  true
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Verileri bir hesaba yedekle.",
                                      style: TextStyle(color: color3),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    HesapIslemDialog.hesapIslemDialog(
                                        context, "Yedekle");
                                  },
                                  child: buttonContent("Yedekle", color1),
                                ),
                              ),
                            ],
                          ),
                        ),
                  true
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "Verileri bir hesaptan geri yükle.",
                                      style: TextStyle(color: color3),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    HesapIslemDialog.hesapIslemDialog(
                                        context, "Geri yükle");
                                  },
                                  child: buttonContent("Geri yükle", color1),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 35),
                      child: Text(
                        "Hakkımda",
                        style: TextStyle(
                          color: color1,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: color1,
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage:
                                AssetImage('images/profile_picture.png'),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Mehmet Kamil Torunoğlu",
                                  style: TextStyle(
                                    color: color3,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Geliştirici",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.mail,
                                        color: color1,
                                        size: 20,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        "kamil.torunoglu@bil.omu.edu.tr",
                                        style: TextStyle(
                                          color: color3,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
