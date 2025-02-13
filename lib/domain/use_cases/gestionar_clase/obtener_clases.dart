import 'package:gym_apk/domain/entities/clases.dart';
import 'package:gym_apk/domain/repository/repo_clases.dart';

class ObtenerTodasLasClasesCDU {
  final RepoClases repoClase;
  ObtenerTodasLasClasesCDU(this.repoClase);

  Future<List<Clase>> call() async {
    return await repoClase.obtenerClases();
  }
}
