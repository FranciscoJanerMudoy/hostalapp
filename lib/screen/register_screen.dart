import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();

  final _constrasena = TextEditingController();

  final _name = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'Emplena els següents camps:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              fieldEmail(),
              const Divider(
                color: Colors.white,
              ),
              fieldPassword(context),
              const Divider(
                color: Colors.white,
              ),
              MyButton(
                onTap: signUp,
                text: "Registrar",
              ),
              const SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ja tens compte?',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Inicia aqui!!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
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
            borderSide: const BorderSide(color: Colors.black, width: 3),
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
            borderSide: const BorderSide(color: Colors.black, width: 3),
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
    _name.dispose();
    _email.dispose();
    _constrasena.dispose();
    super.dispose();
  }

  Future signUp() async {
    final esValid = _key.currentState!.validate();
    if (!esValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _constrasena.text.trim());
    } on FirebaseAuthException {}
  }
}
