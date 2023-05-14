class Usuario {
  String? uid;
  String? tipo;
  String? nombre;

  Usuario({this.uid, this.tipo, this.nombre});

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        uid: json["uid"],
        tipo: json["tipo"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "uid": uid,
      "tipo": tipo,
      "nombre": nombre,
    };
    return map;
  }
}
