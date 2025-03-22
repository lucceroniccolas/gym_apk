import 'package:gym_apk/domain/repository/repo_usuario.dart';

class EliminarUsuarioCDU {
  final RepoUsuario usuarioRepo;
  EliminarUsuarioCDU(this.usuarioRepo);

  Future<bool> execute(int idUsuario) async {
    if (idUsuario == 0) {
      throw Exception("El ID del usuario no es válido");
    }

    //llamada al repositorio
    try {
      await usuarioRepo.borrarUsuario(idUsuario);
      return true;
    } catch (e) {
      return false;
    }
  }
}
