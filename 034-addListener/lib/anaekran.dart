import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _formKey = GlobalKey<FormState>();
  final tec1 = TextEditingController();
  final tec2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    tec1.addListener(() {
      tec2.text = tec1.text;
    });
  }

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
              TextField(
                controller: tec1,
              ),
              TextField(
                controller: tec2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
