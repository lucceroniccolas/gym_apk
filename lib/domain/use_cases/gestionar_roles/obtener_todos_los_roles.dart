import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/repository/repo_roles.dart';

class ObtenerTodosLosRolesCDU {
  final RepoRol repoRol;
  ObtenerTodosLosRolesCDU(this.repoRol);

  Future<List<Rol>> call() async {
    return await repoRol.obtenerTodosLosRoles();
  }
}
