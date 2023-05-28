import 'package:hostalapp/models/models.dart';

class Comanda {
  String? id;
  List<Producto>? productos;
  double? precio;
  String? estado;
  int? mesa;

  Comanda(
      {required this.id,
      required this.productos,
      required this.precio,
      required this.estado,
      required this.mesa});

  factory Comanda.fromMap(Map<String, dynamic> json) => Comanda(
      id: json["id"],
      productos: List<Producto>.from(
          json["productos"].map((x) => Producto.fromMap(x))),
      precio: json["precio"]?.toDouble(),
      estado: json["estado"],
      mesa: json["mesa"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "productos": List<dynamic>.from(productos!.map((x) => x.toMap())),
        "precio": precio,
        "estado": estado,
        "mesa": mesa
      };
}
