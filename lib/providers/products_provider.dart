import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/service/firebase_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productos = [];

  ProductProvider() {
    getAllProducts();
  }

  getAllProducts() async {
    productos = await getProducts();

    notifyListeners();
  }
}
