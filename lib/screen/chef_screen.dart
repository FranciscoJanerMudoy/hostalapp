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
    TextEditingController _nuevoEstado = TextEditingController();
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getAllComandas();

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
          if (comanda.estado == "En preparación") {
            return Container(
              width: 200,
              margin: const EdgeInsets.all(8),
              child: Card(
                elevation: 20,
                child: Column(
                  children: [
                    Text('Comanda #${comanda.id}'),
                    const SizedBox(height: 8),
                    Text('Mesa: ${comanda.mesa}'),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: comanda.estado,
                      onChanged: (nuevoEstado) {
                        orderProvider.updateOrderState(
                            comanda.mesa!, nuevoEstado!);
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
          }
        },
      ),
    );
  }
}
