import 'package:flutter/material.dart';

import '../service/firebase_service.dart';

class MesasProvider extends ChangeNotifier {
  List<int> mesasAsignadas = [];
  List<int> mesasDisponibles = [];
  getMesasDisponibles() async {
    List<int> mesas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    mesasAsignadas = await getOrdersTables();
    mesasDisponibles =
        mesas.where((mesa) => !mesasAsignadas.contains(mesa)).toList();
    notifyListeners();
  }
}
