class Product {
  String? id;
  int? precio;
  String? nombre;
  String? descripcion;

  Product({this.id, this.precio, this.nombre, this.descripcion});

  static Product fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        precio: json["precio"],
        nombre: json["nombre"],
        descripcion: json["descripción"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "precio": precio,
      "nombre": nombre,
      "descripción": descripcion
    };
    return map;
  }
}
