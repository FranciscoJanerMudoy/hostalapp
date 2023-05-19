import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/service/firebase_service.dart';

class TakeOrderScreen extends StatefulWidget {
  const TakeOrderScreen({super.key});

  @override
  State<TakeOrderScreen> createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  String tipoSeleccionado = "";
  List<Producto> productosSeleccionados = [];
  double precioTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Realizar Comanda"),
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
                        title: Text(type),
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
          Expanded(flex: 3, child: construirListaProductos(tipoSeleccionado)),
        ],
      ),
      bottomNavigationBar: productosSeleccionados.isNotEmpty
          ? Container(
              height: 50.0,
              color: Colors.blue,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    addOrder(productosSeleccionados, precioTotal);

                    setState(() {
                      tipoSeleccionado = "";
                      productosSeleccionados.clear();
                      precioTotal = 0.0;
                    });
                  },
                  child: Text(
                    'Añadir Comanda (${productosSeleccionados.length}) - Total: \$${precioTotal.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget construirListaProductos(String tipo) {
    if (tipo == "") {
      return FutureBuilder<List<Producto>>(
        future: getProducts(),
        builder: (context, snapshot) {
          List<Producto>? productos = snapshot.data;
          return ListView.builder(
            itemCount: productos?.length ?? 0,
            itemBuilder: (context, index) {
              final producto = productos?[index];
              return ListTile(
                title: Text(producto?.nombre ?? ''),
                trailing: GestureDetector(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'Product',
                      arguments: Producto(
                          id: producto?.id,
                          nombre: producto?.nombre,
                          descripcion: producto?.descripcion,
                          tipo: producto?.tipo,
                          precio: producto?.precio),
                    );
                  },
                ),
                onTap: () {
                  setState(() {
                    productosSeleccionados.add(producto!);
                    precioTotal += producto.precio ?? 0;
                  });
                },
              );
            },
          );
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
            List<Producto>? productosPorTipo = snapshot.data;

            return ListView.builder(
              itemCount: productosPorTipo?.length ?? 0,
              itemBuilder: (context, index) {
                final productoPorTipo = productosPorTipo?[index];
                return ListTile(
                  title: Text(productoPorTipo?.nombre ?? ''),
                  trailing: GestureDetector(
                    child: const Icon(Icons.edit),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        'Product',
                        arguments: Producto(
                            id: productoPorTipo?.id,
                            nombre: productoPorTipo?.nombre,
                            descripcion: productoPorTipo?.descripcion,
                            tipo: productoPorTipo?.tipo,
                            precio: productoPorTipo?.precio),
                      );
                    },
                  ),
                  onTap: () {
                    setState(() {
                      productosSeleccionados.add(productoPorTipo!);
                      precioTotal += productoPorTipo.precio ?? 0;
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
