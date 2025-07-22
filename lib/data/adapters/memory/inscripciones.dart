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
  Future<List<Clase>> obtenerClasesInscriptasDeUsuario(int idUsuario) async {
    List<int> idsClases = _inscripciones
        .where((inscripcion) =>
            inscripcion.idUsuario ==
            idUsuario) //Filtramos todas las inscripciones donde coincida el idUsu
        .map((inscripcion) =>
            inscripcion.idClase) //extraemos solo los idClase de la inscripcion
        .toList(); //devolvemos una Lista de enteros con todos los IDs de clases a las que está inscrito

    List<Clase> clases =
        []; //creamos una lista donde se guardarán las clases completas (no solo los IDs)

    for (int id in idsClases) {
      //recorremos los idClases buscando la clase correspondiente (repo.obtenerClasesporID)
      Clase? clase = await _repoClases.obtenerClasePorId(id);
      if (clase != null) {
        clases.add(clase); //si existe la clase la agregamos a la lista
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
