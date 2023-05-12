import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
String? uid;

CollectionReference collectionUsers = db.collection("Usuarios");
CollectionReference collectionProducts = db.collection("Productos");

// Metodos Usuarios
Future<void> addUser(String uid, String tipo, String nombre) async {
  Usuario usuario = Usuario(uid: uid, tipo: tipo, nombre: nombre);
  await collectionUsers.add(usuario.toMap());
}

Future<Usuario> getUserById(String uid) async {
  Usuario usuario = Usuario();
  QuerySnapshot querySnapshot =
      await collectionUsers.where("uid", isEqualTo: uid).get();

  for (var element in querySnapshot.docs) {
    usuario = Usuario.fromMap(element.data() as Map<String, dynamic>);
  }

  return usuario;
}

// Metodos Productos
Future<List<Product>> getProducts() async {
  List<Product> productos = [];

  QuerySnapshot querySnapshot = await collectionProducts.get();

  for (var element in querySnapshot.docs) {
    productos.add(Product.fromMap(element.data() as Map<String, dynamic>));
  }

  return productos;
}

/* Metodo para añadir platos en el caso de que sea necessario
Future<void> addPlatos(Map<String, dynamic> productos) async {
  productos.forEach((key, value) async {
    await collectionProducts.add(value);
  });
}
*/
