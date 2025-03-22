import 'dart:collection';

import 'package:gym_apk/domain/entities/rol.dart';
import 'package:gym_apk/domain/repository/repo_roles.dart';

class MemoriaRolImpl implements RepoRol {
  static final MemoriaRolImpl _intanciaRol = MemoriaRolImpl._privado();

  ///_intanciaRol es una instancia estática privada que se crea solo una vez.

  //Constructor privado
  MemoriaRolImpl._privado();

  // Factory para acceder a la instancia
  //Metodo para acceder a la instancia única
  factory MemoriaRolImpl() {
    return _intanciaRol;
  }

// La lista guarda todos los roles añadidos
  final List<Rol> _roles = [
    Rol(idRol: 1, nombreRol: "Profesor"),
    Rol(idRol: 2, nombreRol: "Alumno")
  ];

//DELETE ROL
  @override
  Future<void> borrarRol(int idRol) async {
    _roles.removeWhere((rol) => rol.idRol == idRol);
  }

// CREATE ROL
  @override
  Future<void> crearRol(Rol rol) async {
    _roles.add(rol);
  }

// MODIFY ROL
  @override
  Future<void> modificarRol(Rol rolModificado) async {
    final index = _roles.indexWhere((rol) => rol.idRol == rolModificado.idRol);
    if (index != -1) {
      _roles[index] = rolModificado;
    } else {
      throw Exception(
          "Usuario con id ${rolModificado.idRol} no encontrado"); //Lanza una excepción si el usuario no existe, lo que permite a la capa superior manejar este error adecuadamente.
    }
  }

  @override
  Future<Rol?> obtenerRolPorID(int idRol) async {
    return _roles.firstWhere((rol) => rol.idRol == idRol);
  }

  @override
  Future<List<Rol>> obtenerTodosLosRoles() async {
    return UnmodifiableListView(_roles);
  }
}
