class Clase {
  int idClase;
  String nombreClase;
  String? descripcion;
  int? cupos;
  DateTime? horario;
  int? idProfesor;
  List<int>? inscriptos;

  /// REVISAR SI ES UNA LISTA DE ENTEROS O LISTA DE ALUMNOS

  Clase(
      {required this.idClase,
      required String nombreClase,
      required this.descripcion,
      required this.cupos,
      required this.horario,
      required this.idProfesor,
      required this.inscriptos})
      : nombreClase = nombreClase.trim() {
    if (this.nombreClase.isEmpty) {
      throw Exception("El nombre de la clase no puede estar vacío");
    }
  }

  Clase copyWith({
    required String nombreClase,
    String? descripcion,
    int? cupos,
    DateTime? horario,
    int? idProfesor,
    List<int>? inscriptos,
  }) {
    final nuevoNombre = nombreClase.trim();
    if (nuevoNombre.isEmpty) {
      throw ArgumentError("El nombre de la clase no puede estar vacío");
    }
    return Clase(
        idClase: idClase,
        nombreClase: nuevoNombre,
        descripcion: descripcion ?? this.descripcion,
        cupos: cupos ?? this.cupos,
        horario: horario ?? this.horario,
        idProfesor: idProfesor ?? this.idProfesor,
        inscriptos: inscriptos ?? this.inscriptos);
  }
}
