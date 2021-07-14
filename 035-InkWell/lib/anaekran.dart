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
        child: InkWell(
          onTap: () => null,
          hoverColor: Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Text"),
          ),
        ),
      ),
    );
  }
}
