class Clase {
  int idClase;
  String nombreClase;
  String descripcion;
  int cupos;
  DateTime fecha;
  int profesorId;
  List<int> inscriptos;

  Clase(
      {required this.idClase,
      required this.nombreClase,
      required this.descripcion,
      required this.cupos,
      required this.fecha,
      required this.profesorId,
      required this.inscriptos});
}
