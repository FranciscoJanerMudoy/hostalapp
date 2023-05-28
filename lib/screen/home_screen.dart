import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                  return const WaiterScreen(); // Puedes mostrar la misma pantalla para ambos tipos de usuario
                }
                if (snapshot.hasError) {
                  // Maneja los errores adecuadamente
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error.toString()}'),
                    ),
                  );
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
