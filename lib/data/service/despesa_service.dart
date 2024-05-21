import 'package:dio/dio.dart';
import 'package:drinkeat/cors/client/client_end_point.dart';
import 'package:drinkeat/cors/client/client_expection.dart';
import 'package:drinkeat/cors/client/client_ihttp.dart';
import 'package:drinkeat/domain/model/conta/despesa_model.dart';

class DespesaService {
  final ClientIHttp client;

  DespesaService(this.client);

  Future<void> post({required DespesaModel despesa}) async {
    try {
      await client.post(ClientEndPoint.despesa, despesa.toJson());
    } on DioException catch (e) {
      throw ClientException(statusCode: e.response?.statusCode);
    }
  }
}
