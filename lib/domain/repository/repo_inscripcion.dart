import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';

abstract class RepoInscripcion {
  Future<void> inscribirUsuarioEnClase(int idUsuario, int idClase);
  Future<void> cancelarInscripcion(int idUsuario, int idClase);
  Future<List<Usuario>> obtenerUsuarioInscriptos(int idClase);
  Future<List<Clase>> obtenerClasesInscriptas(int idUsuario);
}
