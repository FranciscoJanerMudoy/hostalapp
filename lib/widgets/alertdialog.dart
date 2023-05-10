import 'package:flutter/material.dart';

class AlertDialogWidget {
  static AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Error de inicio de sesión'),
      content: const Text('Contraseña o correo electrónico incorrectos.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
