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
              List<Producto> productos = snapshot.data!;
              return Expanded(
                child: ListView.builder(
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    String type = productos[index].tipo!;
                    return ListTile(
                      title: Text(type),
                      onTap: () {
                        setState(() {
                          // ignore: unnecessary_null_comparison
                          tipoSeleccionado = type;
                        });
                      },
                      selected: tipoSeleccionado == type,
                    );
                  },
                ),
              );
            },
          ),
          Expanded(flex: 2, child: construirListaProductos(tipoSeleccionado)),
        ],
      ),
      bottomNavigationBar: productosSeleccionados.isNotEmpty
          ? Container(
              height: 50.0,
              color: Colors.blue,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    addComanda(productosSeleccionados, precioTotal);

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
      return FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          List<Producto> productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(productos[index].nombre!),
                trailing: Text(productos[index].precio.toString()),
                onTap: () {
                  setState(() {
                    productosSeleccionados.add(productos[index]);
                    precioTotal += productos[index].precio!;
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
          } else {
            List<Producto> productosPorTipo = snapshot.data!;

            return ListView.builder(
              itemCount: productosPorTipo.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(productosPorTipo[index].nombre!),
                  trailing: Text(productosPorTipo[index].precio.toString()),
                  onTap: () {
                    setState(() {
                      productosSeleccionados.add(productosPorTipo[index]);
                      precioTotal += productosPorTipo[index].precio!;
                    });
                  },
                );
              },
            );
          }
        },
      );
    }
  }
}


//TODO no funciona a la hora de añadir la comanda