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
        title: const Text('Detalles del Producto'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              producto.nombre ?? '',
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              producto.descripcion ?? '',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Tipo:',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              producto.tipo ?? '',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Precio:',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              '${producto.precio?.toStringAsFixed(2)}\€',
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
