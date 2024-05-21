import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_expection.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita.dart';

class PessoaFavoritaService {
  final ClientIHttp client;

  PessoaFavoritaService(this.client);

  Future<void> post({required PessoaFavoritaModel pessoaFavorita}) async {
    try {
      await client.post(ClientEndPoint.gasto, pessoaFavorita.toJson());
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }
}
