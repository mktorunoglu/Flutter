import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Lütfen veri giriniz.";
                  }
                  return null;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length < 9) {
                    return "Lütfen 8 haneden daha uzun bir veri giriniz.";
                  }
                  return null;
                },
              ),
              Text(""),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("İşlem yapılıyor.")));
                    }
                  },
                  child: Text("Onayla"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
