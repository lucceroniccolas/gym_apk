import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';

class MemoriaClasesImpl implements RepoClases {
  //intancia estatica única que se crea UNA SOLA VEZ
  MemoriaClasesImpl();
  int _contadorId = 0;
// CONSTRUCTOR PRIVADO

  final List<Clase> _clases = [
    Clase(
      idClase: 0,
      nombreClase: "CrossFit Avanzado",
      descripcion: "Clase de crossfit 2hrs",
      horario: DateTime.now(),
      cupos: 5,
    ),
    Clase(
      idClase: 1,
      nombreClase: "Boxeo",
      descripcion: "Clase de boxeo 3hrs",
      cupos: 2,
      horario: DateTime.now(),
    )
  ];

  @override
  Future<void> actualizarClase(Clase claseActulizada) async {
    int index = _clases.indexWhere((c) => c.idClase == claseActulizada.idClase);
    if (index != -1) {
      _clases[index] = claseActulizada;
    }
  }

  @override
  Future<void> borarClase(int idClase) async {
    _clases.removeWhere((clase) => clase.idClase == idClase);
  }

  @override
  Future<void> crearClase(Clase nuevaClase) async {
    nuevaClase.idClase = _contadorId++;

    _clases.add(nuevaClase);
  }

  @override
  Future<void> modificarClase(int idClase, Clase claseModificada) async {
    final index = _clases.indexWhere((clase) => clase.idClase == idClase);
    if (index == -1) {
      final claseAnterior = _clases[index];
      _clases[index] = claseAnterior.copyWith(
        nombreClase: claseModificada.nombreClase,
        cupos: claseModificada.cupos,
        descripcion: claseModificada.descripcion ?? claseAnterior.descripcion,
        horario: claseModificada.horario ?? claseAnterior.horario,
      );
    }
  }

  @override
  Future<Clase?> obtenerClasePorId(int idClase) async {
    return _clases.firstWhere((clase) => clase.idClase == idClase);
  }

  @override
  Future<List<Clase>> obtenerClases() async {
    return _clases;
  }
}
