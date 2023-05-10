import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/screen/prueba_screen.dart';
import 'package:hostalapp/service/firebase_service.dart';
import '../models/models.dart';
import 'screens.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null) {
            return FutureBuilder<Usuario>(
              future: getUserById(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  String? tipoUsuario = snapshot.data!.tipo;
                  if (tipoUsuario == "Cocinero") {
                    return const PruebaScreen();
                  } else if (tipoUsuario == "Camarero") {
                    return const PruebaScreen();
                  }
                }
                return const LoginOrRegisterScreen();
              },
            );
          }
        }
        return const LoginOrRegisterScreen();
      },
    );
  }
}
