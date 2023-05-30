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

Future<Usuario> getUserById(String? uid) async {
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
Future<List<Comanda>> getOrders() async {
  List<Comanda> comandas = [];
  QuerySnapshot querySnapshot = await collectionOrders.get();

  for (var element in querySnapshot.docs) {
    comandas.add(
      Comanda.fromMap(element.data() as Map<String, dynamic>),
    );
  }

  return comandas;
}

Future<List<int>> getOrdersTables() async {
  List<int> mesas = [];
  QuerySnapshot? querySnapshot = await collectionOrders.get();

  mesas = querySnapshot.docs.map((doc) => doc.get('mesa') as int).toList();
  return mesas;
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

Future<void> changeOrderState(String id, String nuevoEstado) async {
  collectionOrders.doc(id).update({'estado': nuevoEstado});
}

Future<void> deleteOrder(int id) async {
  QuerySnapshot querySnapshot =
      await collectionOrders.where('mesa', isEqualTo: id).get();

  if (querySnapshot.docs.isNotEmpty) {
    final documentId = querySnapshot.docs[0].id;
    await collectionOrders.doc(documentId).delete();
  }
}

Future<void> updateOrder(String id, Comanda comanda) async {
  QuerySnapshot querySnapshot =
      await collectionOrders.where('id', isEqualTo: id).get();
  if (querySnapshot.docs.isNotEmpty) {
    final documentId = querySnapshot.docs[0].id;
    await collectionOrders.doc(documentId).update(comanda.toMap());
  }
}

//Metodos Login
Future signIn(String email, String password, BuildContext context) async {
  try {
    await signInWithEmailAndPassword(email, password);
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
Future<void> signUp(
  String email,
  String password,
  String type,
  String username,
  BuildContext context,
  GlobalKey<FormState> key,
) async {
  final isValid = key.currentState?.validate() ?? false;
  if (!isValid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          titleText: 'Error al registrarse',
          contentText: 'Por favor, introduzca todos los campos',
        ).buildAlertDialog(context);
      },
    );
  } else {
    await createUserWithEmailAndPassword(
      email.trim(),
      password.trim(),
      type.trim(),
      username.trim(),
      context,
    );
  }
}

Future<void> createUserWithEmailAndPassword(
  String email,
  String password,
  String type,
  String username,
  BuildContext context,
) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await addUser(currentUser.uid, type, username);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, 'Home', (route) => false);
    }
  } on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogWidget(
          titleText: 'Error al registrarse',
          contentText: 'El mail que ha introducido ya existe',
        ).buildAlertDialog(context);
      },
    );
  }
}



/* Metodo para añadir platos en el caso de que sea necessario
Future<void> addPlatos(Map<String, dynamic> productos) async {
  productos.forEach((key, value) async {
    await collectionProducts.add(value);
  });
}
*/
