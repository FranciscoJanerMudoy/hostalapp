import 'package:flutter/material.dart';

class WaiterButton extends StatelessWidget {
  final String? route;
  final Icon icon;
  const WaiterButton({super.key, required this.route, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '$route');
      },
      child: icon,
    );
  }
}
