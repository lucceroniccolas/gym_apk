import 'package:gym_apk/domain/repository/repo_clases.dart';
import 'package:gym_apk/domain/entities/clases.dart';

class ModificarClaseCDU {
  final RepoClases repoClases;
  ModificarClaseCDU(this.repoClases);

  Future<void> call(Clase claseModificada) async {
    final claseExistente =
        await repoClases.obtenerClasePorId(claseModificada.idClase);
    if (claseExistente == null) {
      throw Exception("El Rol con id: ${claseModificada.idClase} no existe.");
    }
    await repoClases.crearClase(claseModificada);
  }
}
