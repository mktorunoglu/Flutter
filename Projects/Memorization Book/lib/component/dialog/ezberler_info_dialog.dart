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
                                  widget.ezberlendi ? "Geri y??kle" : "D??zenle",
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
                                  ? "Ezberleri sola do??ru kayd??rarak geri y??kleyebilirsiniz."
                                  : "Ezberleri sola do??ru kayd??rarak d??zenleyebilirsiniz.",
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
                                      : "Ezberlendi olarak i??aretle",
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
                                  ? "Ezberleri sa??a do??ru kayd??rarak silebilirsiniz."
                                  : "Ezberleri sa??a do??ru kayd??rarak ezberlendi olarak i??aretleyebilirsiniz.",
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
                                "T??m??ne uygula",
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
                                ? "T??m ezberleri geri y??kleme ve silme i??lemlerini se??enekler ekran??ndan yapabilirsiniz."
                                : "T??m ezberleri ezberlendi olarak i??aretleme ve silme i??lemlerini se??enekler ekran??ndan yapabilirsiniz.",
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
