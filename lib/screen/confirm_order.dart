import 'package:flutter/material.dart';
import 'package:hostalapp/models/product_model.dart';
import 'package:hostalapp/providers/product_provider.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  int? _mesaSeleccionada;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    List<Producto> productos = productProvider.productosAgrupados.values
        .expand((lista) => lista)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmar Comanda"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: _size.width,
          height: _size.height,
          child: Column(
            children: [
              SizedBox(
                height: _size.height * 0.03,
              ),
              Form(
                key: _key,
                child: Center(
                  child: fieldType(_size),
                ),
              ),
              construirListaProductosAgrupados(context)
            ],
          ),
        ),
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
              if (_key.currentState!.validate()) {
                addOrder(
                  productos,
                  productProvider.precioTotal,
                  "En proceso",
                  _mesaSeleccionada!,
                );
                productProvider.limpiarProductos();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'Waiter', (route) => false);
              }
            },
            child: const Text('Confirmar'),
          )
        ],
      ),
    );
  }

  Widget fieldType(Size size) {
    return SizedBox(
      width: size.width * 0.87,
      child: DropdownButtonFormField<int>(
        value: _mesaSeleccionada,
        onChanged: (newValue) {
          setState(() {
            _mesaSeleccionada = newValue;
          });
        },
        borderRadius: BorderRadius.circular(8),
        decoration: InputDecoration(
          labelText: 'Mesa',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
        ),
        items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map<DropdownMenuItem<int>>(
          (int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          },
        ).toList(),
        validator: (value) {
          if (value == null) {
            return 'Selecciona una mesa';
          }
          return null;
        },
      ),
    );
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
}
