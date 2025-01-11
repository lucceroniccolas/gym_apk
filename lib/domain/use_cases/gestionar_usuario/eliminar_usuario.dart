import 'package:gym_apk/domain/repository/repo_usuario.dart';

class EliminarUsuarioCDU {
  final RepoUsuario usuarioRepo;
  EliminarUsuarioCDU(this.usuarioRepo);

  Future<void> execute(int idUsuario) async {
    if (idUsuario == 0) {
      throw Exception("El ID del usuario no es válido");
    }

    //llamada al repositorio
    await usuarioRepo.borrarUsuario(idUsuario);
  }
}
