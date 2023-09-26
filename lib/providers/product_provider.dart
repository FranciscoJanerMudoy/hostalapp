import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

class ProductProvider extends ChangeNotifier {
  double precioTotal = 0.0;
  List<Producto> lProductosSeleccionados = [];

  void limpiarProductos() {
    lProductosSeleccionados.clear();
    precioTotal = 0.0;
    notifyListeners();
  }

  void agregarProductoSeleccionado(Producto producto) {
    if (lProductosSeleccionados.isEmpty) {
      producto.cantidad = 1;
      lProductosSeleccionados.add(producto);
    } else {
      bool productoExistente = false;

      for (var lproducto in lProductosSeleccionados) {
        if (lproducto.nombre == producto.nombre) {
          lproducto.cantidad = (lproducto.cantidad ?? 0) + 1;
          productoExistente = true;
          break;
        }
      }

      if (!productoExistente) {
        producto.cantidad = 1;
        lProductosSeleccionados.add(producto);
      }
    }

    precioTotal += producto.precio!;
    notifyListeners();
  }

  void eliminarProductoSeleccionado(Producto producto) {
    for (var lproducto in lProductosSeleccionados) {
      if (lproducto.nombre == producto.nombre) {
        if (lproducto.cantidad! > 1) {
          lproducto.cantidad = (lproducto.cantidad ?? 0) - 1;
        } else {
          lProductosSeleccionados.remove(lproducto);
        }
        break;
      }
    }

    precioTotal -= producto.precio!;
    notifyListeners();
  }
}
