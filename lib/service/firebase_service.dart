import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
CollectionReference collection_users = db.collection("usuarios");

Future<void> addUser(String uid, String tipo) async {
  Usuario usuario = Usuario(uid: uid, tipo: tipo);
  await collection_users.add(usuario.toMap());
}
/*
Future<User> getUserById(String id) async {
  CollectionReference users = db.collection("users");

  QuerySnapshot querySnapshot = await users.get();

  
  
}
*/