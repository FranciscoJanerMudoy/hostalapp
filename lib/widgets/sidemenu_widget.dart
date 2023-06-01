import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 69, 69, 69),
      child: ListView(children: [
        ListTile(
          leading: const Icon(Icons.settings_outlined, color: Colors.white),
          title: const Text(
            'Agregar Producto',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'AddProducto');
          },
        ),
        ListTile(
          leading: const Icon(Icons.inventory, color: Colors.white),
          title: const Text(
            'Editar Producto',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'Tenda');
          },
        ),
        ListTile(
          leading: const Icon(Icons.info, color: Colors.white),
          title: const Text(
            'Missions',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pushNamed(context, 'Tutorial');
          },
        ),
      ]),
    );
  }
}
