import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/providers/providers.dart';
import 'package:provider/provider.dart';

class ChefScreen extends StatelessWidget {
  const ChefScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          orderProvider.getAllComandas();

          return Wrap(
            spacing: 5,
            runSpacing: 5,
            children: orderProvider.comandas
                .where((comanda) => comanda.estado == "En preparación")
                .map((comanda) => Container(
                      width: size.width * 0.19,
                      height: size.height * 0.4,
                      margin: const EdgeInsets.all(5),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Comanda #${comanda.id}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Mesa: ${comanda.mesa}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: comanda.productos!.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          comanda.productos![index].nombre ??
                                              '',
                                        ),
                                        trailing: Text(comanda
                                            .productos![index].cantidad
                                            .toString()),
                                        dense: true,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DropdownButton<String>(
                                value: comanda.estado,
                                onChanged: (nuevoEstado) {
                                  orderProvider.updateOrderState(
                                    comanda.mesa!,
                                    nuevoEstado!,
                                  );
                                },
                                items: ['En preparación', 'Entregado']
                                    .map<DropdownMenuItem<String>>(
                                  (estado) {
                                    return DropdownMenuItem<String>(
                                      value: estado,
                                      child: Text(
                                        estado,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
