class Product {
  int? id;
  String? nombre;
  String? descripcion;
  String? tipo;
  double? precio;

  Product({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.tipo,
    required this.precio,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        tipo: json["tipo"],
        precio: json["precio"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "tipo": tipo,
        "precio": precio,
      };
}
