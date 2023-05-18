import 'package:hostalapp/models/models.dart';

class Comanda {
  String? id;
  List<Producto>? productos;
  double? precio;

  Comanda({this.id, this.productos, this.precio});

  factory Comanda.fromMap(Map<String, dynamic> json) => Comanda(
        id: json["id"],
        productos: List<Producto>.from(
            json["productos"].map((x) => Producto.fromMap(x))),
        precio: json["precio"]?.toDouble(),
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "productos": List<dynamic>.from(productos!.map((x) => x.toMap())),
      "precio": precio,
    };
    return map;
  }
}
