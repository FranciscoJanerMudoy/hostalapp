import 'package:flutter/material.dart';

class WaiterButton extends StatelessWidget {
  final String? route;
  final String? text;
  final Function? function;
  const WaiterButton(
      {super.key, required this.route, required this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function as void Function()?,
      child: Text('$text'),
    );
  }
}
