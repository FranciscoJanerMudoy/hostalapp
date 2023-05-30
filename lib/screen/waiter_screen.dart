import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/providers/order_provider.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class WaiterScreen extends StatelessWidget {
  const WaiterScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String? uid = firebaseAuth.currentUser?.uid;
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder<Usuario?>(
      future: getUserById(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  snapshot.data!.nombre.toString(),
                ),
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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.20,
                      child: WaiterButton(
                        route: 'Take',
                        text: "   Añadir\nComanda",
                        function: () =>
                            Navigator.pushNamed(context, "TakeOrder"),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.20,
                      child: WaiterButton(
                        route: 'EditOrder',
                        text: 'Modificar\nComanda',
                        function: () {
                          Provider.of<OrderProvider>(context, listen: false)
                              .getAllComandas();
                          Navigator.pushNamed(context, "EditOrder");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('No se pudo cargar la información del usuario.'),
              ),
            );
          }
        }
      },
    );
  }
}
