class Clase {
  int idClase;
  String nombreClase;
  String? descripcion;
  int cupos;
  DateTime? horario;
  Clase({
    required this.idClase,
    required this.nombreClase,
    required this.descripcion,
    required this.cupos,
    required this.horario,
  });
  Clase copyWith({
    required String nombreClase,
    String? descripcion,
    DateTime? horario,
    int? idProfesor,
    required int cupos,
  }) {
    return Clase(
      idClase: idClase,
      nombreClase: this.nombreClase,
      descripcion: descripcion ?? this.descripcion,
      cupos: this.cupos,
      horario: horario ?? this.horario,
    );
  }
}

    //asegurando que una instancia de Clase no pueda existir en un estado inválido,
    //lo cual es responsabilidad directa del modelo de dominio.
  

