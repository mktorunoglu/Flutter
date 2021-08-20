import 'package:flutter/material.dart';

class StateData with ChangeNotifier {
  String sehir = "Samsun";

  void yeniSehir(String yeniSehir) {
    sehir = yeniSehir;
    notifyListeners();
  }
}
