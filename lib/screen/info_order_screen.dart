import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/service/firebase_service.dart';

class InfoOrderScreen extends StatefulWidget {
  const InfoOrderScreen({Key? key}) : super(key: key);

  @override
  State<InfoOrderScreen> createState() => _InfoOrderScreenState();
}

class _InfoOrderScreenState extends State<InfoOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final Comanda comanda =
        ModalRoute.of(context)?.settings.arguments as Comanda;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información de la comanda'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Número de comanda:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              comanda.id.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Mesa:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              comanda.mesa.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Precio: ${comanda.precio}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Platos:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: comanda.productos!.length,
                itemBuilder: (context, index) {
                  final producto = comanda.productos![index];
                  return ListTile(
                    title: Text(producto.nombre ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.remove),
                          onTap: () {
                            setState(() {
                              if (producto.cantidad! > 1) {
                                comanda.productos![index].cantidad =
                                    comanda.productos![index].cantidad! - 1;
                                comanda.precio =
                                    (comanda.precio! - producto.precio!);
                              } else {
                                comanda.precio =
                                    (comanda.precio! - producto.precio!);
                                comanda.productos!.remove(producto);
                              }
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '( ${producto.cantidad} )',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          child: const Icon(Icons.add),
                          onTap: () {
                            setState(() {
                              comanda.productos![index].cantidad =
                                  comanda.productos![index].cantidad! + 1;
                              comanda.precio =
                                  (comanda.precio! + producto.precio!);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              updateOrder(comanda.id.toString(), comanda);
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}
