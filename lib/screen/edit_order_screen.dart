import 'package:flutter/material.dart';
import 'package:hostalapp/providers/order_provider.dart';
import 'package:provider/provider.dart';

class EditOrderScreen extends StatelessWidget {
  const EditOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);
    orderProvider.getAllComandas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar comanda'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: orderProvider.comandas.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Text('Comanda: ${orderProvider.comandas[index].mesa}'),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
