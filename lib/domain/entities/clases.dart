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
}
