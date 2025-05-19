import 'package:flutter/material.dart';
import 'package:gym_apk/domain/use_cases/gestionar_rolPermiso/asignar_permiso_a_rol.dart';
import 'package:gym_apk/domain/use_cases/gestionar_rolPermiso/eliminar_permiso_de_rol.dart';
import 'package:gym_apk/domain/use_cases/gestionar_rolPermiso/obtener_permisos_por_idrol.dart';
import 'package:gym_apk/domain/use_cases/gestionar_rolPermiso/obtener_roles_por_idpermiso.dart';
import 'package:gym_apk/domain/entities/rol_permiso.dart';

class RolPermisoProvider extends ChangeNotifier {
  final AsignarPermisoARolCDU _asignarPermisoARol;
  final EliminarPermisoDeRolCDU _quitarPermisoDeRol;
  final ObtenerPermisosPorIdrolCDU _obtenerRoles;
  final ObtenerRolesPorIdpermisoCDU _obtenerPermisos;

  RolPermisoProvider(this._asignarPermisoARol, this._quitarPermisoDeRol,
      this._obtenerRoles, this._obtenerPermisos);

  List<RolPermiso> _rolesPermisos = [];
  List<RolPermiso> get rolesPermisos => _rolesPermisos;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> cargarRolesPermisos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _rolesPermisos = await _obtenerRoles.execute();
    } catch (e) {
      print("Error al cargar relaciones rol-permiso: $e");
      _rolesPermisos = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> asignarPermisoARol(RolPermiso nuevoRolPermiso) async {
    _isLoading = true;
    notifyListeners();
    final resultado = await _asignarPermisoARol.execute(nuevoRolPermiso);
    if (resultado) {
      _rolesPermisos.add(nuevoRolPermiso);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> quitarPermisoDeRol(int idRol, int idPermiso) async {
    _isLoading = true;
    notifyListeners();
    final resultado = await _quitarPermisoDeRol.execute(idRol, idPermiso);
    if (resultado) {
      _rolesPermisos
          .removeWhere((rp) => rp.idRol == idRol && rp.idPermiso == idPermiso);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }
}
