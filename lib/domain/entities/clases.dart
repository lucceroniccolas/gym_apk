class Clase {
  int idClase;
  String nombreClase;
  String descripcion;
  int cupos;
  DateTime? horario;
  int idProfesor;
  List<int> inscriptos;

  Clase(
      {required this.idClase,
      required this.nombreClase,
      required this.descripcion,
      required this.cupos,
      required this.horario,
      required this.idProfesor,
      required this.inscriptos});

  Clase copyWith({
    String? nombreClase,
    String? descripcion,
    int? cupos,
    DateTime? horario,
    int? idProfesor,
    List<int>? inscriptos,
  }) {
    return Clase(
        idClase: idClase,
        nombreClase: nombreClase ?? this.nombreClase,
        descripcion: descripcion ?? this.descripcion,
        cupos: cupos ?? this.cupos,
        horario: horario ?? this.horario,
        idProfesor: idProfesor ?? this.idProfesor,
        inscriptos: inscriptos ?? this.inscriptos);
  }
}
