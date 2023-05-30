import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/service/firebase_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Comanda> comandas = [];

  getAllComandas() async {
    comandas = await getOrders();
    notifyListeners();
  }

  deleteById(int id) async {
    final orderIndex = comandas.indexWhere((comanda) => comanda.mesa == id);
    await deleteOrder(id);
    comandas.removeAt(orderIndex);
    notifyListeners();
  }

  updateOrderState(int id, String nuevoEstado) async {
    await changeOrderState(id, nuevoEstado);
  }
}
