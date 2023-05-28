class Producto {
  int? id;
  String? nombre;
  String? descripcion;
  String? tipo;
  double? precio;
  int? cantidad;

  Producto(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.tipo,
      required this.precio,
      required this.cantidad});

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
      id: json["id"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      tipo: json["tipo"],
      precio: json["precio"]?.toDouble(),
      cantidad: json["cantidad"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "tipo": tipo,
        "precio": precio,
        "cantidad": cantidad
      };
}
