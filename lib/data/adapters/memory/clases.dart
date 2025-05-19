import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';

class MemoriaClasesImpl implements RepoClases {
  //intancia estatica única que se crea UNA SOLA VEZ
  static final MemoriaClasesImpl _instanciaClases =
      MemoriaClasesImpl._privado();

// CONSTRUCTOR PRIVADO
  MemoriaClasesImpl._privado();

// DEVOLVEMOS LA INTANCIA
  factory MemoriaClasesImpl() {
    return _instanciaClases;
  }

  final List<Clase> _clases = [
    Clase(
        idClase: 1,
        nombreClase: "CrossFit Avanzado",
        descripcion: "Clase de crossfit 2hrs",
        // cupos: 10,
        horario: DateTime.now(),
        idProfesor: 1,
        inscriptos: [1])
  ];

  @override
  Future<void> borarClase(int idClase) async {
    _clases.removeWhere((clase) => clase.idClase == idClase);
  }

  @override
  Future<void> crearClase(Clase nuevaClase) async {
    _clases.add(nuevaClase);
  }

  @override
  Future<void> modificarClase(int idClase, Clase claseModificada) async {
    if (claseModificada.idClase <= 0) {
      throw Exception("Id de clase no válida");
    }
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
