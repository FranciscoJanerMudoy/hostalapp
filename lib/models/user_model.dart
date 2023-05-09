class Usuario {
  String? uid;
  String? tipo;

  Usuario({this.uid, this.tipo});

  static Usuario fromMap(Map<String, dynamic> json) =>
      Usuario(uid: json["uid"], tipo: json["tipo"]);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"uid": uid, "tipo": tipo};
    return map;
  }
}
