import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference collection_users = db.collection("Usuarios");

Future<void> addUser(String uid, String tipo) async {
  Usuario usuario = Usuario(uid: uid, tipo: tipo);
  await collection_users.add(usuario.toMap());
}

Future<List<Usuario>> getUserById(String uid) async {
  List<Usuario> usuarios = [];

  QuerySnapshot querySnapshot =
      await collection_users.where("uid", isEqualTo: uid).get();

  querySnapshot.docs.forEach((element) {
    usuarios.add(Usuario.fromMap(element.data() as Map<String, dynamic>));
  });

  return usuarios;
}
