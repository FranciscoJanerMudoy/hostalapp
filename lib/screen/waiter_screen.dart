import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WaiterScreen extends StatelessWidget {
  const WaiterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buenas "),
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
