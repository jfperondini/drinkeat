abstract class ClientIHttp {
  // Pegar
  Future<dynamic> get(String path);
  // Criar
  Future<dynamic> post(String path, Map map);
  // Alterar tudo
  //Future<dynamic> put(String path, Map map);
  // Alterar especifico
  Future<dynamic> patch(String path, Map map, Map<String, dynamic>? queryParameters);
  // Deletar
  Future<dynamic> delete(String path, Map<String, dynamic>? queryParameters);
}
