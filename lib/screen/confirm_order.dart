import 'package:flutter/material.dart';
import 'package:hostalapp/models/product_model.dart';
import 'package:hostalapp/providers/product_provider.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    List<Producto> productos = productProvider.productosAgrupados.values
        .expand((lista) => lista)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmar Comanda"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          construirListaProductosAgrupados(context),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              productProvider.limpiarProductos();

              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              addOrder(productos, productProvider.precioTotal, "En proceso");
              productProvider.limpiarProductos();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'Waiter', (route) => false);
            },
            child: const Text('Confirmar'),
          )
        ],
      ),
    );
  }
}

Widget construirListaProductosAgrupados(BuildContext context) {
  final productosAgrupados =
      Provider.of<ProductProvider>(context, listen: true).productosAgrupados;

  return Expanded(
    child: ListView.builder(
      itemCount: productosAgrupados.length,
      itemBuilder: (context, index) {
        final nombreProducto = productosAgrupados.keys.toList()[index];
        final productos = productosAgrupados.values.toList()[index];
        final cantidad = productos.length;

        return ListTile(
          title: Text(nombreProducto ?? ''),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: const Icon(Icons.remove),
                onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .eliminarProductoAgrupado(productos[0]);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '( $cantidad )',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: const Icon(Icons.add),
                onTap: () {
                  Provider.of<ProductProvider>(context, listen: false)
                      .agregarProductoAgrupado(productos[0]);
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
