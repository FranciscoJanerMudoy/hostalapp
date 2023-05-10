import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
String? uid;

CollectionReference collection_users = db.collection("Usuarios");

Future<void> addUser(String uid, String tipo) async {
  Usuario usuario = Usuario(uid: uid, tipo: tipo);
  await collection_users.add(usuario.toMap());
}

//TODO REALIZAR ESTE METODO
Future<Usuario> getUserById(String uid) async {
  Usuario usuario = Usuario();
  QuerySnapshot querySnapshot =
      await collection_users.where("uid", isEqualTo: uid).get();

  querySnapshot.docs.forEach((element) {
    usuario = Usuario.fromMap(element.data() as Map<String, dynamic>);
  });

  return usuario;
}
