import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/repository/repo_roles.dart';

class CrearRolesCDU {
  final RepoRol rolRepo;
  CrearRolesCDU(this.rolRepo);

  Future<bool> execute(Rol rol) async {
    if (rol.nombreRol.isEmpty) {
      throw Exception("El nombre del rol no puede estar vacío");
    }

    try {
      await rolRepo.crearRol(rol);
      return true;
    } catch (e) {
      return false;
    }
  }
}
