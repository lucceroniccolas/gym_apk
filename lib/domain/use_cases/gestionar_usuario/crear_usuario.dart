import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class CrearusuarioCDU {
  final RepoUsuario usuarioRepo;
  CrearusuarioCDU(this.usuarioRepo);

  Future<bool> execute(Usuario usuario) async {
    //validaciones
    if (usuario.nombre.isEmpty || usuario.apellido.isEmpty) {
      throw Exception("El nombre y apellido no pueden estar vacíos.");
    }
    //llamada al repositorio
    try {
      await usuarioRepo.crearUsuario(usuario);
      return true;
    } catch (e) {
      return false;
    }
  }
}
