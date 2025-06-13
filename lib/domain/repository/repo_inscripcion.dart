import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';

abstract class RepoInscripcion {
  Future<void> inscribirUsuarioEnClase(int idUsuario, int idClase);
  Future<void> cancelarInscripcion(int idUsuario, int idClase);
  Future<List<Usuario>> obtenerUsuariosInscriptosDeClase(int idClase);
  Future<List<Clase>> obtenerClasesInscriptasDeUsuario(int idUsuario);
  Future<List<Inscripcion>> obtenerInscripciones();
}
