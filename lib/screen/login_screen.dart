import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/service/firebase_service.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LogInScreen extends StatefulWidget {
  final Function()? onTap;
  const LogInScreen({super.key, required this.onTap});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _email = TextEditingController();

  final _constrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: _size.height * 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wine_bar,
                  size: _size.height * 0.05,
                  color: Colors.green,
                ),
                Text(
                  'HOSTAL ALGAIDA',
                  style: TextStyle(
                      fontSize: _size.width * 0.1, color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              height: _size.height * 0.1,
            ),
            fieldEmail(_size),
            const Divider(
              color: Colors.white,
            ),
            fieldPassword(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: _size.width * 0.5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Reset',
                        arguments: _email.text);
                  },
                  child: const Text('Contraseña perdida?'),
                )
              ],
            ),
            MyButtonWidget(
              onTap: () => signIn(_email, _constrasena, context),
              text: "LOG IN",
            ),
            SizedBox(
              height: _size.height * 0.27,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No tienes cuenta?',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: _size.width * 0.02,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Clica aqui!!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget fieldEmail(Size size) {
    return SizedBox(
      width: size.width * 0.87,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email != null && EmailValidator.validate(email)
            ? null
            : 'Introduce un email valido',
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
    final passwProvider = Provider.of<PaswwProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.87,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (valor) => valor != null && valor.length < 6
            ? 'Introduce un minimo de 6 caracteres'
            : null,
        controller: _constrasena,
        obscureText: passwProvider.password,
        decoration: InputDecoration(
          labelText: 'Contraseña',
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
}
