import 'package:flutter/material.dart';
import 'package:hostalapp/providers/order_provider.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

class EditOrderScreen extends StatelessWidget {
  const EditOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);

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
                title: Text(
                  'Comanda de la mesa: ${orderProvider.comandas[index].mesa}',
                  style: const TextStyle(fontSize: 20),
                ),
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "InfoOrder",
                      arguments: orderProvider.comandas[index]);
                },
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    orderProvider
                        .deleteById(orderProvider.comandas[index].mesa!);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
