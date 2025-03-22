import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_permisos.dart';

class CrearPermisosCDU {
  final RepoPermisos permisoRepo;
  CrearPermisosCDU(this.permisoRepo);

  Future<bool> execute(Permiso permiso) async {
    if (permiso.nombrePermiso.isEmpty) {
      throw Exception("El nombre del permiso no puede estar vacío");
    }
    if (permiso.descripcion.isEmpty) {
      throw Exception("La descripcion del permiso no puede estar vacío");
    }
    try {
      await permisoRepo.crearPermiso(permiso);
      return true;
    } catch (e) {
      return false;
    }
  }
}
