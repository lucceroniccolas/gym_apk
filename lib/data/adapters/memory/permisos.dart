import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_permisos.dart';

class MemoriaPermisosImpl implements RepoPermisos {
  static final MemoriaPermisosImpl _intanciaPermiso =
      MemoriaPermisosImpl._privado();

  MemoriaPermisosImpl._privado();

  factory MemoriaPermisosImpl() {
    return (_intanciaPermiso);
  }

  final List<Permiso> _permisos = [];

  @override
  Future<void> borarPermiso(int idPermiso) async {
    _permisos.removeWhere((permiso) => permiso.idPermiso == idPermiso);
  }

  @override
  Future<void> crearPermiso(Permiso permiso) async {
    _permisos.add(permiso);
  }

  @override
  Future<void> modificarPermiso(
      int idPermiso, Permiso permisoModificado) async {
    if (permisoModificado.idPermiso <= 0) {
      throw Exception("id de permiso no válido");
    }
    final index = _permisos.indexWhere(
        (permiso) => permiso.idPermiso == permisoModificado.idPermiso);
    if (index == -1) {
      throw Exception(
          "Permiso con id ${permisoModificado.idPermiso} no encontrado");
    } else {
      _permisos[index] = permisoModificado;
    }
  }

  @override
  Future<Permiso?> obtenerPermisoPorId(int idPermiso) async {
    return (_permisos.firstWhere((permiso) => permiso.idPermiso == idPermiso));
  }

  @override
  Future<List<Permiso>> obtenerTodosLosPermisos() async {
    return (_permisos);
  }
}
