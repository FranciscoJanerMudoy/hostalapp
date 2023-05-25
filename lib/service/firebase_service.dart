import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostalapp/models/models.dart';

import '../widgets/widgets.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
String? uid;

CollectionReference collectionUsers = db.collection("Usuarios");
CollectionReference collectionProducts = db.collection("Productos");
CollectionReference collectionOrders = db.collection("Comandas");

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
Future<List<Producto>> getProducts() async {
  List<Producto> productos = [];

  QuerySnapshot querySnapshot = await collectionProducts.get();

  for (var element in querySnapshot.docs) {
    productos.add(Producto.fromMap(element.data() as Map<String, dynamic>));
  }

  return productos;
}

Future<List<Producto>> getProductsByType(String tipo) async {
  List<Producto> productos = [];
  QuerySnapshot querySnapshot =
      await collectionProducts.where("tipo", isEqualTo: tipo).get();

  for (var element in querySnapshot.docs) {
    productos.add(
      Producto.fromMap(element.data() as Map<String, dynamic>),
    );
  }

  return productos;
}

//Metodos Comanda
Future<List<Comanda>> getOders() async {
  List<Comanda> comandas = [];
  QuerySnapshot querySnapshot = await collectionOrders.get();

  for (var element in querySnapshot.docs) {
    comandas.add(
      Comanda.fromMap(element.data() as Map<String, dynamic>),
    );
  }

  return comandas;
}

Future<void> addOrder(
    List<Producto> productos, double precio, String estado, int numMesa) async {
  QuerySnapshot querySnapshot = await collectionOrders.get();
  Comanda comanda = Comanda(
      id: querySnapshot.docs.length.toString(),
      productos: productos,
      precio: precio,
      estado: estado,
      mesa: numMesa);
  collectionOrders.add(comanda.toMap());
}

Future<void> deleteOrder(int id) async {
  final querySnapshot =
      await collectionOrders.where('mesa', isEqualTo: id).get();

  if (querySnapshot.docs.isNotEmpty) {
    final documentId = querySnapshot.docs[0].id;
    await collectionOrders.doc(documentId).delete();
  }
}

//Metodos Login
Future signIn(TextEditingController email, TextEditingController password,
    BuildContext context) async {
  try {
    await signInWithEmailAndPassword(email.text.trim(), password.text.trim());
  } on FirebaseAuthException {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
                titleText: 'Error de inicio de sesión',
                contentText: 'Email o contraseña incorrectos')
            .buildAlertDialog(context);
      },
    );
  }
}

Future signInWithEmailAndPassword(String email, String password) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
}

// Metodos SignUp
Future signUp(
    TextEditingController email,
    TextEditingController password,
    TextEditingController type,
    TextEditingController username,
    BuildContext context) async {
  final key = GlobalKey<FormState>();
  final esValid = key.currentState!.validate();
  if (!esValid) return;

  try {
    await createUserWithEmailAndPassword(email.text.trim(),
        password.text.trim(), type.text.trim(), username.text.trim(), context);
  } on FirebaseAuthException {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
                titleText: 'Error al registarse',
                contentText: 'Porfavor introduzca todos los campos')
            .buildAlertDialog(context);
      },
    );
  }
}

Future createUserWithEmailAndPassword(String email, String password,
    String type, String username, BuildContext context) async {
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password)
      .whenComplete(
          () => addUser(FirebaseAuth.instance.currentUser!.uid, type, username))
      .whenComplete(() => Navigator.pushNamed(context, 'Home'));
}

/* Metodo para añadir platos en el caso de que sea necessario
Future<void> addPlatos(Map<String, dynamic> productos) async {
  productos.forEach((key, value) async {
    await collectionProducts.add(value);
  });
}
*/
