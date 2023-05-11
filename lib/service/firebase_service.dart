import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
String? uid;

CollectionReference collection_users = db.collection("Usuarios");
CollectionReference collection_products = db.collection("Productos");

Future<void> addUser(String uid, String tipo, String nombre) async {
  Usuario usuario = Usuario(uid: uid, tipo: tipo, nombre: nombre);
  await collection_users.add(usuario.toMap());
}

Future<Usuario> getUserById(String uid) async {
  Usuario usuario = Usuario();
  QuerySnapshot querySnapshot =
      await collection_users.where("uid", isEqualTo: uid).get();

  querySnapshot.docs.forEach((element) {
    usuario = Usuario.fromMap(element.data() as Map<String, dynamic>);
  });

  return usuario;
}

Future<List<Product>> getAllProducts() async {
  List<Product> productos = [];

  QuerySnapshot querySnapshot = await collection_products.get();

  querySnapshot.docs.forEach((element) {
    productos.add(Product.fromMap(element.data() as Map<String, dynamic>));
  });

  return productos;
}
