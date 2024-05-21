import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_expection.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/domain/model/conta/pessoa_favorita/pagamento_model.dart';

class PagamentoService {
  final ClientIHttp client;

  PagamentoService(this.client);

  Future<void> post({required PagamentoModel pagamento}) async {
    try {
      await client.post(ClientEndPoint.pagamento, pagamento.toJson());
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }
}
