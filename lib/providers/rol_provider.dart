import 'package:flutter/material.dart';
import 'package:gym_apk/domain/use_cases/gestionar_roles/crear_roles.dart';
import 'package:gym_apk/domain/use_cases/gestionar_roles/borrar_rol.dart';
import 'package:gym_apk/domain/use_cases/gestionar_roles/modificar_rol.dart';
import 'package:gym_apk/domain/use_cases/gestionar_roles/obtener_todos_los_roles.dart';
import 'package:gym_apk/domain/use_cases/gestionar_roles/obtener_rol_por_id.dart';
import 'package:gym_apk/domain/entities/rol.dart';

class RolProvider extends ChangeNotifier {
  final CrearRolesCDU _crearRol;
  final EliminarRolCDU _eliminarRol;
  final ModificarRolCDU _modificarRol;
  final ObtenerTodosLosRolesCDU _obtenerTodosLosRoles;
  final ObtenerRolPorIdCDU _obtenerRolPorId;

  RolProvider(
    this._crearRol,
    this._eliminarRol,
    this._modificarRol,
    this._obtenerTodosLosRoles,
    this._obtenerRolPorId,
  );

  List<Rol> _roles = [];
  List<Rol> get roles => _roles;

  Rol? _rolSeleccionado;
  Rol? get rolSeleccionado => _rolSeleccionado;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> crearRol(Rol nuevoRol) async {
    _isLoading = true;
    notifyListeners();
    final resultado = await _crearRol.execute(nuevoRol);
    if (resultado) {
      _roles.add(nuevoRol);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> eliminarRol(int idRol) async {
    _isLoading = true;
    notifyListeners();
    final resultado = await _eliminarRol.execute(idRol);
    if (resultado) {
      _roles.removeWhere((r) => r.idRol == idRol);
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> modificarRol(int idRol, Rol rolModificado) async {
    try {
      _isLoading = true;
      notifyListeners();
      final resultado = await _modificarRol.execute(idRol, rolModificado);
      if (resultado) {
        _roles = await _obtenerTodosLosRoles.execute();
        notifyListeners();
      }
      return resultado;
    } catch (e) {
      print("Error al modificar rol: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cargarRoles() async {
    _isLoading = true;
    notifyListeners();
    try {
      _roles = await _obtenerTodosLosRoles.execute();
    } catch (e) {
      _roles = [];
      print("Error al cargar roles: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> buscarRolPorID(int idRol) async {
    _isLoading = true;
    notifyListeners();
    try {
      _rolSeleccionado = await _obtenerRolPorId.execute(idRol);
    } catch (e) {
      print("Error al obtener rol por ID: $e");
      _rolSeleccionado = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
