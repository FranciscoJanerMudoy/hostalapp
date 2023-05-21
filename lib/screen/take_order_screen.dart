import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/providers/providers.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

class TakeOrderScreen extends StatefulWidget {
  const TakeOrderScreen({Key? key}) : super(key: key);

  @override
  State<TakeOrderScreen> createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  String tipoSeleccionado = "";

  @override
  Widget build(BuildContext context) {
    double precioTotal =
        Provider.of<ProductProvider>(context, listen: true).precioTotal;
    final productosAgrupados =
        Provider.of<ProductProvider>(context, listen: true).productosAgrupados;
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
      bottomNavigationBar: productosAgrupados.isNotEmpty
          ? Container(
              color: Colors.green,
              height: 50.0,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "ConfirmOrder");
                  },
                  child: Text(
                    'Añadir Comanda (${productosAgrupados.length}) - Total: ${precioTotal.toStringAsFixed(2)}\€',
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
                    Provider.of<ProductProvider>(context, listen: false)
                        .agregarProductoAgrupado(producto!);
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
                          arguments: producto)),
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .agregarProductoAgrupado(producto!);
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
