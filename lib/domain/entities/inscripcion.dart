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
}
