import 'package:flutter/material.dart';

import 'package:gym_apk/domain/use_cases/gestionar_permisos/borar_permiso.dart';
import 'package:gym_apk/domain/use_cases/gestionar_permisos/crear_permiso.dart';
import 'package:gym_apk/domain/use_cases/gestionar_permisos/modificar_permiso.dart';
import 'package:gym_apk/domain/use_cases/gestionar_permisos/obtener_permisos_por_id.dart';
import 'package:gym_apk/domain/use_cases/gestionar_permisos/obtener_todos_los_permisos.dart';
import 'package:gym_apk/domain/entities/permisos.dart';

class PermisosProvider extends ChangeNotifier {
  final CrearPermisosCDU _crearPermisos;
  final BorrarPermisoCDU _borrarPermiso;
  final ModificarPermisoCDU _modificarPermiso;
  final ObtenerPermisoPorIdCDU _obtenerPermisoPorId;
  final ObtenerTodosLosPermisosCDU _obtenerTodosLosPermisos;

  PermisosProvider(
      this._crearPermisos,
      this._borrarPermiso,
      this._modificarPermiso,
      this._obtenerPermisoPorId,
      this._obtenerTodosLosPermisos);
  List<Permiso> _permisos = [];
  List<Permiso> get permisos => _permisos;

  Permiso? _permisoSeleccionado;
  Permiso? get permisoSeleccionado => _permisoSeleccionado;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> crearPermiso(Permiso nuevoPermiso) async {
    _isLoading = true;
    notifyListeners();
    bool resultado = await _crearPermisos.execute(nuevoPermiso);
    if (resultado) {
      _permisos.add(nuevoPermiso);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> borrarPermiso(int idPermiso) async {
    _isLoading = true;
    notifyListeners();
    bool resultado = await _borrarPermiso.execute(idPermiso);
    if (resultado) {
      _permisos.removeWhere((p) => p.idPermiso == idPermiso);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> modificarPermiso(int idPermiso, Permiso permisoModicado) async {
    try {
      _isLoading = true;
      notifyListeners();
      bool resultado =
          await _modificarPermiso.execute(idPermiso, permisoModicado);
      if (resultado) {
        _permisos = await _obtenerTodosLosPermisos.execute();
        notifyListeners();
      }
      return resultado;
    } catch (e) {
      print("error al modificar clase $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> obtenerPermisos() async {
    _isLoading = true;
    notifyListeners();
    try {
      _permisos = await _obtenerTodosLosPermisos.execute();
    } catch (e) {
      _permisos = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> obtenerPermisosPorId(idPermiso) async {
    _isLoading = true;
    notifyListeners();
    try {
      _permisoSeleccionado = await _obtenerPermisoPorId.execute(idPermiso);
    } catch (e) {
      _permisoSeleccionado = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
