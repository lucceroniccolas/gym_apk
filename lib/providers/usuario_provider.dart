import 'package:gym_apk/domain/use_cases/gestionar_usuario/crear_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/eliminar_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/modificar_usuario.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_todos_los_usuarios.dart';
import 'package:gym_apk/domain/use_cases/gestionar_usuario/obtener_usuario_por_id.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  final CrearusuarioCDU _crearusuario;
  final EliminarUsuarioCDU _eliminarUsuario;
  final ModificarUsuarioCDU _modificarUsuario;
  final ObtenerTodosLosUsuariosCDU _obtenerTodosLosUsuarios;
  final ObtenerUsuarioPorIdCDU _obtenerUsuarioPorid;

  UsuarioProvider(
      this._crearusuario,
      this._eliminarUsuario,
      this._modificarUsuario,
      this._obtenerTodosLosUsuarios,
      this._obtenerUsuarioPorid);

  List<Usuario> _usuarios = [];
  List<Usuario> get usuarios => _usuarios;

  Usuario? _usuarioSeleccionado;
  Usuario? get usuarioSeleccionado => _usuarioSeleccionado;

  set usuarioSeleccionado(Usuario? usuario) {
    _usuarioSeleccionado = usuario;
    notifyListeners(); //permitimos acceso a modificacion de variable
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> cargarUsuarios() async {
    _isLoading = true;
    notifyListeners();
    _usuarios = await _obtenerTodosLosUsuarios.execute();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> crearUsuario(Usuario nuevoUsuario) async {
    _isLoading = true;
    notifyListeners();
    bool resultado = await _crearusuario.execute(nuevoUsuario);
    if (resultado) {
      await cargarUsuarios();
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> eliminarUsuario(int idUsuario) async {
    _isLoading = true;
    notifyListeners();
    bool resultado = await _eliminarUsuario.execute(idUsuario);
    if (resultado) {
      await cargarUsuarios();
    }
    _isLoading = false;
    notifyListeners();
    return resultado;
  }

  Future<bool> modificarUsuario(Usuario usuarioModificado) async {
    try {
      _isLoading = true;
      notifyListeners();
      bool resultado = await _modificarUsuario.execute(usuarioModificado);
      if (resultado) {
        _usuarios = await _obtenerTodosLosUsuarios.execute();
      }
      return resultado;
    } catch (e) {
      print("Error al modificar usuario $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners(); // Notificar que la operación ha terminado
    }
  }

  Future<void> buscarUsuarioPorID(int idUsuario) async {
    try {
      _isLoading = true;
      notifyListeners();
      _usuarioSeleccionado = await _obtenerUsuarioPorid.execute(idUsuario);
      notifyListeners();
    } catch (e) {
      print("error al obtener usuario: $e");
      _usuarioSeleccionado = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
