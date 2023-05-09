import 'package:flutter/material.dart';
import 'package:hostalapp/screen/screens.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegiserPageState();
}

class _LoginOrRegiserPageState extends State<LoginOrRegisterScreen> {
  bool mostrarSignInScreen = true;

  void cambiarPaginas() {
    setState(() {
      mostrarSignInScreen = !mostrarSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mostrarSignInScreen) {
      return LogInScreen(
        onTap: cambiarPaginas,
      );
    } else {
      return RegisterScreen(
        onTap: cambiarPaginas,
      );
    }
  }
}
