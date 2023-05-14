import 'package:hostalapp/models/models.dart';

class Comanda {
  String? id;
  List<Producto>? productos;
  double? precio;

  Comanda({this.id, this.productos, this.precio});

  factory Comanda.fromMap(Map<String, dynamic> json) => Comanda(
        id: json["id"],
        productos: json["productos"],
        precio: json["precip"]?.toDouble(),
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "productos": productos,
      "precio": precio,
    };
    return map;
  }
}
