import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/data/adapters/memory/clases.dart';
import 'package:gym_apk/data/adapters/memory/usuarios.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class MemoriaInscripcionesImpl implements RepoInscripcion {
  static final MemoriaInscripcionesImpl _instanciaInscripciones =
      MemoriaInscripcionesImpl._privado();

  MemoriaInscripcionesImpl._privado();

  factory MemoriaInscripcionesImpl() {
    return _instanciaInscripciones;
  }

  final List<Inscripcion> _inscripciones = [];
  int _contadorId = 1;
  final RepoClases _repoClases = MemoriaClasesImpl();
  final RepoUsuario _repoUsuario = MemoriaUsuarioImpl();

  @override
  Future<void> cancelarInscripcion(int idUsuario, int idClase) async {
    _inscripciones.removeWhere((inscripcion) =>
        inscripcion.idUsuario == idUsuario && inscripcion.idClase == idClase);
  }

  @override
  Future<void> inscribirUsuarioEnClase(int idUsuario, int idClase) async {
//verificacion de que existe el usuario
    final usuario = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuario == null) {
      throw Exception("Usuario con id $idUsuario no encontrado.");
    }
// verifacion de que existe la clase
    final clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) {
      throw Exception("Clase con id $idClase no encontrado.");
    }
// verificando que el usuario no esté inscripto a una clase
    bool yaInscripto = _inscripciones.any((inscripcion) =>
        inscripcion.idUsuario == idUsuario && inscripcion.idClase == idClase);
    if (yaInscripto) {
      throw Exception("El usuario ya está inscripto en esta clase.");
    }

// inscribimos al usuario a su clase

    final nuevaInscripcion = Inscripcion(
        idInscripcion: _contadorId++,
        idUsuario: idUsuario,
        fechaInscripcion: DateTime.now(),
        idClase: idClase);
    _inscripciones.add(nuevaInscripcion);
  }

  @override
  Future<List<Clase>> obtenerClasesInscriptas(int idUsuario) async {
    List<int> idsClases = _inscripciones
        .where((inscripcion) => inscripcion.idUsuario == idUsuario)
        .map((inscripcion) => inscripcion.idClase)
        .toList();

    List<Clase> clases = [];
    for (int id in idsClases) {
      Clase? clase = await _repoClases.obtenerClasePorId(id);
      if (clase != null) {
        clases.add(clase);
      }
    }
    return clases;
  }

  @override
  Future<List<Usuario>> obtenerUsuarioInscriptos(int idClase) async {
    List<int> idsUsuarios = _inscripciones
        .where((inscripcion) => inscripcion.idClase == idClase)
        .map((inscripcion) => inscripcion.idUsuario)
        .toList();

    List<Usuario> usuarios = [];
    for (int id in idsUsuarios) {
      Usuario? usuario = await _repoUsuario.obtenerUsuarioPorId(id);
      if (usuario != null) {
        usuarios.add(usuario);
      }
    }
    return usuarios;
  }
}
