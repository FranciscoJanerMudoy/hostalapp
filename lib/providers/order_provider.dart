import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/service/firebase_service.dart';

class OrderProvider extends ChangeNotifier {
  List<Comanda> comandas = [];
  List<Comanda> comandasByType = [];

  getAllComandas() async {
    comandas = await getOrders();
    notifyListeners();
  }

  getComandasByType(String tipo) async {
    comandasByType = await getOrdersByType(tipo);
    notifyListeners();
  }

  deleteById(int id) async {
    await deleteOrder(id);
    comandas.removeWhere((comanda) => comanda.mesa == id);
    comandasByType.removeWhere((comanda) => comanda.mesa == id);
    notifyListeners();
  }

  updateOrderState(int id, String nuevoEstado) async {
    await changeOrderState(id, nuevoEstado);
  }
}
