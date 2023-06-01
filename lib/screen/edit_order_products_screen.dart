import 'package:flutter/material.dart';

import '../models/models.dart';
import '../service/firebase_service.dart';

class EditOrderProductsScreen extends StatefulWidget {
  const EditOrderProductsScreen({super.key});

  @override
  State<EditOrderProductsScreen> createState() =>
      _EditOrderProductsScreenState();
}

class _EditOrderProductsScreenState extends State<EditOrderProductsScreen> {
  String tipoSeleccionado = "";
  List<Producto> productosSeleccionados = [];

  @override
  Widget build(BuildContext context) {
    Comanda comanda = ModalRoute.of(context)?.settings.arguments as Comanda;
    List<Producto> productosComanda = [...comanda.productos!];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir productos"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          FutureBuilder(
            future: getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error al cargar los productos'),
                );
              } else {
                List<Producto>? productos = snapshot.data;
                List<String?>? tipos = productos
                    ?.map((producto) => producto.tipo)
                    .toSet()
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: tipos?.length,
                    itemBuilder: (context, index) {
                      String type = tipos?[index] ?? '';
                      return ListTile(
                        title: type.isNotEmpty
                            ? Image.asset('assets/$type.jpeg')
                            : const CircularProgressIndicator(),
                        onTap: () {
                          setState(() {
                            tipoSeleccionado = type;
                          });
                        },
                        selected: tipoSeleccionado == type,
                      );
                    },
                  ),
                );
              }
            },
          ),
          Expanded(flex: 4, child: construirListaProductos(tipoSeleccionado)),
        ],
      ),
      bottomNavigationBar: productosSeleccionados.isNotEmpty
          ? Container(
              color: Colors.green,
              height: 50.0,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    productosSeleccionados.forEach((element) {
                      productosComanda.add(element);
                      comanda.precio =
                          (comanda.precio ?? 0) + (element.precio ?? 0);
                    });
                    comanda.productos = productosComanda;
                    Navigator.pop(context, comanda);
                  },
                  child: Text(
                    'Añadir productos (${productosSeleccionados.length})',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget construirListaProductos(String tipo) {
    if (tipo.isEmpty) {
      return FutureBuilder<List<Producto>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los productos'),
            );
          } else if (snapshot.hasData) {
            List<Producto>? productos = snapshot.data;
            return ListView.builder(
              itemCount: productos?.length,
              itemBuilder: (context, index) {
                Producto? producto = productos?[index];
                return ListTile(
                  title: Text(producto?.nombre ?? ''),
                  trailing: GestureDetector(
                    child: const Icon(Icons.info),
                    onTap: () => Navigator.pushNamed(context, 'Product',
                        arguments: producto),
                  ),
                  onTap: () {
                    setState(() {
                      productosSeleccionados.add(producto!);
                    });
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      return FutureBuilder<List<Producto>>(
        future: getProductsByType(tipo),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error al cargar los productos'),
            );
          } else if (snapshot.hasData) {
            List<Producto>? productos = snapshot.data;
            return ListView.builder(
              itemCount: productos?.length,
              itemBuilder: (context, index) {
                Producto? producto = productos?[index];
                return ListTile(
                  title: Text(producto?.nombre ?? ''),
                  trailing: GestureDetector(
                    child: const Icon(Icons.info),
                    onTap: () => Navigator.pushNamed(context, 'Product',
                        arguments: producto),
                  ),
                  onTap: () {
                    setState(() {
                      productosSeleccionados.add(producto!);
                    });
                  },
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }
}
