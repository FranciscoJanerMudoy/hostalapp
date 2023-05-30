import 'package:flutter/material.dart';
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
                  child: fieldTable(_size),
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
            onPressed: () async {
              if (_key.currentState!.validate()) {
                await addOrder(
                  productProvider.lProductosSeleccionados,
                  productProvider.precioTotal,
                  "En proceso",
                  _mesaSeleccionada!,
                );
                // ignore: use_build_context_synchronously
                Navigator.pushNamedAndRemoveUntil(
                    context, 'Waiter', (route) => false);
                productProvider.limpiarProductos();
              }
            },
            child: const Text('Confirmar'),
          )
        ],
      ),
    );
  }

  Widget fieldTable(Size size) {
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
    final productosSeleccionados =
        Provider.of<ProductProvider>(context, listen: true)
            .lProductosSeleccionados;

    return Expanded(
      child: ListView.builder(
        itemCount: productosSeleccionados.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productosSeleccionados[index].nombre ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(Icons.remove),
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .eliminarProductoSeleccionado(
                            productosSeleccionados[index]);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '( ${productosSeleccionados[index].cantidad} )',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: const Icon(Icons.add),
                  onTap: () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .agregarProductoSeleccionado(
                            productosSeleccionados[index]);
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
