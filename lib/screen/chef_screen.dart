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
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          orderProvider.getAllComandas();
          return Wrap(
            spacing: size.width * 0.001,
            runSpacing: size.width * 0.001,
            children: orderProvider.comandas
                .where((comanda) => comanda.estado == "En preparación")
                .map((comanda) => Container(
                      width: size.width * 0.18,
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
                              SizedBox(height: size.height * 0.02),
                              Text(
                                'Mesa: ${comanda.mesa}',
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: size.height * 0.01),
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
                              SizedBox(height: size.height * 0.01),
                              DropdownButton<String>(
                                value: comanda.estado,
                                onChanged: (nuevoEstado) {
                                  orderProvider.updateOrderState(
                                    comanda.mesa!,
                                    nuevoEstado!,
                                  );
                                  orderProvider.getComandasByType("Entregado");
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
