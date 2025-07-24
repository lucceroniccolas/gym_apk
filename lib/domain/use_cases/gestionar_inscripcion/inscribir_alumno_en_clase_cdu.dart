import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/repository/repo_usuario.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';

class InscribirAlumnoEnClaseCDU {
  final RepoInscripcion _repoInscripcion;
  final RepoClases _repoClases;
  final RepoUsuario _repoUsuario;
  InscribirAlumnoEnClaseCDU(
      this._repoInscripcion, this._repoClases, this._repoUsuario);

  Future<void> execute(int idUsuario, int idClase) async {
    final usuario = await _verificarUsuarioExiste(idUsuario);

    final clase = await _verificarClaseExiste(idClase);

    _verificarUsuarioPago(usuario);
    await _verificarUsuarioNoInscripto(idUsuario, idClase);
    _verificarCuposDisponibles(clase);
    final inscripcion = Inscripcion(
        idInscripcion: DateTime.now().millisecondsSinceEpoch,
        idUsuario: idUsuario,
        fechaInscripcion: DateTime.now(),
        idClase: idClase);

    await _repoInscripcion.agregarInscripcion(inscripcion);

    clase.cupos = (clase.cupos) - 1;

    await _repoClases.actualizarClase(clase);
  }

  Future<Usuario> _verificarUsuarioExiste(int idUsuario) async {
    final usuario = await _repoUsuario.obtenerUsuarioPorId(idUsuario);
    if (usuario == null) {
      throw Exception("El usuario no existe");
    }
    return usuario;
  }

  Future<Clase> _verificarClaseExiste(int idClase) async {
    final clase = await _repoClases.obtenerClasePorId(idClase);
    if (clase == null) {
      throw Exception("La clase no existe");
    }
    return clase;
  }

  void _verificarUsuarioPago(Usuario usuario) {
    if (!usuario.pago) {
      throw Exception("El usuario no pagó la cuota del gimnasio");
    }
  }

  Future<void> _verificarUsuarioNoInscripto(int idUsuario, int idClase) async {
    final clasesInscriptas =
        await _repoInscripcion.obtenerClasesInscriptasDeUsuario(idUsuario);

    final yaInscripto = clasesInscriptas.any((c) => c.idClase == idClase);
    if (yaInscripto) {
      throw Exception("El usuario ya está inscripto en clase");
    }
  }

  void _verificarCuposDisponibles(Clase clase) {
    if (clase.cupos <= 0) {
      throw Exception("No hay cupos disponibles para esta clase");
    }
  }
}
