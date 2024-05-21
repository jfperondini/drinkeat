class ClientException implements Exception {
  final int? statusCode;
  final String? message200,
      message201,
      message202,
      message204,
      message400,
      message401,
      message403,
      message404,
      message405,
      message407,
      message409,
      message417,
      message500;

  ClientException({
    required this.statusCode,
    this.message200,
    this.message201,
    this.message202,
    this.message204,
    this.message400,
    this.message401,
    this.message403,
    this.message404,
    this.message405,
    this.message407,
    this.message409,
    this.message417,
    this.message500,
  });

  Map get messageError => <int, String>{
        200: message200 ?? 'Okay (okay)',
        201: message201 ?? 'Created (criado)',
        202: message202 ?? 'Accepted (aceito)',
        204: message204 ?? 'No Content(Sem conteúdo)',
        400: message400 ?? 'Bad Request (requisição inválida)',
        401: message401 ?? 'Unauthorize (não autorizado)',
        403: message403 ?? 'Forbidden (acesso negado)',
        404: message404 ?? 'Not Found (não encontrado)',
        405: message405 ?? 'Method Not Allowed (metodo não permitido)',
        407: message407 ?? 'Not Acceptable (não aceitável)',
        409: message409 ?? 'Conflict (conflito)',
        417: message417 ?? 'Expectation Failed (expectativa falhou)',
        500: message500 ?? 'Internal Server Error (erro interno do servidor)',
      };
}
