import 'package:ezberdefteri2/component/dialog/alistirma_dialog.dart';
import 'package:ezberdefteri2/data/model/ezber_model.dart';
import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';

class CevaplarEkrani extends StatefulWidget {
  const CevaplarEkrani(
      {Key? key,
      required this.dogruYanlis,
      required this.cevapList,
      required this.yanlisCevapList})
      : super(key: key);

  final bool dogruYanlis;
  final List<Ezber> cevapList;
  final List yanlisCevapList;

  @override
  _CevaplarEkraniState createState() => _CevaplarEkraniState();
}

class _CevaplarEkraniState extends State<CevaplarEkrani> {
  Color color = Colors.green;

  @override
  void initState() {
    super.initState();
    setState(() {});
    if (!widget.dogruYanlis) {
      if (widget.yanlisCevapList.isEmpty) {
        color = Colors.redAccent;
      } else {
        color = color3;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: karanlikMod ? Colors.black : Colors.grey,
        brightness: Brightness.dark,
        title: Text(
          widget.dogruYanlis ? "Doğru cevaplananlar" : "Yanlış cevaplananlar",
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
        child: ListView.separated(
          itemCount: widget.cevapList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          anlamCalis
                              ? widget.cevapList[index].anlam
                              : widget.cevapList[index].ezber,
                          style: TextStyle(
                            color: color,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  !widget.dogruYanlis && widget.yanlisCevapList.isNotEmpty
                      ? Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.yanlisCevapList[index],
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Column(),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          anlamCalis
                              ? widget.cevapList[index].ezber
                              : widget.cevapList[index].anlam,
                          style: TextStyle(
                            color: !widget.dogruYanlis &&
                                    widget.yanlisCevapList.isNotEmpty
                                ? Colors.green
                                : color3,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: widget.dogruYanlis ? Colors.green : Colors.redAccent,
              height: 0,
              thickness: 2,
              indent: 15,
              endIndent: 15,
            );
          },
        ),
      ),
    );
  }
}
