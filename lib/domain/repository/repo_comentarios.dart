abstract class RepoComentarios {
  Future<void> agregarComentario(int idClase, int idUsuario, String comentario);
  Future<void> eliminarComentario(int idComentario);
  Future<List<String>> obtenerComentariosPorClase(int idCLase);
}
