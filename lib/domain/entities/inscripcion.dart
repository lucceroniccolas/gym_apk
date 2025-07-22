class Inscripcion {
  final int idInscripcion;
  final int idUsuario;
  late final int idClase;
  final DateTime fechaInscripcion;
  Inscripcion(
      {required this.idInscripcion,
      required this.idUsuario,
      required this.fechaInscripcion,
      required this.idClase});

  Inscripcion copyWith({
    int? idUsuario,
    int? idClase,
    int? idInscripcion,
    DateTime? fechaInscripcion,
  }) {
    return Inscripcion(
        idInscripcion: idInscripcion ?? this.idInscripcion,
        idUsuario: idUsuario ?? this.idUsuario,
        fechaInscripcion: fechaInscripcion ?? this.fechaInscripcion,
        idClase: idClase ?? this.idClase);
  }
}
