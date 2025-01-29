import 'package:gym_apk/domain/entities/permisos.dart';
import 'package:gym_apk/domain/repository/repo_permisos.dart';

class MemoriaPermisosImpl implements RepoPermisos {
  static final MemoriaPermisosImpl _instancia = MemoriaPermisosImpl._privado();

  MemoriaPermisosImpl._privado();

  factory MemoriaPermisosImpl() {
    return (_instancia);
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
  Future<void> modificarPermiso(Permiso permisoModificado) async {
    final index = _permisos.indexWhere(
        (permiso) => permiso.idPermiso == permisoModificado.idPermiso);
    if (index != -1) {
      _permisos[index] = permisoModificado;
    } else {
      throw Exception(
          "Usuario con id ${permisoModificado.idPermiso} no encontrado");
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
