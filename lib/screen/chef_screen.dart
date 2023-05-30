import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';
import 'package:hostalapp/providers/providers.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

class ChefScreen extends StatefulWidget {
  const ChefScreen({Key? key}) : super(key: key);

  @override
  _ChefScreenState createState() => _ChefScreenState();
}

class _ChefScreenState extends State<ChefScreen> {
  late List<Comanda> comandas;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comandas en proceso'),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.logout),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("¿Estás seguro?"),
                    content: const Text("¿Deseas cerrar sesión?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Cancelar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Aceptar"),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'Home', (route) => false);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: orderProvider.comandas.length,
        itemBuilder: (context, index) {
          Comanda comanda = orderProvider.comandas[index];
          if (comanda.estado != "En preparación") {
            return Container(
              width: 200,
              margin: const EdgeInsets.all(8),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Comanda #${orderProvider.comandas[index].id}'),
                    const SizedBox(height: 8),
                    Text('Mesa: ${orderProvider.comandas[index].mesa}'),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: orderProvider.comandas[index].estado,
                      onChanged: (nuevoEstado) {
                        () {
                          changeOrderState(orderProvider.comandas[index].id!,
                              nuevoEstado!); // Actualizar el estado de la comanda al seleccionar un nuevo estado en el menú desplegable
                        };
                      },
                      items: [
                        'En preparación',
                        'Listo para servir',
                        'Entregado'
                      ].map<DropdownMenuItem<String>>(
                        (estado) {
                          return DropdownMenuItem<String>(
                            value: estado,
                            child: Text(estado),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No hay comandas en preparación"),
            );
          }
        },
      ),
    );
  }
}
