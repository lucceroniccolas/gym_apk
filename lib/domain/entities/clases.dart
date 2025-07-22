class Clase {
  int idClase;
  String nombreClase;
  String? descripcion;
  int cupos;
  DateTime? horario;
  int? idProfesor;

  /// REVISAR SI ES UNA LISTA DE ENTEROS O LISTA DE ALUMNOS

  Clase({
    required this.idClase,
    required String nombreClase,
    required this.descripcion,
    required this.cupos,
    required this.horario,
    required this.idProfesor,
  }) 
  }

  Clase copyWith({
    required String nombreClase,
    String? descripcion,
    DateTime? horario,
    int? idProfesor,
    List<int>? inscriptos,
    required int cupos,
  }) {
    final nuevoNombre = nombreClase.trim();
    if (nuevoNombre.isEmpty) {
      throw ArgumentError("El nombre de la clase no puede estar vacío");
    }
    return Clase(
      idClase: idClase,
      nombreClase: nuevoNombre,
      descripcion: descripcion ?? this.descripcion,
      cupos: cupos,
      horario: horario ?? this.horario,
      idProfesor: idProfesor ?? this.idProfesor,
    );
  }


    //asegurando que una instancia de Clase no pueda existir en un estado inválido,
    //lo cual es responsabilidad directa del modelo de dominio.
  

