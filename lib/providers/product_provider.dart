import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

class ProductProvider extends ChangeNotifier {
  double precioTotal = 0.0;
  Map<String?, List<Producto>> productosAgrupados = {};

  void limpiarProductos() {
    productosAgrupados.clear();
    precioTotal = 0.0;
    notifyListeners();
  }

  void agregarProductoAgrupado(Producto producto) {
    final String? nombreProducto = producto.nombre;
    productosAgrupados[nombreProducto] ??= [];
    productosAgrupados[nombreProducto]!.add(producto);

    precioTotal += producto.precio!;
    notifyListeners();
  }

  void eliminarProductoAgrupado(Producto producto) {
    final String? nombreProducto = producto.nombre;
    if (productosAgrupados.containsKey(nombreProducto)) {
      final List<Producto> productos = productosAgrupados[nombreProducto]!;
      if (productos.length > 1) {
        productosAgrupados[nombreProducto]!.remove(producto);
      } else {
        productosAgrupados.remove(nombreProducto);
      }
      precioTotal -= producto.precio!;
    }
    notifyListeners();
  }
}
