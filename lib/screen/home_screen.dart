import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/screen/chef_screen.dart';
import 'package:hostalapp/service/firebase_service.dart';
import '../models/models.dart';
import 'screens.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  Usuario usuario = snapshot.data!;
                  if (usuario.tipo == "Cocinero") {
                    return const ChefScreen();
                  }
                  if (usuario.tipo == "Camarero") {
                    return const WaiterScreen();
                  }
                  if (usuario.tipo == "Administrador") {
                    return const AdminScreen();
                  }
                }
                if (snapshot.hasError) {
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
