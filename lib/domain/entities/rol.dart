class Rol {
  final int idRol;
  String nombreRol;

  Rol({required this.idRol, required this.nombreRol});

  Rol copyWith({
    String? nombreRol,
  }) {
    return Rol(idRol: idRol, nombreRol: nombreRol ?? this.nombreRol);
  }
}
