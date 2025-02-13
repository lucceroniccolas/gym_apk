import 'package:gym_apk/domain/repository/repo_rolpermiso.dart';
import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/entities/rol_permiso.dart';
import 'package:gym_apk/domain/entities/permisos.dart';

class MemoriaRolPermisoImpl implements RepoRolPermiso {
  //instancia es una instancia estatica única que se crea una sola vez.
  static final MemoriaRolPermisoImpl _intanciaRolPermiso =
      MemoriaRolPermisoImpl._privado();

  //Constructor privado.
  MemoriaRolPermisoImpl._privado();
  factory MemoriaRolPermisoImpl() {
    return _intanciaRolPermiso;
  }

  final List<RolPermiso> _rolPermiso = [];

  @override
  Future<void> asignarPermisosAUnRol(int idRol, int idPermiso) async {
    if (_rolPermiso.any(
        (rp) => rp.rol.idRol == idRol && rp.permiso.idPermiso == idPermiso)) {
      throw Exception("El permiso ya está asignado a este rol.");
    }
    _rolPermiso.add(RolPermiso(
        rol: Rol(idRol: idRol, nombreRol: "nombre ROl"),
        permiso: Permiso(
            idPermiso: idPermiso,
            descripcion: "descripcion",
            nombrePermiso: "nombrePermiso")));
  }

  @override
  Future<void> eliminarPermisosAUnRol(int idRol, int idPermiso) async {
    _rolPermiso.removeWhere(
        (rp) => rp.rol.idRol == idRol && rp.permiso.idPermiso == idPermiso);
  }

  @override
  Future<List<Permiso>> obtenerPermisosPorIdRol(int idRol) async {
    return _rolPermiso
        .where((rp) =>
            rp.rol.idRol ==
            idRol) //filtramos  la lista y deja solo los elementos donde el rol tiene el id indicado.
        .map((rp) => rp
            .permiso) //convierte los objetos filtrados en una lista de permisos (solo extrae el permiso).
        .toList(); //devuelve el resultado como una lista de permisos
  }

  @override
  Future<List<Rol>> obtenerRolesPorIdPermisos(int idPermiso) async {
    return _rolPermiso
        .where((rp) =>
            rp.permiso.idPermiso ==
            idPermiso) // filtramos la lista y deja solo los elementos donde permiso tiene el id indicado.
        .map((rp) => rp.rol) //extrae los roles asociados a ese permiso
        .toList(); //devuelve una lista de roles
  }
}
