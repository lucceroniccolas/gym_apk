import 'package:gym_apk/domain/entities/inscripcion.dart';

abstract class RepoInscripcion {
  Future<void> agregarInscripcion(Inscripcion inscripcion);
  Future<void> eliminarInscripcion(int idUsuario, int idClase);

  Future<List<Inscripcion>> obtenerInscripciones();
}
