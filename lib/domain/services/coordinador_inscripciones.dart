//este es un servicio que encapsula toda toda la logica relacionada a inscribir
//y cancelar inscripciones coordinando entre los repositorios
// de clases, usuarios y inscripciones

import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class CoordinadorInscripciones {
  final RepoInscripcion _repoInscripcion;
  final RepoClases _repoClases;
  final RepoUsuario _repoUsuario;

  CoordinadorInscripciones(
      this._repoInscripcion, this._repoClases, this._repoUsuario);

  Future<void> inscribir(int idUsuario, int idClase) async {
    Usuario? usuario = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuario == null) {
      throw Exception("Usuario no encontrado");
    }

    _verificarUsuarioPago(usuario);

    Clase? clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) {
      throw Exception("Clase no encontrada");
    }

    final inscripciones = await _repoInscripcion.obtenerInscripciones();

    final existeInscripcion = inscripciones.any((inscripcion) =>
        inscripcion.idUsuario == idUsuario && inscripcion.idClase == idClase);

    if (existeInscripcion) {
      throw Exception("El usuario ya está inscrito en esta clase");
    }
    if (clase.cupos <= 0) {
      throw Exception("No hay cupos disponibles para esta clase");
    }
    Inscripcion nuevaInscripcion = Inscripcion(
        idInscripcion: 0, // El ID se asignará automáticamente en el repositorio
        idUsuario: idUsuario,
        idClase: idClase,
        fechaInscripcion: DateTime.now());
    // Aquí podrías agregar lógica adicional para verificar si el usuario cumple con los requisitos de la clase
    // y si la clase está activa, etc.
    // Agregar la inscripción al repositorio
    clase.cupos = clase.cupos - 1;
    await _repoInscripcion.agregarInscripcion(nuevaInscripcion);
    await _repoClases.actualizarClase(clase);
  }

  Future<void> cancelar(int idUsuario, int idClase) async {
    final clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) throw Exception("La clase no existe");

    await _repoInscripcion.eliminarInscripcion(idUsuario, idClase);

    clase.cupos += 1;
    await _repoClases.actualizarClase(clase);
  }

  Future<void> cancelarTodasLasInscripcionesDeUsuario(int idUsuario) async {
    final inscripciones = await _repoInscripcion.obtenerInscripciones();
    final inscripcionesDelUsuario =
        inscripciones.where((insc) => insc.idUsuario == idUsuario).toList();

    for (final insc in inscripcionesDelUsuario) {
      await cancelar(insc.idUsuario, insc.idClase);
    }
  }

  Future<List<Usuario>> obtenerUsuariosInscriptosDeClase(int idClase) async {
    final inscripciones = await _repoInscripcion.obtenerInscripciones();
    final idsUsuarios = inscripciones
        .where((i) => i.idClase == idClase)
        .map((i) => i.idUsuario)
        .toSet(); // evita duplicados

    final usuarios = <Usuario>[];

    for (final id in idsUsuarios) {
      final usuario = await _repoUsuario.obtenerUsuarioPorId(id);
      if (usuario != null) usuarios.add(usuario);
    }

    return usuarios;
  }

  Future<List<Clase>> obtenerClasesInscriptasDeUsuario(int idUsuario) async {
    final inscripciones = await _repoInscripcion.obtenerInscripciones();
    final idsClases = inscripciones
        .where((i) => i.idUsuario == idUsuario)
        .map((i) => i.idClase)
        .toSet();

    final clases = <Clase>[];

    for (final id in idsClases) {
      final clase = await _repoClases.obtenerClasePorId(id);
      if (clase != null) clases.add(clase);
    }

    return clases;
  }

  void _verificarUsuarioPago(Usuario usuario) {
    if (!usuario.pago) {
      throw Exception("El usuario no pagó la cuota del gimnasio");
    }
  }
}
