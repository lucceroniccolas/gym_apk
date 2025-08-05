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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Clase &&
          runtimeType == other.runtimeType &&
          idClase == other.idClase;

  @override
  int get hashCode => idClase.hashCode;

  //Con esto, Flutter sabrá que si dos objetos Clase tienen el mismo idClase, se consideran iguales, aunque sean instancias distintas (por ejemplo, luego de recargar la lista desde Hive).

  //usamos esto porque
  //Porque el DropdownButton compara con == los elementos de la lista y el valor actual. Si vos actualizás la lista (obtenerClases()), los objetos son nuevos, por lo tanto Flutter no sabe que tu valor value sigue siendo válido a menos que sobrescribas == o le reemplaces el objeto.

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
  

