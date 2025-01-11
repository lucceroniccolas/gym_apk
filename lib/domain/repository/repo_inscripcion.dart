abstract class RepoInscripcion {
  Future<void> inscribirUsuarioEnClase(int idUsuario, int idClase);
  Future<void> cancelarInscripcion(int idUsuario, int idClase);
  Future<List<int>> obtenerUsuarioisInscriptos(int idClase);
  Future<List<int>> obtenerClasesInscriptas(int idUsuario);
}
