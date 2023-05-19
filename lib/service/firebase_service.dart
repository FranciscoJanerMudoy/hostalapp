import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostalapp/models/models.dart';

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

Future<void> addOrder(List<Producto> productos, double precio) async {
  Comanda comanda = Comanda(productos: productos, precio: precio);
  collectionOrders.add(comanda.toMap());
}

/* Metodo para añadir platos en el caso de que sea necessario
Future<void> addPlatos(Map<String, dynamic> productos) async {
  productos.forEach((key, value) async {
    await collectionProducts.add(value);
  });
}
*/
