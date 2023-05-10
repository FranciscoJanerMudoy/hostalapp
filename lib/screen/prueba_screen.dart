import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PruebaScreen extends StatelessWidget {
  const PruebaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hola bona tarda"),
        actions: [
          GestureDetector(
            onTap: () => FirebaseAuth.instance.signOut(),
            child: const Icon(Icons.door_front_door),
          )
        ],
      ),
    );
  }
}
