import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Producto producto =
        ModalRoute.of(context)?.settings.arguments as Producto;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de Producto'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Text('Nombre: ${producto.nombre}'),
        ],
      )),
    );
  }
}
