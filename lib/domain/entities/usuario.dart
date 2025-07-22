class Usuario {
  int idUsuario;
  String nombre;
  String apellido;
  String? correo;
  bool pago;
  DateTime? fechaDePago;
  Usuario(
      {required this.idUsuario,
      required this.nombre,
      required this.correo,
      required this.apellido,
      required this.pago,
      required this.fechaDePago});
  Usuario copyWith({
    String? nombre,
    String? apellido,
    String? correo,
  }) {
    return Usuario(
        idUsuario: idUsuario,
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        correo: correo ?? this.correo,
        pago: pago,
        fechaDePago: fechaDePago ?? this.fechaDePago);
  }
}
