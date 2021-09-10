import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/alistirma_karisik_ezber.dart';
import 'package:ezberdefteri2/screen/alistirma_yazarak_calis.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool anlamCalis = false;

class AlistirmaDialog extends StatefulWidget {
  const AlistirmaDialog({Key? key, required this.ezberList}) : super(key: key);

  final List<Ezber> ezberList;

  @override
  _AlistirmaDialogState createState() => _AlistirmaDialogState();

  static void alistirmaDialog(BuildContext context, List<Ezber> ezberList) {
    showDialog(
      context: context,
      builder: (context) {
        return AlistirmaDialog(ezberList: ezberList);
      },
    );
  }
}

class _AlistirmaDialogState extends State<AlistirmaDialog> {
  @override
  void initState() {
    super.initState();
    loadAnlamCalis();
  }

  void loadAnlamCalis() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      anlamCalis = (pref.getBool('anlamCalis') ?? false);
    });
  }

  void setAnlamCalis(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      anlamCalis = value;
      prefs.setBool('anlamCalis', anlamCalis);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AlistirmaKarisikEzber(ezberList: widget.ezberList),
                    ),
                  );
                },
                child: Card(
                  color: color1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "Karışık ezberlerle çalış",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ),
                        Text(
                          "Gösterilen ezberin anlamını bilmeye çalış ve cevabını kontrol et.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AlistirmaYazarakCalis(ezberList: widget.ezberList),
                      ),
                    );
                  },
                  child: Card(
                    color: color1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Yazarak çalış",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Divider(
                              color: Colors.white,
                              thickness: 2,
                            ),
                          ),
                          Text(
                            "Gösterilen ezberin anlamını yazıp gönder.\n",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Yanlış cevaplara alıştırma sonunda bakılabilecektir.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: color1,
                      value: anlamCalis,
                      onChanged: (bool? value) {
                        setState(() {
                          setAnlamCalis(value!);
                        });
                      },
                    ),
                    Flexible(
                      child: SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          child: Text(
                            "Ezberlerin anlamlarına çalış",
                            style: TextStyle(
                              fontSize: 12,
                              color: color3,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (anlamCalis) {
                                setAnlamCalis(false);
                              } else {
                                setAnlamCalis(true);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
