import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';

abstract class RepoInscripcion {
  Future<void> agregarInscripcion(Inscripcion inscripcion);
  Future<void> eliminarInscripcion(int idUsuario, int idClase);
  Future<List<Usuario>> obtenerUsuariosInscriptosDeClase(int idClase);
  Future<List<Clase>> obtenerClasesInscriptasDeUsuario(int idUsuario);
  Future<List<Inscripcion>> obtenerInscripciones();

  //logica transversal
  Future<void> eliminarInscripcionesDeUsuario(int idUsuario);
}
