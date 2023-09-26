import 'package:flutter/material.dart';

class AlertDialogWidget {
  String? titleText;
  String? contentText;
  AlertDialogWidget({required this.titleText, required this.contentText});
  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text('$titleText'),
      content: Text('$contentText'),
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
