import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/providers/providers.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class WaiterScreen extends StatelessWidget {
  const WaiterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser!.uid;
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
                    onTap: () => firebaseAuth.signOut(),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.20,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.20,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        height: size.height * 0.20,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ]),
              ),
            );
          }
        });
  }
}
