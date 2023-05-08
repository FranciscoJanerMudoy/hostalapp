import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _email = TextEditingController();

  final _constrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/logotransparent.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            fieldEmail(),
            const Divider(
              color: Colors.white,
            ),
            fieldPassword(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 180,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Reset',
                        arguments: _email.text);
                  },
                  child: const Text('Contrasenya perduda?'),
                )
              ],
            ),
            MyButton(
              onTap: () => Navigator.pushNamed(context, ''),
              text: "LOG IN",
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget fieldEmail() {
    return SizedBox(
      width: 340,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email != null && EmailValidator.validate(email)
            ? null
            : 'Introdueix un email valid',
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 10),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget fieldPassword(BuildContext context) {
    final passwProvider = Provider.of<LoginProvider>(context);

    return SizedBox(
      width: 340,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (valor) => valor != null && valor.length < 6
            ? 'Introdueix un minim de 6 caracters'
            : null,
        controller: _constrasena,
        obscureText: passwProvider.password,
        decoration: InputDecoration(
          labelText: 'Contrasenya',
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 10),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            icon: Icon(passwProvider.password
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded),
            onPressed: () {
              passwProvider.actualizarContra();
            },
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _constrasena.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text.trim(), password: _constrasena.text.trim());
    } on FirebaseAuthException {}
  }
}
