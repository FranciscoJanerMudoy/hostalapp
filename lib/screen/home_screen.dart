import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/service/firebase_service.dart';
import '../models/models.dart';
import 'screens.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    List<Usuario> usuario = getUserById(user.uid) as List<Usuario>;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (usuario[0].tipo == "Cocinero") {
              return const LoginOrRegisterScreen();
            } else {
              return const LoginOrRegisterScreen();
            }
          } else {
            return const LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
