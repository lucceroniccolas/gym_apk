import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';

class MemoriaClasesImpl implements RepoClases {
  //intancia estatica única que se crea UNA SOLA VEZ
  MemoriaClasesImpl();

// CONSTRUCTOR PRIVADO

  final List<Clase> _clases = [
    Clase(
        idClase: 0,
        nombreClase: "CrossFit Avanzado",
        descripcion: "Clase de crossfit 2hrs",
        horario: DateTime.now(),
        cupos: 5,
        idProfesor: 1,
        inscriptos: [1]),
    Clase(
        idClase: 1,
        nombreClase: "Boxeo",
        descripcion: "Clase de boxeo 3hrs",
        cupos: 2,
        horario: DateTime.now(),
        idProfesor: 3,
        inscriptos: [3])
  ];

  @override
  Future<void> actualizarClase(Clase claseActulizada) async {
    int index = _clases.indexWhere((c) => c.idClase == claseActulizada.idClase);
    if (index != -1) {
      _clases[index] = claseActulizada;
    } else {
      throw Exception("Clase no encontrada para actualizar.");
    }
  }

  @override
  Future<void> borarClase(int idClase) async {
    _clases.removeWhere((clase) => clase.idClase == idClase);
  }

  @override
  Future<void> crearClase(Clase nuevaClase) async {
    nuevaClase.idClase = _clases.length + 1;

    _clases.add(nuevaClase);
  }

  @override
  Future<void> modificarClase(int idClase, Clase claseModificada) async {
    final index = _clases.indexWhere((clase) => clase.idClase == idClase);
    if (index == -1) {
      throw Exception("Clase con id ${claseModificada.idClase} no encontrada ");
    }
    if (claseModificada.idClase != idClase) {
      throw Exception(
          "¿Que hacemos trollins?, No se puede modificar el ID de la clase.");
    }
    final claseAnterior = _clases[index];
    _clases[index] = claseAnterior.copyWith(
      nombreClase: claseModificada.nombreClase,
      cupos: claseModificada.cupos ?? claseAnterior.cupos,
      descripcion: claseModificada.descripcion ?? claseAnterior.descripcion,
      horario: claseModificada.horario ?? claseAnterior.horario,
      idProfesor: claseModificada.idProfesor ?? claseAnterior.idProfesor,
      inscriptos: claseModificada.inscriptos ?? claseAnterior.inscriptos,
    );
  }

  @override
  Future<Clase?> obtenerClasePorId(int idClase) async {
    return _clases.firstWhere((clase) => clase.idClase == idClase);
  }

  @override
  Future<List<Clase>> obtenerClases() async {
    return _clases;
  }

  @override
  Future<DateTime?> obtenerHorariosPorIdClase(int idClase) async {
    final clase = _clases.firstWhere(
      (clase) => clase.idClase == idClase,
      orElse: () => throw Exception("clase con id $idClase no encontrado"),
    );
    return clase.horario;
  }
}
