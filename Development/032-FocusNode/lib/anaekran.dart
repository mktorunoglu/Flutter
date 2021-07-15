import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  _AnaEkranState createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
                autofocus: true,
                onSubmitted: (value) => focusNode.requestFocus(),
              ),
              TextField(
                focusNode: focusNode,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: null,
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
