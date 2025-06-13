import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';

class MemoriaInscripcionesImpl implements RepoInscripcion {
  final RepoClases _repoClases;
  final RepoUsuario _repoUsuario;

  MemoriaInscripcionesImpl(this._repoClases, this._repoUsuario);
  // inyectando los repos desde el contructor
  //podemos registrarlo con get_it y tener control total sobre las dependecias
  final List<Inscripcion> _inscripciones = [];
  int _contadorId = 1;

  @override
  Future<void> cancelarInscripcion(int idUsuario, int idClase) async {
    final clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) {
      throw Exception("Clase con id: $idClase  no encontrada");
    }
    _inscripciones.removeWhere((inscripcion) =>
        inscripcion.idUsuario == idUsuario && inscripcion.idClase == idClase);
  }

  @override
  Future<void> inscribirUsuarioEnClase(int idUsuario, int idClase) async {
//verificación de que existe el usuario
    final usuario = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuario == null) {
      throw Exception("Usuario con id $idUsuario no encontrado.");
    }
//Verificacion de pago de cuota
    if (!usuario.pago) {
      throw Exception("El usuario no pagó su couta de gimansio");
    }
// verificación de que existe la clase
    final clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) {
      throw Exception("Clase con id $idClase no encontrado.");
    }
// verificación de que el usuario no esté inscripto a una clase
    bool yaInscripto = _inscripciones.any((inscripcion) =>
        inscripcion.idUsuario == idUsuario && inscripcion.idClase == idClase);
    if (yaInscripto) {
      throw Exception("El usuario ya está inscripto en esta clase.");
    }
//Verificación de que haya cupos disponibles
    final inscripcionesEnClase = _inscripciones
        .where((inscripcion) => inscripcion.idClase == idClase)
        .length;
    if (clase.cupos != null && inscripcionesEnClase >= clase.cupos!) {
      throw Exception("La clase ya alcanzó su cupo maximo");
    }

// inscribimos al usuario a su clase

    final nuevaInscripcion = Inscripcion(
        idInscripcion: _contadorId++,
        idUsuario: idUsuario,
        fechaInscripcion: DateTime.now(),
        idClase: idClase);
    _inscripciones.add(nuevaInscripcion);
    // restamos un cupo y actualizamos la clase
    clase.cupos = clase.cupos! - 1;
    await _repoClases.actualizarClase(clase);
  }

  @override
  Future<List<Clase>> obtenerClasesInscriptasDeUsuario(int idUsuario) async {
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
  Future<List<Usuario>> obtenerUsuariosInscriptosDeClase(int idClase) async {
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

  @override
  Future<List<Inscripcion>> obtenerInscripciones() async {
    return _inscripciones;
  }
}
