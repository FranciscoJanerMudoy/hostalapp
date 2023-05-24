import 'package:email_validator/email_validator.dart';
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
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _constrasena = TextEditingController();
  final TextEditingController _type = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
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
                height: _size.height * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  'Rellena los siguientes campos:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              fieldUserName(_size),
              SizedBox(
                height: _size.height * 0.01,
              ),
              fieldEmail(_size),
              SizedBox(
                height: _size.height * 0.01,
              ),
              fieldPassword(context, _size),
              SizedBox(
                height: _size.height * 0.01,
              ),
              fieldType(_size),
              SizedBox(
                height: _size.height * 0.01,
              ),
              MyButtonWidget(
                onTap: () =>
                    signUp(_email, _constrasena, _type, _username, context),
                text: "Registrar",
              ),
              SizedBox(
                height: _size.height * 0.09,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ya tienes cuenta?',
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

  Widget fieldUserName(Size size) {
    return SizedBox(
      width: size.width * 0.87,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: _username,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (nombre) => nombre!.startsWith(RegExp(r'[A-Z]'))
            ? null
            : "Porfavor introduzca la primera letra en mayusucla",
        decoration: InputDecoration(
          labelText: 'Nombre',
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
            borderSide: const BorderSide(color: Colors.black, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget fieldPassword(BuildContext context, Size size) {
    final passwProvider = Provider.of<PaswwProvider>(context);
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

  Widget fieldType(Size size) {
    return SizedBox(
      width: size.width * 0.87,
      child: DropdownButtonFormField<String>(
        value: _type.text.isNotEmpty ? _type.text : null,
        onChanged: (newValue) {
          setState(() {
            _type.text = newValue!;
          });
        },
        borderRadius: BorderRadius.circular(8),
        decoration: InputDecoration(
            labelText: 'Tipo de usuario',
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true),
        items: <String>['Cocinero', 'Camarero', 'Administrador']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        validator: (value) {
          if (value == null) {
            return 'Selecciona un tipo de usuario';
          }
          return null;
        },
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
