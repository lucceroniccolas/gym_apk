import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/entities/clases.dart';

class ModificarClaseCDU {
  final RepoClases repoClases;
  ModificarClaseCDU(this.repoClases);

  Future<bool> execute(int idClase, Clase claseModificada) async {
    //final claseExistente =
    // await repoClases.obtenerClasePorId(claseModificada.idClase);
    //if (claseExistente == null) {
    //throw Exception("El Rol con id: ${claseModificada.idClase} no existe.");
    // }
    try {
      await repoClases.modificarClase(idClase, claseModificada);
      return true;
    } catch (e) {
      return false;
    }
  }
}
