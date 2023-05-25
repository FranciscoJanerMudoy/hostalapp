import 'package:flutter/material.dart';

class WaiterButton extends StatelessWidget {
  final String? route;
  final String? text;
  const WaiterButton({super.key, required this.route, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '$route');
      },
      child: Text('$text'),
    );
  }
}
