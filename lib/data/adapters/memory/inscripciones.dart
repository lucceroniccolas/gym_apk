import 'package:gym_apk/domain/entities/inscripcion.dart';
import 'package:gym_apk/domain/repository/repo_inscripcion.dart';
import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/entities/usuario.dart';

class MemoriaInscripcionesImpl implements RepoInscripcion {
  static final MemoriaInscripcionesImpl _instanciaInscripciones =
      MemoriaInscripcionesImpl._privado();

  MemoriaInscripcionesImpl._privado();

  factory MemoriaInscripcionesImpl() {
    return _instanciaInscripciones;
  }

  final List<Inscripcion> _inscripciones = [];
  late final List<Usuario> _usuarios;
  late final List<Clase> _clases;

  void inicializar(List<Usuario> usuarios, List<Clase> clases){_usuarios = usuarios; _clases = clases;}

  @override
  Future<void> cancelarInscripcion(int idUsuario, int idClase) {
    // TODO: implement cancelarInscripcion
    throw UnimplementedError();
  }

  @override
  Future<bool> inscribirUsuarioEnClase(int idUsuario, int idClase) {
//Verificamos si existe alumno
  final usuarioExiste = _usuarios.any((u)=>u.idUsuario == idUsuario);

//Verificamos si existe clase
  final claseExiste = _clases.any((c)=> c.idClase== idClase);

    // Verificamos si el alumno ya está inscripto a la clase
    final existe = _inscripciones
        .any((i) => i.idUsuario == idUsuario && i.idClase == idClase);
    if (existe) return Future.value(false);
    
// generamos nuevo id de inscripción única
 final nuevoID = _inscripciones.isEmpty ? 1 : _inscripciones.map((i)=>i.idInscripcion).reduce((a,b)=>a>b ? a:b)+1;
    final nuevaInscripcion = Inscripcion(idInscripcion: nuevoID, idUsuario: idUsuario, fechaInscripcion: DateTime.now(), idClase: idClase);
    
    _inscripciones.add(nuevaInscripcion);
      
    return Future.value(true);
  }}

  @override
  Future<List<int>> obtenerClasesInscriptas(int idUsuario) {
    // TODO: implement obtenerClasesInscriptas
    throw UnimplementedError();
  }

  @override
  Future<List<int>> obtenerUsuarioInscriptos(int idClase) {
    // TODO: implement obtenerUsuarioInscriptos
    throw UnimplementedError();
  }
}
