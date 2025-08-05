import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';

class MemoriaInscripcionesImpl implements RepoInscripcion {
  MemoriaInscripcionesImpl();
  // inyectando los repos desde el contructor
  //podemos registrarlo con get_it y tener control total sobre las dependecias
  final List<Inscripcion> _inscripciones = [];

  ///CANCELAR
  @override
  Future<void> eliminarInscripcion(int idUsuario, int idClase) async {
    _inscripciones.removeWhere((inscripcion) =>
        inscripcion.idUsuario == idUsuario && inscripcion.idClase == idClase);
  }

  ///INSCRIBIR
  @override
  Future<void> agregarInscripcion(Inscripcion inscripcion) async {
    _inscripciones.add(inscripcion);
  }

  @override
  Future<List<Inscripcion>> obtenerInscripciones() async {
    return _inscripciones;
  }
}
