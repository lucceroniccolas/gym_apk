class InscripcionDetallada {
  final int idInscripcion;
  final int idUsuario;
  final int idClase;
  final String nombreUsuario;
  final String nombreClase;
  final DateTime fechaInscripcion;
  final bool pago;
  InscripcionDetallada({
    required this.idInscripcion,
    required this.idUsuario,
    required this.idClase,
    required this.nombreUsuario,
    required this.nombreClase,
    required this.fechaInscripcion,
    required this.pago,
  });
}
//DTO (data transfer objects) - Modelo de vista - Modelos de intercambio

//Acá van todas las clases que no son parte del dominio del negocio, 
//pero que la UI necesita para mostrar información de forma más prática


// esto sirve para la UI no para la logica del negocio
//se crea porque necesitamos info combinada, simplificada 