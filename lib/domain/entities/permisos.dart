class Permiso {
  final int idPermiso;
  String descripcion;
  String nombrePermiso;

  Permiso(
      {required this.idPermiso,
      required this.descripcion,
      required this.nombrePermiso});

  Permiso copyWith({String? descripcion, String? nombrePermiso}) {
    return Permiso(
        idPermiso: idPermiso,
        descripcion: descripcion ?? this.descripcion,
        nombrePermiso: nombrePermiso ?? this.nombrePermiso);
  }
}
