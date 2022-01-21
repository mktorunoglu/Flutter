import 'package:ezberdefteri2/screen/kategoriler_ekrani.dart';
import 'package:flutter/material.dart';

class EzberlerInfoDialog extends StatefulWidget {
  const EzberlerInfoDialog({Key? key, required this.ezberlendi})
      : super(key: key);

  final bool ezberlendi;

  @override
  _EzberlerInfoDialogState createState() => _EzberlerInfoDialogState();

  static void ezberlerInfoDialog(BuildContext context, bool ezberlendi) {
    showDialog(
      context: context,
      builder: (context) {
        return EzberlerInfoDialog(ezberlendi: ezberlendi);
      },
    );
  }
}

class _EzberlerInfoDialogState extends State<EzberlerInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        widget.ezberlendi
                            ? Icons.settings_backup_restore
                            : Icons.edit_outlined,
                        color: color1,
                        size: 28,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.ezberlendi ? "Geri yükle" : "Düzenle",
                                  style: TextStyle(
                                    color: color1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              widget.ezberlendi
                                  ? "Ezberleri sola doğru kaydırarak geri yükleyebilirsiniz."
                                  : "Ezberleri sola doğru kaydırarak düzenleyebilirsiniz.",
                              style: TextStyle(
                                fontSize: 14,
                                color: color3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        widget.ezberlendi
                            ? Icons.delete_outline
                            : Icons.done_outline,
                        color: color1,
                        size: 28,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  widget.ezberlendi
                                      ? "Sil"
                                      : "Ezberlendi olarak işaretle",
                                  style: TextStyle(
                                    color: color1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              widget.ezberlendi
                                  ? "Ezberleri sağa doğru kaydırarak silebilirsiniz."
                                  : "Ezberleri sağa doğru kaydırarak ezberlendi olarak işaretleyebilirsiniz.",
                              style: TextStyle(
                                fontSize: 14,
                                color: color3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.clear_all,
                      color: color1,
                      size: 28,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Tümüne uygula",
                                style: TextStyle(
                                  color: color1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            widget.ezberlendi
                                ? "Tüm ezberleri geri yükleme ve silme işlemlerini seçenekler ekranından yapabilirsiniz."
                                : "Tüm ezberleri ezberlendi olarak işaretleme ve silme işlemlerini seçenekler ekranından yapabilirsiniz.",
                            style: TextStyle(
                              fontSize: 14,
                              color: color3,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
