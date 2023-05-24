import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/service/firebase_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Comanda> comandas = [];

  getAllComandas() async {
    comandas = await getOders();
    notifyListeners();
  }
}
